import 'package:code_builder/code_builder.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';

class OneOfClassBuilder {
  const OneOfClassBuilder({
    this.withJson = true,
  });

  final bool withJson;

  Spec build(String name, List<String> children) {
    final builder = ClassBuilder()
      ..name = name
      ..annotations.add(CodeExpression(Code("immutable")));

    builder.fields.add(Field(
      (b) => b
        ..modifier = FieldModifier.final$
        ..name = '_value'
        ..type = refer('Object'),
    ));

    for (var childTypeName in children) {
      final constructor = ConstructorBuilder()
        ..constant = true
        ..name = childTypeName.asFieldName();

      constructor.initializers.add(Code('_value = value'));

      final valueParameter = ParameterBuilder()
        ..name = 'value'
        ..type = refer(childTypeName.asClassName());

      constructor.requiredParameters.add(valueParameter.build());

      builder.constructors.add(constructor.build());
    }

    const discriminatorProperty = 'objectType';

    if (withJson) {
      // From json factory
      final fromJson = ConstructorBuilder()
        ..factory = true
        ..name = 'fromJson';

      fromJson.requiredParameters.add(
        Parameter(
          (b) => b
            ..name = 'json'
            ..type = refer('Map<String, dynamic>'),
        ),
      );

      final fromJsonBody = StringBuffer();
      fromJsonBody.writeln('switch (json[\'$discriminatorProperty\']) {');

      for (var childTypeName in children) {
        fromJsonBody.writeln('case \'$childTypeName\':');
        fromJsonBody.writeln(
            'return $name.${childTypeName.asFieldName()}(${childTypeName.asClassName()}.fromJson(json));');
      }

      fromJsonBody.writeln('default:');
      fromJsonBody
          .writeln('throw Exception(\'Invalid or missing discriminator\');');
      fromJsonBody.writeln('}');

      fromJson.body = Code(fromJsonBody.toString());
      builder.constructors.add(fromJson.build());

      // ToJson
      final toJson = MethodBuilder()
        ..name = 'toJson'
        ..returns = refer('Map<String, dynamic>');

      final toJsonBody = StringBuffer();
      toJsonBody.writeln('return {');
      toJsonBody.writeln('\'$discriminatorProperty\': map(');

      for (var childTypeName in children) {
        toJsonBody.writeln(
            '${childTypeName.asFieldName()}: (v) =>  \'$childTypeName\',');
      }
      toJsonBody.writeln('),');

      toJsonBody.writeln('...map(');
      for (var childTypeName in children) {
        toJsonBody
            .writeln('${childTypeName.asFieldName()}: (v) =>  v.toJson(),');
      }
      toJsonBody.writeln('),');

      toJsonBody.writeln('};');

      toJson.body = Code(toJsonBody.toString());
      builder.methods.add(toJson.build());

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

      validateJsonBody.writeln('if(!json.containsKey(\'objectType\'))');
      validateJsonBody.writeln('return false;');

      for (var childTypeName in children) {
        validateJsonBody.writeln('if($childTypeName.validateJson(json))');
        validateJsonBody.writeln('return true;');
      }
      validateJsonBody.writeln('return false;');

      validateJson.body = Code(validateJsonBody.toString());
      builder.methods.add(validateJson.build());
    }

    // Map
    final map = MethodBuilder()
      ..name = 'map<T>'
      ..returns = refer('T');

    for (var childTypeName in children) {
      map.optionalParameters.add(
        Parameter((b) => b
          ..name = childTypeName.asFieldName()
          ..required = true
          ..named = true
          ..type = refer('T Function(${childTypeName.asClassName()} value)')),
      );
    }

    final mapBody = StringBuffer();
    mapBody.writeln('final value = _value;');
    for (var childTypeName in children) {
      mapBody.writeln(
          'if (value is ${childTypeName.asClassName()}) return ${childTypeName.asFieldName()}(value);');
    }
    mapBody.writeln('throw Exception();');
    map.body = Code(mapBody.toString());
    builder.methods.add(map.build());

    // Hashcode
    final hashcode = MethodBuilder()
      ..name = 'hashCode'
      ..type = MethodType.getter
      ..returns = refer('int')
      ..lambda = true
      ..annotations.add(CodeExpression(Code("override")))
      ..body = Code('_value.hashCode');
    builder.methods.add(hashcode.build());

    // Equals
    final equals = MethodBuilder()
      ..name = 'operator =='
      ..returns = refer('bool')
      ..annotations.add(CodeExpression(Code("override")));
    equals.requiredParameters.add(
      Parameter(
        (b) => b
          ..name = 'other'
          ..type = refer(
            'dynamic',
          ),
      ),
    );
    equals.body = Code('return identical(this, other) ||'
        '(other.runtimeType == runtimeType &&'
        ' other is ${builder.name} &&'
        '_value == other._value);');
    builder.methods.add(equals.build());

    return builder.build();
  }
}
