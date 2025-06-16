import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/check_feature_toggle_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/check_feature_toggle_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/check_feature_toggle_repository_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';

class MockCheckFeatureToggleDatasource extends Mock
    implements CheckFeatureToggleDatasource {}

void main() {
  const TokenType tokenType = TokenType.key;
  late CheckFeatureToggleDatasource checkFeatureToggleDatasource;
  late CheckFeatureToggleRepository checkFeatureToggleRepository;

  setUp(() {
    checkFeatureToggleDatasource = MockCheckFeatureToggleDatasource();

    when(
      () => checkFeatureToggleDatasource.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
        tokenType: tokenType,
      ),
    ).thenAnswer((_) async => true);

    checkFeatureToggleRepository = CheckFeatureToggleRepositoryImpl(
      checkFeatureToggleDatasource: checkFeatureToggleDatasource,
    );
  });
  group('CheckFeatureToggleRepository', () {
    test('Should return true when called test', () async {
      bool featureReturn = await checkFeatureToggleRepository.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
        tokenType: tokenType,
      );

      expect(featureReturn, true);

      verify(
        () => checkFeatureToggleDatasource.call(
          featureToggle: FeatureToggleEnum.faceRecognition,
          tokenType: tokenType,
        ),
      ).called(1);
    });
  });
}
