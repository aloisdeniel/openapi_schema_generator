import 'package:code_builder/code_builder.dart';
import 'package:open_api_forked/v3.dart';
import 'package:openapi_schema_generator/src/context.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';
import 'package:openapi_schema_generator/src/utilities/type_extension.dart';

class AnyOfClassBuilder {
  const AnyOfClassBuilder({
    this.withJson = true,
  });

  final bool withJson;

  Spec build(Context context, String name, List<APISchemaObject?> oneOf) {
    void forEachChild(
        void Function(String name, APISchemaObject schema) onEach) {
      for (var child in oneOf) {
        final ref = child?.referenceURI;
        if (child != null && ref != null) {
          final childTypeName = context.findSchemaName(ref);
          onEach(childTypeName, child);
        }
      }
    }

    final builder = ClassBuilder()
      ..name = name
      ..annotations.add(CodeExpression(Code("immutable")));

    final constructor = ConstructorBuilder()..constant = true;
    forEachChild((childName, childSchema) {
      builder.fields.add(Field(
        (b) => b
          ..modifier = FieldModifier.final$
          ..name = childName.asFieldName()
          ..type = refer(childName.asClassName() + '?'),
      ));

      final valueParameter = ParameterBuilder()
        ..name = childName.asFieldName()
        ..named = true
        ..toThis = true;

      constructor.optionalParameters.add(valueParameter.build());
    });

    // At least one item must be present
    constructor.initializers.add(
      Code('assert(' +
          builder.fields
              .build()
              .map((e) => '${e.name.asFieldName()} != null')
              .join('|| ') +
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
            ..type = refer('dynamic'),
        ),
      );

      final fromJsonBody = StringBuffer();

      forEachChild((childName, childSchema) {
        final resolve = context.resolveSchema(childSchema);

        if (resolve.type.isBasicType()) {
          fromJsonBody.writeln(
              'if(${context.validateJsonInstance(childSchema, 'json')})');
          fromJsonBody.writeln('return  $name(');
          fromJsonBody.writeln(
              '${childName.asFieldName()}: ${context.fromJsonInstance(childSchema, 'json')},');
          fromJsonBody.writeln(');');
        }
      });

      fromJsonBody.writeln('return  $name(');

      forEachChild((childName, childSchema) {
        final resolve = context.resolveSchema(childSchema);

        if (!resolve.type.isBasicType()) {
          fromJsonBody.writeln(
              '${childName.asFieldName()}: ${context.validateJsonInstance(childSchema, 'json')} ? ${context.fromJsonInstance(childSchema, 'json')} : null,');
        }
      });

      fromJsonBody.writeln(');');
      fromJson.body = Code(fromJsonBody.toString());
      builder.constructors.add(fromJson.build());

      // ToJson
      final toJson = MethodBuilder()
        ..name = 'toJson'
        ..returns = refer('dynamic');

      final toJsonBody = StringBuffer();

      forEachChild((childName, childSchema) {
        final resolve = context.resolveSchema(childSchema);
        if (resolve.type.isBasicType()) {
          toJsonBody.writeln('if(${childName.asFieldName()} != null)');
          toJsonBody.writeln(
              'return ${context.toJsonInstance(childSchema, childName.asFieldName())};');
        }
      });

      toJsonBody.writeln('return {');

      forEachChild((childName, childSchema) {
        final resolve = context.resolveSchema(childSchema);
        if (!resolve.type.isBasicType()) {
          toJsonBody.writeln('if(${childName.asFieldName()} != null)');
          toJsonBody.writeln(
              '...${context.toJsonInstance(childSchema, childName.asFieldName() + '!')},');
        }
      });

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
            ..type = refer('dynamic'),
        ),
      );

      final validateJsonBody = StringBuffer();

      forEachChild((childName, childSchema) {
        validateJsonBody.writeln(
            'if(${context.validateJsonInstance(childSchema, 'json')})');
        validateJsonBody.writeln('return true;');
      });
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
          ' Object.hashAll([${builder.fields.build().map((e) => e.name.asFieldName()).join(',')}])');
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
        builder.fields
            .build()
            .map((e) =>
                e.name.asFieldName() + ' == other.' + e.name.asFieldName())
            .join(' && ') +
        ');');
    builder.methods.add(equals.build());

    return builder.build();
  }
}
