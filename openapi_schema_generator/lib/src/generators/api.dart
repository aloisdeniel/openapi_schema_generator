import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/utilities/fix_trailing_comma.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';
import 'package:path/path.dart' as path;

import '../context.dart';
import 'response.dart';

class ApiGenerator {
  const ApiGenerator();

  Future<void> generate(
    Context context,
  ) async {
    final output =
        File(path.join(context.outputDirectory.path, 'lib', 'api.dart'));
    final paths = context.definition.paths;
    if (paths != null) {
      final library = LibraryBuilder();

      library.directives.addAll([
        Directive.import('package:dio/dio.dart'),
        Directive.import('responses.dart'),
        Directive.import('model.dart'),
      ]);

      final builder = ClassBuilder()..name = 'Api';

      // Server urls
      final servers = context.definition.servers;
      if (servers != null && servers.isNotEmpty) {
        builder.fields.add(Field(
          (b) => b
            ..name = 'servers'
            ..static = true
            ..type = refer('List<String>')
            ..assignment = Code('[' +
                servers.map((server) => '\'${server?.url}\',').join() +
                ']'),
        ));
      }

      builder.fields.add(Field((b) => b
        ..name = 'client'
        ..modifier = FieldModifier.final$
        ..type = refer('Dio')));
      builder.constructors.add(
        Constructor(
          (b) => b
            ..constant = true
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..name = 'client'
                  ..required = true
                  ..named = true
                  ..toThis = true,
              ),
            ),
        ),
      );

      for (var entry in paths.entries) {
        final uri = entry.key;
        final path = entry.value;
        if (path != null) {
          final operations = entry.value?.operations;
          if (operations != null) {
            for (var entry in operations.entries) {
              var method = entry.key;
              var operation = entry.value;
              if (operation != null) {
                final newMethod = generateOperation(
                  context,
                  uri,
                  path,
                  method,
                  operation,
                );
                builder.methods.add(newMethod);
              }
            }
          }
        }
      }

      library.body.add(builder.build());

      final emitter = DartEmitter();
      final source = '${library.build().accept(emitter)}'.fixTrailingCommas();
      final formatted = DartFormatter().format(source);

      await output.writeAsString(formatted);
    }
  }

  Method generateOperation(
    Context context,
    String uri,
    APIPath path,
    String method,
    APIOperation operation,
  ) {
    final methodName = createOperationName(method, operation);
    final responseType =
        ResponseGenerator.createOperationResponseTypeName(method, operation);

    final builder = MethodBuilder()
      ..name = methodName
      ..modifier = MethodModifier.async
      ..returns = refer('Future<$responseType>');

    final summary = operation.summary;
    if (summary != null) {
      builder.docs.add('/// $summary');
    }

    final requestBody = operation.requestBody;
    if (requestBody != null) {
      if (requestBody.description != null) {
        builder.docs.add('///');
        builder.docs.add('/// Body : ${requestBody.description}');
      }
      final requetsBodySchema =
          requestBody.content?['application/json']?.schema;

      final type = context.findDartType(requetsBodySchema);
      final param = ParameterBuilder()
        ..name = 'body'
        ..type = refer(type.name);

      builder.requiredParameters.add(param.build());
    }

    final parameters = operation.parameters;
    if (parameters != null && parameters.isNotEmpty) {
      builder.docs.add('///');
      builder.docs.add('/// Parameters :');
      for (var parameter in parameters) {
        if (parameter != null) {
          final name = parameter.name?.asFieldName();
          if (name != null) {
            final type = context.findDartType(parameter.schema);
            final param = ParameterBuilder()
              ..name = name
              ..named = true
              ..required = parameter.isRequired
              ..type = refer(type.name + (parameter.isRequired ? '' : '?'));

            builder.optionalParameters.add(param.build());

            final description = parameter.description;
            builder.docs.add(
                '///   * $name ${(description != null) ? ': $description' : ''}');
          }
        }
      }
    }

    builder.optionalParameters.addAll([
      Parameter(
        (b) => b
          ..name = 'cancelToken'
          ..named = true
          ..type = refer('CancelToken?'),
      ),
    ]);

    final code = StringBuffer();

    final pathParameters = operation.parameters?.where((x) =>
            x != null &&
            x.name != null &&
            x.location == APIParameterLocation.path) ??
        [];

    for (var parameter in pathParameters) {
      final key = parameter?.name;
      if (key != null) {
        final encodedParameter = 'Uri.encodeComponent($key.toString())';
        uri = uri.replaceAll('{$key}', '\${$encodedParameter}');
      }
    }
    code.write(
      'final response = await client.${method.toLowerCase()}(\'$uri\',',
    );

    code.write('cancelToken: cancelToken,');

    if (requestBody != null) {
      final requetsBodySchema =
          requestBody.content?['application/json']?.schema;
      if (requetsBodySchema != null) {
        code.write(
            'data: ${context.toJsonInstance(requetsBodySchema, 'body')},');
      }
    }

    final queryParameters = operation.parameters?.where((x) =>
            x != null &&
            x.name != null &&
            x.location == APIParameterLocation.query) ??
        [];

    if (queryParameters.isNotEmpty) {
      code.write(
        'queryParameters: {',
      );

      for (var queryParameter in queryParameters) {
        if (queryParameter != null) {
          if (!queryParameter.isRequired) {
            code.write('if(${queryParameter.name} != null)');
          }
          final encodedParameter =
              'Uri.encodeQueryComponent(${queryParameter.name}.toString())';
          code.write('\'${queryParameter.name}\': $encodedParameter,');
        }
      }

      code.write(
        '},',
      );
    }

    code.writeln('options: Options('
        'headers: { \'Content-Type\' : \'application/json\',}'
        ',),');

    code.writeln(');');

    code.writeln('return $responseType(response);');

    builder.body = Code(code.toString());

    return builder.build();
  }

  static String createOperationName(String method, APIOperation operation) {
    return (operation.id ?? '').asFieldName();
  }
}
