import 'package:args/args.dart';

abstract class ArgNames {
  static const output = 'output';
  static const packageName = 'package-name';
  static const packageDescription = 'package-description';
}

class Options {
  const Options({
    required this.file,
    required this.output,
    required this.packageName,
    required this.packageDescription,
  });

  factory Options.parse(List<String> arguments) {
    final parser = ArgParser()
      ..addOption(ArgNames.output, abbr: 'o')
      ..addOption(ArgNames.packageName, abbr: 'n')
      ..addOption(ArgNames.packageDescription, abbr: 'd');
    final args = parser.parse(arguments);
    final output = args[ArgNames.output] as String?;
    final packageName = args[ArgNames.packageName] as String?;
    final packageDescription = args[ArgNames.packageDescription] as String?;
    final result = Options(
      output: output ?? '.',
      file: args.rest.isEmpty ? 'api.json' : args.rest.last,
      packageName: packageName ?? 'api',
      packageDescription: packageDescription ?? 'A generated API package',
    );
    return result;
  }

  final String file;
  final String output;
  final String packageName;
  final String packageDescription;
}
