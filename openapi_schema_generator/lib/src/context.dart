import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:open_api_forked/v3.dart';

import 'options.dart';
import 'utilities/freezed_data_class.dart';

class Context {
  const Context({
    required this.options,
    required this.definition,
    required this.outputDirectory,
    Logger? logger,
  }) : _logger = logger;
  final Options options;
  final APIDocument definition;
  final Directory outputDirectory;
  final Logger? _logger;

  Logger get logger => _logger ?? Logger.root;

  String findSchemaName(Uri uri) {
    final schemas = definition.components?.schemas;
    if (schemas != null &&
        uri.pathSegments.length == 3 &&
        uri.pathSegments[0] == 'components' &&
        uri.pathSegments[1] == 'schemas') {
      return uri.pathSegments.last;
    }
    throw Exception('The schema with `$uri` reference has not be found');
  }

  APISchemaObject resolveSchemaReference(Uri uri) {
    final schemas = definition.components?.schemas;
    if (schemas != null) {
      final name = findSchemaName(uri);
      final result = schemas[name];
      if (result != null) {
        return result;
      }
    }
    throw Exception('The schema with `$uri` reference has not be found');
  }

  APISchemaObject getSchema(String name) {
    final schemas = definition.components?.schemas;
    if (schemas != null) {
      final result = schemas[name];
      if (result != null) {
        return result;
      }
    }
    throw Exception('The schema with `$name` name has not be found');
  }

  String toJsonInstance(
    APISchemaObject schema,
    String jsonVariableName,
  ) {
    final reference = schema.referenceURI;
    if (reference != null && reference.pathSegments.isNotEmpty) {
      final resolvedSchema = resolveSchemaReference(reference);
      if (resolvedSchema.type == APIType.array) {
        return toJsonInstance(resolvedSchema, jsonVariableName);
      } else {
        return '$jsonVariableName.toJson()';
      }
    }
    final type = schema.type;
    switch (type) {
      case APIType.integer:
      case APIType.number:
      case APIType.string:
      case APIType.boolean:
        return jsonVariableName;
      case APIType.array:
        final items = schema.items;
        if (items != null) {
          return '[...$jsonVariableName.map((e) => ${toJsonInstance(
            items,
            'e',
          )})]';
        }
        return jsonVariableName;
      default:
        return '$jsonVariableName.toJson()';
    }
  }

  String fromJsonInstance(
    APISchemaObject schema,
    String jsonVariableName,
  ) {
    final reference = schema.referenceURI;
    if (reference != null && reference.pathSegments.isNotEmpty) {
      final resolvedSchema = resolveSchemaReference(reference);
      if (resolvedSchema.type == APIType.array) {
        return fromJsonInstance(resolvedSchema, jsonVariableName);
      } else {
        final schemaName = findSchemaName(reference);
        return '$schemaName.fromJson($jsonVariableName)';
      }
    }
    final type = schema.type;
    switch (type) {
      case APIType.integer:
        return '$jsonVariableName.toInt()';
      case APIType.number:
        return jsonVariableName;
      case APIType.string:
        return '$jsonVariableName.toString()';
      case APIType.boolean:
        return jsonVariableName;
      case APIType.array:
        final items = schema.items;
        if (items != null) {
          return '[...($jsonVariableName as List).map((e) => ${fromJsonInstance(
            items,
            'e',
          )})]';
        }
        return jsonVariableName;
      default:
        return jsonVariableName;
    }
  }

  DataType findDartType(APISchemaObject? schema) {
    final reference = schema?.referenceURI;
    if (reference != null && reference.pathSegments.isNotEmpty) {
      return DataReferenceType(findSchemaName(reference));
    }
    final type = schema?.type;
    if (type == null) return DataRawType('dynamic');
    switch (type) {
      case APIType.integer:
        return DataRawType('int');
      case APIType.number:
        return DataRawType('num');
      case APIType.string:
        return DataRawType('String');
      case APIType.boolean:
        return DataRawType('bool');
      case APIType.array:
        final items = schema?.items;
        if (items != null) {
          return DataListType(findDartType(items));
        }
        return DataRawType('dynamic');
      case APIType.object:
        return DataRawType('dynamic');
    }
  }

  static Future<Context> fromOptions(Options options) async {
    final file = File(options.file);
    final contents = await file.readAsString();
    final definition = APIDocument.fromMap(jsonDecode(contents));

    return Context(
      options: options,
      definition: definition,
      outputDirectory: Directory(options.output),
    );
  }
}
