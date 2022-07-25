import 'package:open_api_forked/v3.dart';

extension APITypeExtension on APIType? {
  bool isBasicType() {
    return [
      APIType.string,
      APIType.integer,
      APIType.number,
      APIType.boolean,
    ].contains(this);
  }

  bool isArray() {
    return this == APIType.array;
  }

  bool isObject() {
    return this == null || this == APIType.object;
  }
}

extension APISchemaObjectTypeExtension on APISchemaObject {
  /// The object is an object, an array, an enum.
  bool hasComplexType() {
    return referenceURI == null &&
        (type.isObject() ||
            (type == APIType.string &&
                enumerated != null &&
                enumerated!.isNotEmpty));
  }
}
