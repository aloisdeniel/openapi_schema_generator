import 'package:code_builder/code_builder.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';

class AnyOfClassBuilder {
  const AnyOfClassBuilder({
    this.withJson = true,
  });

  final bool withJson;

  Spec build(String name, List<String> children) {
    final builder = ClassBuilder()
      ..name = name
      ..annotations.add(CodeExpression(Code("immutable")));

    final constructor = ConstructorBuilder()..constant = true;
    for (var childTypeName in children) {
      builder.fields.add(Field(
        (b) => b
          ..modifier = FieldModifier.final$
          ..name = childTypeName.asFieldName()
          ..type = refer(childTypeName.asClassName() + '?'),
      ));

      final valueParameter = ParameterBuilder()
        ..name = childTypeName.asFieldName()
        ..named = true
        ..toThis = true;

      constructor.optionalParameters.add(valueParameter.build());
    }

    // At least one item must be present
    constructor.initializers.add(
      Code('assert(' +
          children.map((e) => '${e.asFieldName()} != null').join('|| ') +
          ')'),
    );

    builder.constructors.add(constructor.build());

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
      fromJsonBody.writeln('return  $name(');

      for (var childTypeName in children) {
        fromJsonBody.writeln(
            '${childTypeName.asFieldName()}: $childTypeName.validateJson(json) ? $childTypeName.fromJson(json) : null,');
      }

      fromJsonBody.writeln(');');
      fromJson.body = Code(fromJsonBody.toString());
      builder.constructors.add(fromJson.build());

      // ToJson
      final toJson = MethodBuilder()
        ..name = 'toJson'
        ..returns = refer('Map<String, dynamic>');

      final toJsonBody = StringBuffer();
      toJsonBody.writeln('return {');

      for (var childTypeName in children) {
        toJsonBody.writeln('if(${childTypeName.asFieldName()} != null)');
        toJsonBody.writeln('...${childTypeName.asFieldName()}!.toJson(),');
      }

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

      for (var childTypeName in children) {
        validateJsonBody.writeln('if($childTypeName.validateJson(json))');
        validateJsonBody.writeln('return true;');
      }
      validateJsonBody.writeln('return false;');

      validateJson.body = Code(validateJsonBody.toString());
      builder.methods.add(validateJson.build());
    }

    // Hashcode
    final hashcode = MethodBuilder()
      ..name = 'hashCode'
      ..type = MethodType.getter
      ..returns = refer('int')
      ..lambda = true
      ..annotations.add(CodeExpression(Code("override")))
      ..body = Code(
          ' Object.hashAll([${children.map((e) => e.asFieldName()).join(',')}])');
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
            ' other is ${builder.name} &&' +
        children
            .map((e) => e.asFieldName() + ' == other.' + e.asFieldName())
            .join(' && ') +
        ');');
    builder.methods.add(equals.build());

    return builder.build();
  }
}
