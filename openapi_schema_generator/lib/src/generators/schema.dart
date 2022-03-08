import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/utilities/fix_trailing_comma.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';
import 'package:openapi_schema_generator/src/utilities/oneof_class.dart';
import 'package:path/path.dart' as path;

import '../context.dart';
import '../utilities/freezed_data_class.dart';

class SchemaGenerator {
  const SchemaGenerator();

  APISchemaObject _mergeAllOfSchema(
      Context context, APISchemaObject schema, List<APISchemaObject?> allOf) {
    final mergedSchema = APISchemaObject();
    mergedSchema.description = schema.description;
    mergedSchema.type = schema.type;
    mergedSchema.format = schema.format;
    mergedSchema.defaultValue = schema.defaultValue;
    mergedSchema.properties = {
      ...schema.properties ?? const <String, APISchemaObject?>{},
    };
    mergedSchema.required = [
      ...schema.required ?? const <String>[],
    ];

    for (var child in allOf) {
      if (child != null) {
        final ref = child.referenceURI;
        if (ref != null) {
          final resolvedSchema = context.resolveSchemaReference(ref);
          context.logger.info(' - from `$ref` schema...');
          mergedSchema.type ??= resolvedSchema.type ?? APIType.object;
          mergedSchema.properties = {
            ...mergedSchema.properties ?? const <String, APISchemaObject?>{},
            ...resolvedSchema.properties ?? const <String, APISchemaObject?>{},
          };

          mergedSchema.required = [
            ...mergedSchema.required ?? const <String>[],
            ...resolvedSchema.required ?? const <String>[],
          ];
        } else {
          context.logger.warning(
              'When using `allOf`, only referenced models (`\$ref`) work');
        }
      }
    }

    return mergedSchema;
  }

  Future<void> generate(
    Context context,
  ) async {
    final output =
        File(path.join(context.outputDirectory.path, 'lib', 'model.dart'));
    final components = context.definition.components;
    if (components != null) {
      final schemas = components.schemas;
      if (schemas != null) {
        final library = LibraryBuilder();

        library.directives.addAll([
          Directive.import(
              'package:freezed_annotation/freezed_annotation.dart'),
          Directive.part('model.freezed.dart'),
          Directive.part('model.g.dart'),
        ]);

        for (var entry in schemas.entries) {
          var schema = entry.value;
          if (schema != null) {
            if (schema.type == APIType.array) {
              final childRef = schema.items?.referenceURI;
              if (childRef != null) {
                final itemName = context.findSchemaName(childRef);
                library.body.add(Code(
                    'typedef ${entry.key.asClassName()} = List<$itemName>;'));
              }
            } else {
              // If allOf, then we merge all properties before generating class
              final allOf = schema.allOf;
              if (allOf != null && allOf.isNotEmpty) {
                context.logger.info(
                    'Merging all properties of class for `${entry.key}` schema...');
                schema = _mergeAllOfSchema(context, schema, allOf);
              }

              final newClass = generateSchema(context, entry.key, schema);
              if (newClass != null) {
                library.body.add(newClass);
              }
            }
          }
        }

        final emitter = DartEmitter();
        final source = '${library.build().accept(emitter)}'.fixTrailingCommas();
        final formatted = DartFormatter().format(source);

        await output.writeAsString(formatted);
      }
    }
  }

  Spec? generateEnum(
    Context context,
    String name,
    APISchemaObject schema,
  ) {
    final enumerated = schema.enumerated;
    final builder = FreezedDataClassBuilder();
    return builder.build(DataEnum(
      name: name.asClassName(),
      values: [
        if (enumerated != null) ...enumerated.map((e) => e.toString()),
      ],
    ));
  }

  Spec generateOneOf(
    Context context,
    String name,
    APISchemaObject schema,
    List<APISchemaObject?> oneOf,
  ) {
    final childTypes = <String>[];
    for (var child in oneOf) {
      final uri = child?.referenceURI;
      if (uri != null) {
        final childTypeName = context.findSchemaName(uri);
        childTypes.add(childTypeName);
      }
    }

    final builder = OneOfClassBuilder();
    return builder.build(name, childTypes);
  }

  Spec? generateSchema(
    Context context,
    String name,
    APISchemaObject schema,
  ) {
    final oneOf = schema.oneOf;
    if (oneOf != null && oneOf.isNotEmpty) {
      context.logger.info('Generating union type for `$name` schema...');

      if (oneOf
          .any((e) => e?.type == APIType.object && e?.referenceURI == null)) {
        context.logger.warning(
            'When using `oneOf`, only referenced object models (`\$ref`) work');
      }

      return generateOneOf(context, name, schema, oneOf);
    }

    if (schema.type == APIType.string &&
        (schema.enumerated?.isNotEmpty ?? false)) {
      context.logger.info('Generating enum type for `$name` schema...');
      return generateEnum(context, name, schema);
    }

    if (schema.type == APIType.object) {
      context.logger.info('Generating a class for `$name` schema...');
      final properties = schema.properties;
      final builder = FreezedDataClassBuilder();
      return builder.build(DataClass(
        name: name.asClassName(),
        properties: [
          if (properties != null && properties.isNotEmpty)
            ...properties.entries.where((e) => e.value != null).map(
                  (e) => DataProperty(
                    name: e.key,
                    required: schema.required?.contains(e.key) ?? false,
                    type: context.findDartType(e.value),
                  ),
                ),
        ],
      ));
    }

    return null;
  }
}
