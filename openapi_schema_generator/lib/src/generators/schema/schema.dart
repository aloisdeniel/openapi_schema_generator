import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/utilities/fix_trailing_comma.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';
import 'package:path/path.dart' as path;

import '../../context.dart';
import '../../utilities/freezed_data_class.dart';
import 'allof_class.dart';
import 'oneof_class.dart';
import 'anyof_class.dart';

class SchemaGenerator {
  const SchemaGenerator();

  Future<void> generate(
    Context context,
  ) async {
    context.logger.info('[Schemas]');
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
            if (const [
                  APIType.array,
                  APIType.string,
                  APIType.integer,
                  APIType.number,
                  APIType.boolean,
                ].contains(schema.type) &&
                schema.enumerated == null) {
              final newType = generateTypeAlias(context, entry.key, schema);
              if (newType != null) library.body.add(newType);
            } else {
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

  Spec? generateTypeAlias(
    Context context,
    String name,
    APISchemaObject schema,
  ) {
    if (schema.type == APIType.array) {
      final childRef = schema.items?.referenceURI;
      if (childRef != null) {
        final itemName = context.findSchemaName(childRef);
        return Code('typedef ${name.asClassName()} = List<$itemName>;');
      }
    }
    if (schema.type == APIType.integer) {
      return Code('typedef ${name.asClassName()} = int;');
    }
    if (schema.type == APIType.number) {
      return Code('typedef ${name.asClassName()} = num;');
    }
    if (schema.type == APIType.string) {
      return Code('typedef ${name.asClassName()} = String;');
    }
    if (schema.type == APIType.boolean) {
      return Code('typedef ${name.asClassName()} = bool;');
    }

    return null;
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
        if (enumerated != null)
          ...enumerated.map((e) => e.toString().asFieldName()),
      ],
    ));
  }

  Spec? generateSchema(
    Context context,
    String name,
    APISchemaObject schema,
  ) {
    // If allOf, then we merge all properties before generating class
    final allOf = schema.allOf;
    if (allOf != null && allOf.isNotEmpty) {
      context.logger.info(
          '  * Merging all properties of class for `$name` allOf schema...');
      return generateAllOf(context, name, schema, allOf);
    }
    final anyOf = schema.anyOf;
    if (anyOf != null && anyOf.isNotEmpty) {
      context.logger.info(
          '  * Merging all properties of class for `$name` anyOf schema...');
      return generateAnyOf(context, name, schema, anyOf);
    }
    final oneOf = schema.oneOf;
    if (oneOf != null && oneOf.isNotEmpty) {
      context.logger.info('Generating union type for `$name` oneOf schema...');

      if (oneOf
          .any((e) => e?.type == APIType.object && e?.referenceURI == null)) {
        context.logger.warning(
            '  When using `oneOf`, only referenced object models (`\$ref`) work');
      }

      return generateOneOf(context, name, schema, oneOf);
    }

    if (schema.type == APIType.string &&
        (schema.enumerated?.isNotEmpty ?? false)) {
      context.logger.info('  * Generating enum type for `$name` schema...');
      return generateEnum(context, name, schema);
    }

    if (schema.type == APIType.object) {
      context.logger.info('  * Generating a class for `$name` schema...');
      return generateObject(context, name, schema);
    }

    return null;
  }

  Spec generateObject(
    Context context,
    String name,
    APISchemaObject schema,
  ) {
    final properties = schema.properties;
    final builder = FreezedDataClassBuilder();
    final result = builder.buildClass(DataClass(
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

    // ValidateJson
    final validateJson = MethodBuilder()
      ..name = 'validateJson'
      ..static = true
      ..returns = refer('bool');

    validateJson.requiredParameters.add(
      Parameter(
        (b) => b
          ..name = 'json'
          ..type = refer('Map<String, dynamic>'),
      ),
    );

    final validateJsonBody = StringBuffer();

    if (properties != null && properties.isNotEmpty) {
      for (var property in properties.entries
          .where((p) => schema.required?.contains(p.key) ?? false)) {
        final propertySchema = property.value;
        if (propertySchema != null) {
          validateJsonBody.writeln(
              'if(!json.containsKey(\'${property.key}\') || !(${context.validateJsonInstance(propertySchema, 'json[\'${property.key}\']')}))');
          validateJsonBody.writeln('return false;');
        }
      }

      for (var property in properties.entries
          .where((p) => !(schema.required?.contains(p.key) ?? false))) {
        final propertySchema = property.value;
        if (propertySchema != null) {
          validateJsonBody.writeln(
              'if(json.containsKey(\'${property.key}\') && !(${context.validateJsonInstance(propertySchema, 'json[\'${property.key}\']')}))');
          validateJsonBody.writeln('return false;');
        }
      }
    }
    validateJsonBody.writeln('return true;');

    validateJson.body = Code(validateJsonBody.toString());
    result.methods.add(validateJson.build());

    return result.build();
  }

  Spec generateAllOf(
    Context context,
    String name,
    APISchemaObject schema,
    List<APISchemaObject?> children,
  ) {
    final builder = AllOfClassBuilder();
    return builder.build(context, name, schema, children);
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

  Spec generateAnyOf(
    Context context,
    String name,
    APISchemaObject schema,
    List<APISchemaObject?> oneOf,
  ) {
    final builder = AnyOfClassBuilder();
    return builder.build(context, name, oneOf);
  }
}
