import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:collection/collection.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/utilities/fix_trailing_comma.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';
import 'package:path/path.dart' as path;

import '../context.dart';
import '../utilities/freezed_data_class.dart';

class ResponseGenerator {
  const ResponseGenerator();

  static String? getResultType(
    Context context,
    APIResponse response,
  ) {
    final content = response.content;
    if (content != null && content.isNotEmpty) {
      final json = content['application/json'] ?? content.entries.first.value;
      if (json != null) {
        final schema = json.schema;
        if (schema != null) {
          final referenceURI = schema.referenceURI;
          if (referenceURI != null) {
            return context.findSchemaName(referenceURI);
          }
        }
      }
    }

    return null;
  }

  List<DataProperty> _buildResponseProperties(
    Context context,
    APIResponse? response,
  ) {
    final result = <DataProperty>[
      DataProperty(
        name: 'response',
        type: DataReferenceType('Response'),
        required: true,
      ),
    ];

    if (response != null) {
      final resultType = getResultType(context, response);

      if (resultType != null) {
        result.add(
          DataProperty(
            name: 'result',
            type: DataReferenceType(resultType),
            required: true,
          ),
        );
      }
    }

    return result;
  }

  DataUnion? _buildType(
    Context context,
    String operationId,
    APIOperation operation,
  ) {
    final baseName = operationId;
    final responses = operation.responses;
    final responseEntries = responses?.entries;
    return DataUnion(
      name: baseName,
      children: [
        if (responseEntries != null && responseEntries.isNotEmpty)
          ...responseEntries
              .where((e) => e.value != null && e.key.toLowerCase() != 'default')
              .map(
            (e) {
              final name = '$baseName${e.key.asClassName()}';
              return DataUnionCase(
                factoryName: 'status${e.key.asClassName()}',
                value: DataClass(
                  name: name,
                  properties: _buildResponseProperties(context, e.value!),
                ),
              );
            },
          ),
        DataUnionCase(
          factoryName: 'fallback',
          value: DataClass(
            name: '${baseName}Fallback',
            properties:
                _buildResponseProperties(context, responses?['default']),
          ),
        )
      ],
    );
  }

  Future<void> generate(
    Context context,
  ) async {
    final output =
        File(path.join(context.outputDirectory.path, 'lib', 'responses.dart'));
    final paths = context.definition.paths;
    if (paths != null) {
      final library = LibraryBuilder();

      library.directives.addAll([
        Directive.import('package:dio/dio.dart'),
        Directive.import('package:freezed_annotation/freezed_annotation.dart'),
        Directive.import('model.dart'),
        Directive.part('responses.freezed.dart'),
      ]);

      for (var entry in paths.entries) {
        var path = entry.value;
        if (path != null) {
          final newClasses = generatePath(context, entry.key, path);
          library.body.addAll(newClasses);
        }

        final emitter = DartEmitter();
        final source = '${library.build().accept(emitter)}'.fixTrailingCommas();
        final formatted = DartFormatter().format(source);

        await output.writeAsString(formatted);
      }
    }
  }

  List<Spec> generatePath(
    Context context,
    String name,
    APIPath path,
  ) {
    return [
      ...path.operations.entries
          .where((e) => e.value != null)
          .map((e) => generateOperation(
                context,
                e.key,
                e.value!,
              ))
          .whereNotNull()
    ];
  }

  Spec? generateOperation(
    Context context,
    String method,
    APIOperation operation,
  ) {
    final className = createOperationResponseTypeName(method, operation);
    final dataType = _buildType(context, className, operation);
    if (dataType != null) {
      final builder =
          FreezedDataClassBuilder(withJson: false).buildDataUnion(dataType);

      final defaultFactory = ConstructorBuilder()..factory = true;

      defaultFactory.requiredParameters.add(
        Parameter(
          (b) => b
            ..name = 'response'
            ..type = refer('Response'),
        ),
      );

      var responses = operation.responses;

/*
   if (response.statusCode == 200) {
      return ListPetsResponse.status200(
        response: response,
        result: [...(response.data as List).map((e) => Pet.fromJson(e))],
      );
    }
    return ListPetsResponse.fallback(
      response: response,
      result: Error.fromJson(response.data),
    );*/
      final code = StringBuffer();

      if (responses != null) {
        void addResultProperty(String? resultType) {
          if (resultType != null) {
            final schema = context.getSchema(resultType);
            final result = context.fromJsonInstance(schema, 'response.data');
            code.writeln('result: $result,');
          }
        }

        for (var response in responses.entries) {
          final value = response.value;
          if (value != null) {
            if (response.key != 'default') {
              final resultType = getResultType(context, value);
              code.writeln('if (response.statusCode == ${response.key}) {');
              code.writeln('return $className.status${response.key}(');
              code.writeln('response: response,');
              addResultProperty(resultType);
              code.writeln(');');
              code.writeln('}');
            }
          }
        }

        final defaultResponse = responses['default'];
        code.writeln('return $className.fallback(');
        code.writeln('response: response,');
        if (defaultResponse != null) {
          final resultType = getResultType(context, defaultResponse);
          addResultProperty(resultType);
        }
        code.writeln(');');
      }

      defaultFactory.body = Code(code.toString());

      builder.constructors.add(defaultFactory.build());

      return builder.build();
    }

    return null;
  }

  static String createOperationResponseTypeName(
      String method, APIOperation operation) {
    return (operation.id ?? '').asClassName() + 'Response';
  }
}
