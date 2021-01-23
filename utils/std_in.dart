import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:core';

class StdIn {
  static final String _WHITESPACE_PATTERN = RegExp(r'\s+').pattern;

  static Future<List<int>> readAllInts() async {
    List<String> fields = await readAllStrings();
    List<int> vals = List<int>(fields.length);
    for (int i = 0; i < fields.length; i++) vals[i] = int.parse(fields[i]);
    return vals;
  }

  static Future<List<String>> readAllStrings() async {
    List<String> tokens = _WHITESPACE_PATTERN.split(await readAll());
    if (tokens.length == 0 || tokens[0].length > 0) return tokens;

    List<String> decapitokens = List<String>(tokens.length - 1);
    for (int i = 0; i < tokens.length - 1; i++) decapitokens[i] = tokens[i + 1];
    return decapitokens;
  }

  static Future<String> readAll() async {
    return await stdin
        .map((data) {
          return data;
        })
        .transform(utf8.decoder)
        .first;
  }
}
