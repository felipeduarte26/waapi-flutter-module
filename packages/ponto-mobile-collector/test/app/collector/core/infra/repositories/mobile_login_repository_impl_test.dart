import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/mobile_login_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/mobile_login_repository_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';

import '../../../../../mocks/mobile_login_usecase_return_mock.dart';

class MockMobileLoginRepositoryImpl extends Mock implements MobileLoginRepositoryImpl {}

class MockMobileLoginDataSource extends Mock implements MobileLoginDataSource {}

void main() {
  late MobileLoginRepositoryImpl repository;
  late MockMobileLoginDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockMobileLoginDataSource();
    repository = MobileLoginRepositoryImpl(mockDataSource);
  });

  group('MobileLoginRepositoryImpl', () {
    test('should call the data source with the correct environment enum', () async {
      // Arrange
      const environmentEnum = EnvironmentEnum.prod;
      final expectedReturn = mobileLoginUsecaseReturnMock;
      when(() => mockDataSource.call(environmentEnum)).thenAnswer((_) async => expectedReturn);

      // Act
      final result = await repository.call(environmentEnum);

      // Assert
      verify(() => mockDataSource.call(environmentEnum)).called(1);
      expect(result, expectedReturn);
    });

    test('should return null if the data source returns null', () async {
      // Arrange
      const environmentEnum = EnvironmentEnum.prod;
      when(() => mockDataSource.call(environmentEnum)).thenAnswer((_) async => null);

      // Act
      final result = await repository.call(environmentEnum);

      // Assert
      verify(() => mockDataSource.call(environmentEnum)).called(1);
      expect(result, isNull);
    });
  });
}
