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
        'Running `${operation['operationId']}` operation';
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
    final regexp = RegExp(r'\$\{\{([a-zA-Z\_\-0-9]+)\}\}');
    RegExpMatch? match;
    while ((match = regexp.firstMatch(result)) != null) {
      final name = match!.group(1);
      result = result.replaceRange(
          match.start, match.end, Platform.environment[name] ?? '<$name?>');
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
      case 'listPets':
        return listPets(
          limit: params['limit']?.toInt(),
        );

      case 'createPets':
        final decodedBody = Pet.fromJson(body);
        return createPets(
          decodedBody,
        );

      case 'showPetById':
        return showPetById(
          petId: params['petId'].toString(),
        );

      default:
        throw Exception('Invalid operation id');
    }
  }
}
