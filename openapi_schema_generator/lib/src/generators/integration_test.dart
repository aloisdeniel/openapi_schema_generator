import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_style/dart_style.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/context.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';
import 'package:path/path.dart' as path;

class IntegrationTestGenerator {
  const IntegrationTestGenerator();

  Future<void> generate(
    Context context,
  ) async {
    context.logger.info('[Integration tests]');
    final output = File(path.join(
        context.outputDirectory.path, 'test', 'integration_test.dart'));

    final allOperations = context.definition.paths?.entries
            .expand<APIOperation?>((x) {
              final operations = x.value?.operations.values;
              if (operations == null) return <APIOperation?>[];
              return operations;
            })
            .whereNotNull()
            .toList() ??
        <APIOperation>[];

    final operationCases = [
      ...allOperations.map((o) => _operationCase(context, o)),
    ];

    final result = _template(operationCases);

    final formatted = DartFormatter().format(result);

    await output.writeAsString(formatted);
  }
}

String _operationCase(Context context, APIOperation operation) {
  context.logger.info('  - For \'${operation.id}\' operation...');
  final result = StringBuffer();

  result.writeln('case \'${operation.id}\':');

  final body = operation.requestBody;
  if (body != null) {
    final bodySchema = body.content?['application/json']?.schema;
    if (bodySchema != null) {
      result.writeln(
          'final decodedBody = ${context.fromJsonInstance(bodySchema, 'body')};');
    }
  }
  result.writeln('return ${operation.id?.asFieldName()}(');

  if (body != null) {
    result.writeln('decodedBody,');
  }

  final parameters = operation.parameters;
  if (parameters != null) {
    for (var parameter in parameters) {
      final name = parameter?.name?.asFieldName();
      result.write('$name: params[\'${parameter?.name}\']');
      if (!(parameter?.isRequired ?? false)) {
        result.write('?');
      }
      switch (parameter?.schema?.type) {
        case APIType.string:
          result.write('.toString()');
          break;
        case APIType.integer:
          result.write('.toInt()');
          break;
        case APIType.number:
          result.write('.toDouble()');
          break;
        default:
          break;
      }
      result.write(',');
    }
  }

  result.writeln(');');

  return result.toString();
}

String _template(List<String> operationCases) {
  return '''
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test/test.dart';

import '../lib/api.dart';
import '../lib/model.dart';

Future<void> main() async {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  // Loading data from file
  final testData =
      Platform.environment['API_TEST_DATA_FILE'] ?? 'api_test_data.json';
  final data = await File(testData).readAsString();
  final json = jsonDecode(data.injectEnvironmentVariables());

  final baseUrl = json['server'] as String;
  final operations = json['operations'] as List;
  final globalHeaders = json['headers'] as Map<String, dynamic>?;

  for (var operation in operations) {
    final description = operation['description'] as String? ??
        'Running `\${operation['operationId']}` operation';
    test(description, () async {
      final api = createApi(
        baseUrl: baseUrl,
        globalHeaders: globalHeaders,
        operation: operation,
      );

      final response = await api.executeFromData(operation);
      expect(response, isNotNull);
    });
  }
}

Api createApi({
  required String baseUrl,
  required Map<String, dynamic>? globalHeaders,
  required dynamic operation,
}) {
  final localHeaders = operation['headers'] as Map<String, dynamic>?;
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        if (globalHeaders != null) ...globalHeaders,
        if (localHeaders != null) ...localHeaders,
      },
    ),
  );

  return Api(
    client: dio,
  );
}

extension EnvironmentVariableTemplateExtentions on String {
  String injectEnvironmentVariables() {
    var result = this;
    final regexp = RegExp(r'\\\$\\{\\{([a-zA-Z\\_\\-0-9]+)\\}\\}');
    RegExpMatch? match;
    while ((match = regexp.firstMatch(result)) != null) {
      final name = match!.group(1);
      result = result.replaceRange(
          match.start, match.end, Platform.environment[name] ?? '<\$name?>');
    }
    return result;
  }
}

extension ApiTestExtensions on Api {
  Future<dynamic> executeFromData(dynamic operation) {
    // Mapping data to operation call
    final operationId = operation['operationId'] as String;
    final params = operation['params'] as Map<String, dynamic>? ?? {};
    final body = operation['body'] as dynamic;
    switch (operationId) {
      ${operationCases.join('\n')}
      default:
        throw Exception('Invalid operation id');
    }
  }
}
''';
}
