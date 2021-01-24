extension StringExtension on String {
  String padCenter(int width, [String padding = ' ']) {
    int padLeft = (width - length) ~/ 2 + length;
    return this.padLeft(padLeft, padding).padRight(width, padding);
  }
}
