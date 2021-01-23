import 'dart:io';

class In {
  static final RegExp _WHITESPACE_PATTERN = RegExp(r'\s+');
  final File file;

  In(this.file);

  factory In.fromName(String name) {
    if (name == null) throw ArgumentError("argument is null");
    if (name.isEmpty) throw ArgumentError("argument is the empty string");

    // TODO: add support to remote file.

    File file = new File(name);
    if (file.existsSync()) {
      return In(file);
    }

    throw ArgumentError('Could not open $name');
  }

  Future<List<int>> readAllInts() async {
    String input = await readAll();

    RegExp numbersPattern = RegExp(r'\d+');
    List<int> result = numbersPattern
        .allMatches(input)
        .map((match) => int.parse(match.group(0)))
        .toList(growable: false);
    return result;
  }

  Future<List<String>> readAllStrings() async {
    String all = await readAll();
    List<String> tokens = all.split(_WHITESPACE_PATTERN);
    if (tokens.length == 0 || tokens[0].length > 0) return tokens;
    List<String> decapitokens = List<String>(tokens.length - 1);
    for (int i = 0; i < tokens.length - 1; i++) decapitokens[i] = tokens[i + 1];
    return decapitokens;
  }

  Future<String> readAll() async {
    return await file.readAsString();
  }
}
