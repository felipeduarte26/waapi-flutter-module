extension StringExtension on String {
  String capitalize(){
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get toSentences {
    if (isEmpty) {
      return '';
    }

    List<String> words = toLowerCase().split('-').map(
      (word) {
        return upperCaseFirstLetter(
          word: word,
        );
      },
    ).toList();

    return words.join(' ');
  }
}

String upperCaseFirstLetter({
  required String word,
}) {
  return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
}
