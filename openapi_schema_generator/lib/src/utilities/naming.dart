import 'package:recase/recase.dart';

extension NamingExtensions on String {
  String asFileName() {
    final cased = ReCase(this);
    return cased.snakeCase._removeSpecialCharacters();
  }

  String asFieldName() {
    final cased = ReCase(this);
    return cased.camelCase._removeSpecialCharacters();
  }

  String asClassName() {
    final cased = ReCase(this);
    return cased.pascalCase._removeSpecialCharacters();
  }

  String _removeSpecialCharacters() {
    final result = StringBuffer();
    final regexp = RegExp('[a-zA-Z0-9]');
    for (var i = 0; i < length; i++) {
      final character = this[i];
      if (regexp.allMatches(character).isNotEmpty) {
        result.write(character);
      }
    }

    return result.toString();
  }
}
