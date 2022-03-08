import 'package:code_builder/code_builder.dart';

import 'package:openapi_schema_generator/src/utilities/naming.dart';

abstract class DataType {
  const DataType();
  String get name;
}

class DataRawType extends DataType {
  const DataRawType(this.name);

  @override
  final String name;
}

class DataListType extends DataType {
  const DataListType(this.childType);

  @override
  String get name => 'List<${childType.name}>';

  final DataType childType;
}

class DataReferenceType extends DataType {
  const DataReferenceType(this.name);

  @override
  final String name;
}

class DataUnion extends DataType {
  const DataUnion({
    required this.name,
    required this.children,
  });
  @override
  final String name;
  final List<DataUnionCase> children;
}

class DataUnionCase {
  const DataUnionCase({
    required this.factoryName,
    required this.value,
  });
  final String factoryName;
  final DataClass value;
}

class DataEnum extends DataType {
  const DataEnum({
    required this.name,
    required this.values,
  });
  @override
  final String name;
  final List<String> values;
}

class DataClass extends DataType {
  const DataClass({
    required this.name,
    required this.properties,
  });
  @override
  final String name;
  final List<DataProperty> properties;
}

class DataListClass extends DataType {
  const DataListClass({
    required this.name,
    required this.childType,
  });
  @override
  final String name;

  final DataType childType;
}

class DataProperty {
  const DataProperty({
    required this.name,
    required this.type,
    this.defaultValue,
    this.required = false,
  });
  final String name;
  final DataType type;
  final String? defaultValue;
  final bool required;
}

class FreezedDataClassBuilder {
  const FreezedDataClassBuilder({
    this.withJson = true,
  });

  final bool withJson;

  Spec build(DataType type) {
    if (type is DataClass) return buildClass(type).build();
    if (type is DataUnion) return buildDataUnion(type).build();
    if (type is DataEnum) return buildEnum(type);
    throw Exception('Not supported data type');
  }

  ClassBuilder buildDataUnion(DataUnion type) {
    final builder = ClassBuilder()
      ..name = type.name
      ..annotations.add(CodeExpression(Code("freezed")));

    builder.mixins.add(refer('_\$${builder.name}'));

    for (var child in type.children) {
      final constructor = ConstructorBuilder()
        ..constant = true
        ..factory = true
        ..name = child.factoryName.asFieldName();

      constructor.redirect = refer(child.value.name);

      for (var property in child.value.properties) {
        final valueParameter = ParameterBuilder()
          ..named = true
          ..required = property.required
          ..name = property.name.asFieldName()
          ..type = refer(property.type.name + (!property.required ? '?' : ''));

        if (withJson && valueParameter.name != property.name) {
          valueParameter.annotations.add(
            CodeExpression(Code("JsonKey(name: '${property.name}') ")),
          );
        }

        constructor.optionalParameters.add(valueParameter.build());
      }

      builder.constructors.add(constructor.build());
    }

    if (withJson) builder.constructors.add(_createFromJson(builder.name!));

    return builder;
  }

  Spec buildEnum(DataEnum type) {
    final builder = EnumBuilder()..name = type.name;

    for (var item in type.values) {
      final value = EnumValueBuilder()..name = item.asFieldName();
      if (withJson && value.name != item) {
        value.annotations.add(
          CodeExpression(Code("JsonValue('$item') ")),
        );
      }

      builder.values.add(value.build());
    }

    return builder.build();
  }

  ClassBuilder buildClass(DataClass type) {
    final builder = ClassBuilder()
      ..name = type.name
      ..annotations.add(CodeExpression(Code("freezed")));

    builder.mixins.add(refer('_\$${builder.name}'));

    final constructor = ConstructorBuilder()
      ..constant = true
      ..factory = true
      ..redirect = refer('_${builder.name}');

    for (var property in type.properties) {
      final valueParameter = ParameterBuilder()
        ..named = true
        ..required = property.required
        ..name = property.name.asFieldName()
        ..type = refer(property.type.name + (!property.required ? '?' : ''));

      if (withJson && valueParameter.name != property.name) {
        valueParameter.annotations.add(
          CodeExpression(Code("JsonKey(name: '${property.name}') ")),
        );
      }

      constructor.optionalParameters.add(valueParameter.build());
    }
    builder.constructors.add(constructor.build());

    if (withJson) builder.constructors.add(_createFromJson(builder.name!));

    return builder;
  }

  Constructor _createFromJson(String name) {
    //factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
    final builder = ConstructorBuilder()
      ..name = 'fromJson'
      ..factory = true
      ..lambda = true;

    builder.body = Code('_\$${name}FromJson(json)');

    builder.requiredParameters.add(
      Parameter(
        (b) => b
          ..name = 'json'
          ..type = refer('Map<String, dynamic>'),
      ),
    );

    return builder.build();
  }
}
