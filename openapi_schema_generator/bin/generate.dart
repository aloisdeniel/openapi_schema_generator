import 'dart:io';

import 'package:logging/logging.dart';
import 'package:openapi_schema_generator/src/context.dart';
import 'package:openapi_schema_generator/src/generators/api.dart';
import 'package:openapi_schema_generator/src/generators/integration_test.dart';
import 'package:openapi_schema_generator/src/generators/package_initializer.dart';
import 'package:openapi_schema_generator/src/generators/response.dart';
import 'package:openapi_schema_generator/src/options.dart';
import 'package:openapi_schema_generator/src/generators/schema/schema.dart';

Future<void> main(List<String> arguments) async {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    print('[${record.level.name}] ${record.message}');
  });

  final options = Options.parse(arguments);

  if (!File(options.file).existsSync()) {
    throw 'The \'${options.file}\' doesn\'t exists.';
  }

  final context = await Context.fromOptions(options);

  await const PackageInitializer().initialize(context);

  const schemas = SchemaGenerator();
  await schemas.generate(context);

  const responses = ResponseGenerator();
  await responses.generate(context);

  const api = ApiGenerator();
  await api.generate(context);

  if (options.integrationTests) {
    const integrationTest = IntegrationTestGenerator();
    await integrationTest.generate(context);
  }
}
