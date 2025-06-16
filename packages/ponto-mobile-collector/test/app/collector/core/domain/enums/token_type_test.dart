import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';

void main() {
  group('TokenType', () {
    test('isUser returns true for user token', () {
      expect(TokenType.user.isUser(), isTrue);
    });

    test('isUser returns false for non-user tokens', () {
      expect(TokenType.first.isUser(), isFalse);
      expect(TokenType.key.isUser(), isFalse);
    });

    test('isKey returns true for key token', () {
      expect(TokenType.key.isKey(), isTrue);
    });

    test('isKey returns false for non-key tokens', () {
      expect(TokenType.first.isKey(), isFalse);
      expect(TokenType.user.isKey(), isFalse);
    });

    test('isFirst returns true for first token', () {
      expect(TokenType.first.isFirst(), isTrue);
    });

    test('isFirst returns false for non-first tokens', () {
      expect(TokenType.user.isFirst(), isFalse);
      expect(TokenType.key.isFirst(), isFalse);
    });

    test('build returns correct enum for given value', () {
      expect(TokenType.build(value: 'first'), TokenType.first);
      expect(TokenType.build(value: 'user'), TokenType.user);
      expect(TokenType.build(value: 'key'), TokenType.key);
    });

    test('build throws exception for unknown value', () {
      expect(() => TokenType.build(value: 'unknown'), throwsException);
    });
  });
}
