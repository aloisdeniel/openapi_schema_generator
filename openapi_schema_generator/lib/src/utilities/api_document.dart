import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/utilities/type_extension.dart';
import 'package:recase/recase.dart';

extension ApiDocumentExtension on APIDocument {
  /// Extract inline types, declare them as a root schema, and replace them
  /// with references.
  void normalize() {
    final schemas = components?.schemas;

    if (schemas != null) {
      final entries = schemas.entries.toList();
      for (var i = 0; i < entries.length; i++) {
        final schema = entries[i];
        final value = schema.value;
        if (value != null) value.normalize(this, [schema.key]);
      }
    }
  }

  /// Adds the [schema] as a component.
  ///
  /// Its name is created from the given [path].
  void addSchema(List<String> path, APISchemaObject schema) {
    final schemas = components?.schemas;

    if (schemas != null) {
      schemas[path.createClassname()] = schema;
    }
  }
}

extension APISchemaObjectExtension on APISchemaObject {
  /// Extract inline types, declare them as a root schemas, and replace them
  /// with references.
  void normalize(APIDocument document, List<String> path) {
    final properties = this.properties;
    if (properties != null) {
      final entries = properties.entries.toList();
      for (var i = 0; i < entries.length; i++) {
        final property = entries[i];
        final propertySchema = property.value;
        if (propertySchema != null && propertySchema.hasComplexType()) {
          final propertyPath = [...path, property.key];
          document.addSchema(propertyPath, propertySchema);
          properties[property.key] = APISchemaObject()
            ..referenceURI = propertyPath.createReferenceUri();
          propertySchema.normalize(document, propertyPath);
        }
      }
    }
  }
}

extension PathExtension on List<String> {
  String createClassname() {
    return ReCase(join('_')).pascalCase;
  }

  Uri createReferenceUri() {
    return Uri.parse("/components/schemas/${createClassname()}");
  }
}
