import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/types/either.dart';

void main() {
  group('EitherTest', () {
    test('left', () {
      // Act
      final leftEither = left(0);

      // Asserts
      expect(
        leftEither.isLeft,
        true,
      );
      expect(
        leftEither.isRight,
        false,
      );
      expect(
        leftEither.fold((left) => left, (right) => right),
        0,
      );
      expect(
        leftEither.getOrElse((left) => left),
        0,
      );
    });

    test('right', () {
      // Act
      final rightEither = right(1);

      // Asserts
      expect(
        rightEither.isRight,
        true,
      );
      expect(
        rightEither.isLeft,
        false,
      );
      expect(
        rightEither.fold((left) => left, (right) => right),
        1,
      );
      expect(
        rightEither.getOrElse((left) => 0),
        1,
      );
    });

    test('bind', () {
      // Arrange
      final rightEither = right(0);

      // Act
      final newEither = rightEither.bind((_) => right(1));

      // Asserts
      expect(
        newEither.getOrElse((left) => 0),
        1,
      );
    });

    test('leftBind', () {
      // Arrange
      final leftEither = left(0);

      // Act
      final newEither = leftEither.leftBind((_) => right(1));

      // Asserts
      expect(
        newEither.getOrElse((left) => 0),
        1,
      );
    });

    test('asyncBind right', () async {
      // Arrange
      final rightEither = right(0);

      // Act
      final newEither = await rightEither.asyncBind((_) async => right(1));

      // Asserts
      expect(
        newEither.getOrElse((left) => 0),
        1,
      );
    });

    test('asyncBind left', () async {
      // Arrange
      final rightEither = left(0);

      // Act
      final newEither = await rightEither.asyncBind((_) async => left(0));

      // Asserts
      expect(
        newEither.getOrElse((left) => 0),
        0,
      );
    });

    test('map', () async {
      // Arrange
      final rightEither = right(0);

      // Act
      final newEither = rightEither.map((_) => 1);

      // Asserts
      expect(
        newEither.getOrElse((left) => 0),
        1,
      );
    });

    test('leftMap', () async {
      // Arrange
      final leftEither = left(0);

      // Act
      final newEither = leftEither.leftMap((_) => 1);

      // Asserts
      expect(
        newEither.getOrElse((left) => left),
        1,
      );
    });
  });
}
