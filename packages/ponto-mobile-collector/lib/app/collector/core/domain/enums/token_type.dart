enum TokenType {
  first('first'),
  user('user'),
  key('key');

  final String value;

  const TokenType(this.value);

  bool isUser() => this == TokenType.user;

  bool isKey() => this == TokenType.key;

  bool isFirst() => this == TokenType.first;

  static TokenType build({required String value}) {
    return TokenType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw Exception('TokenType not found'),
    );
  }
}
