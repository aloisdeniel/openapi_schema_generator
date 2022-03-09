import 'package:code_builder/code_builder.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/context.dart';
import 'package:openapi_schema_generator/src/utilities/freezed_data_class.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';

class AllOfClassBuilder {
  const AllOfClassBuilder({
    this.withJson = true,
  });

  final bool withJson;

  Spec build(
    Context context,
    String name,
    APISchemaObject schema,
    List<APISchemaObject?> children,
  ) {
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

    final asMethods = <Method>[];

    for (var child in children) {
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

          final childName = context.findSchemaName(ref).asClassName();

          final asMethod = MethodBuilder()
            ..name = 'as$childName'
            ..returns = refer(childName);

          final asBody = StringBuffer();

          asBody.writeln('return $childName(');

          for (var property in resolvedSchema.properties?.entries ??
              <MapEntry<String, APISchemaObject?>>[]) {
            final key = property.key.asFieldName();
            asBody.writeln('$key: $key,');
          }

          asBody.writeln(');');

          asMethod.body = Code(asBody.toString());
          asMethods.add(asMethod.build());
        } else {
          context.logger.warning(
              'When using `allOf`, only referenced models (`\$ref`) work');
        }
      }
    }

    final properties = mergedSchema.properties;
    final builder = FreezedDataClassBuilder(withJson: withJson);
    final result = builder.buildClass(DataClass(
      name: name.asClassName(),
      properties: [
        if (properties != null && properties.isNotEmpty)
          ...properties.entries.where((e) => e.value != null).map(
                (e) => DataProperty(
                  name: e.key,
                  required: mergedSchema.required?.contains(e.key) ?? false,
                  type: context.findDartType(e.value),
                ),
              ),
      ],
    ));

    result.constructors.add(Constructor(
      (b) => b
        ..name = '_'
        ..constant = true,
    ));
    result.methods.addAll(asMethods);

    return result.build();
  }
}
