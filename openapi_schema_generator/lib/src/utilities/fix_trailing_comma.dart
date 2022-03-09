final _missingTrailingComma = RegExp(r'([^\,])\s*\}\)');

extension FixTrailingCommas on String {
  String fixTrailingCommas() {
    var match = _missingTrailingComma.firstMatch(this);
    var result = this;
    while (match != null) {
      result =
          result.replaceRange(match.start, match.end, '${match.group(1)},})');
      match = _missingTrailingComma.firstMatch(result);
    }

    return result;
  }
}
