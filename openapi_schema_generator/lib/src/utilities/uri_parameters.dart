final _segmentParamRegexp = RegExp(r'\{([^\}]+)\}');

extension UriParametersExtensions on String {
  List<String> extractSegmentParameters() {
    return _segmentParamRegexp
        .allMatches(this)
        .map((match) => match.group(1)!)
        .toList();
  }
}
