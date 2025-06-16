extension StringExtension on String {
  String get toCamelCase {
    if (isEmpty) {
      return '';
    }

    List<String> words = toLowerCase().split('_').map(
      (word) {
        try {
          int.parse(word);
          return '_$word';
        } catch (_) {
          return _upperCaseFirstLetter(
            word: word,
          );
        }
      },
    ).toList();

    words.first = words.first.toLowerCase();

    return words.join('');
  }

  String get toSnakeCase {
    final stringBuffer = StringBuffer();
    var isFirst = true;

    for (var i = 0; i < length; i++) {
      final char = substring(i, i + 1);
      if (!isFirst &&
          _isValidToWriteUnderscore(
            char: char,
            previousChar: substring(i - 1, i),
          )) {
        stringBuffer.write('_');
        stringBuffer.write(char.toUpperCase());
      } else {
        isFirst = false;
        stringBuffer.write(char.toUpperCase());
      }
    }

    return stringBuffer.toString();
  }
}

bool _isValidToWriteUnderscore({
  required String char,
  required String previousChar,
}) {
  final bool isNumber = _isNumber(
    text: char,
  );

  final isPreviousCharNumber = _isNumber(
    text: previousChar,
  );

  final isUpperCase = _isUpperCase(
    text: char,
  );

  return (isUpperCase && !isNumber && char != '_') || (isNumber && !isPreviousCharNumber && previousChar != '_');
}

bool _isUpperCase({
  required String text,
}) {
  return text == text.toUpperCase();
}

bool _isNumber({
  required String text,
}) {
  return int.tryParse(text) != null;
}

String _upperCaseFirstLetter({
  required String word,
}) {
  return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
}
