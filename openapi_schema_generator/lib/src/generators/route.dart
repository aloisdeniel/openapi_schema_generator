import 'package:code_builder/code_builder.dart';
import 'package:open_api_forked/v2.dart';
import 'package:openapi_schema_generator/src/utilities/naming.dart';

class RouteGenerator {
  const RouteGenerator();

  Method generateOperation(String method, APIOperation operation) {
    final id = operation.id;
    if (id == null) throw Exception('All operations must have an operationId');
    final builder = MethodBuilder()..name = operation.id?.asFieldName();

    final doc = operation.description;
    if (doc != null) {
      builder.docs.add(doc);
    }

    final code = StringBuffer();

    switch (method.trim().toLowerCase()) {
      case 'get':

      default:
    }

    code.writeln('fina');

    builder.body = Code(code.toString());

    return builder.build();
  }

  List<Method> generatePath(APIPath path) {
    return [
      ...path.operations.entries
          .where((x) => x.value != null)
          .map((entry) => generateOperation(entry.key, entry.value!)),
    ];
  }
}
