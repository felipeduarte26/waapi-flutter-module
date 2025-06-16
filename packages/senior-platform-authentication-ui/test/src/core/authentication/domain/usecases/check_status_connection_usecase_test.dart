import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockGetConnectivityStatusUsecase extends Mock
    implements GetConnectivityStatusUsecase {}

void main() {
  late CheckStatusConnectionUsecase checkStatusConnectionUsecase;
  late GetConnectivityStatusUsecase getConnectivityStatusUsecase;

  setUp(() {
    getConnectivityStatusUsecase = MockGetConnectivityStatusUsecase();
    checkStatusConnectionUsecase = CheckStatusConnectionUsecase(
      getConnectivityStatusUsecase: getConnectivityStatusUsecase,
    );
  });

  group('checkStatusConnectionUsecase', () {
    test('should execute successfully online', () async {
      // Arrange
      when(() => getConnectivityStatusUsecase.call(NoParams())).thenAnswer(
        (_) async => true,
      );

      // Act
      final result = await checkStatusConnectionUsecase.call(NoParams());

      // Assert
      expect(result, true);
    });

    test('should execute successfully offline', () async {
      // Arrange
      when(() => getConnectivityStatusUsecase.call(NoParams())).thenAnswer(
        (_) async => false,
      );

      // Act
      final result = await checkStatusConnectionUsecase.call(NoParams());

      // Assert
      expect(result, false);
    });
  });
}
