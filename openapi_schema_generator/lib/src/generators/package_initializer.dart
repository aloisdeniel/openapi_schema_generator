import 'dart:io';

import 'package:openapi_schema_generator/src/context.dart';
import 'package:path/path.dart' as path;

class PackageInitializer {
  const PackageInitializer();
  String generatePubspec({
    required String name,
    required String description,
  }) {
    return '''name: $name
description: $description
version: 1.0.0

environment:
  sdk: '>=2.16.1 <3.0.0'

dependencies:
  dio: '>=4.0.0 <5.0.0'
  freezed_annotation: ^1.1.0

dev_dependencies:
  build_runner: ^2.1.7
  freezed: ^1.1.1
  json_serializable: ^6.1.4
  lints: ^1.0.0''';
  }

  Future<void> initialize(Context context) async {
    final pubspec =
        File(path.join(context.outputDirectory.path, 'pubspec.yaml'));
    if (!pubspec.existsSync()) {
      await pubspec.writeAsString(generatePubspec(
        name: context.options.packageName,
        description: context.options.packageDescription,
      ));
    }

    final lib = Directory(path.join(context.outputDirectory.path, 'lib'));
    if (!lib.existsSync()) {
      await lib.create(recursive: true);
    }
  }
}
