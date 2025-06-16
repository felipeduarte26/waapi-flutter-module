import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/privacy_policy_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/privacy_policy_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/privacy_policy_service/privacy_policy_service.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockPrivacyPolicyRepository extends Mock
    implements PrivacyPolicyRepository {}

class MockPrivacyPolicyService extends Mock implements PrivacyPolicyService {}

void main() {
  late GetLastVersionPrivacyPolicyUsecase getLastVersionPrivacyPolicyUsecase;
  late PrivacyPolicyService privacyPolicyService;
  late PrivacyPolicyRepository privacyPolicyRepository;

  PrivacyPolicyEntity privacyPolicy = PrivacyPolicyEntity(
    version: 2,
    urlVersion: 'urlVersion',
  );

  PrivacyPolicyEntity privacyPolicySaved = PrivacyPolicyEntity(
    version: 1,
    urlVersion: 'urlVersion',
  );

  setUp(() {
    privacyPolicyService = MockPrivacyPolicyService();
    privacyPolicyRepository = MockPrivacyPolicyRepository();
    getLastVersionPrivacyPolicyUsecase = GetLastVersionPrivacyPolicyUsecaseImpl(
      privacyPolicyService: privacyPolicyService,
      privacyPolicyRepository: privacyPolicyRepository,
    );

    when(() => privacyPolicyService.getLastPrivacyPoliceVersion())
        .thenAnswer((_) async => privacyPolicy);

    when(() => privacyPolicyRepository.getLastVersionSaved())
        .thenAnswer((_) async => privacyPolicySaved);

    when(() => privacyPolicyRepository.save(privacyPolicy: privacyPolicy))
        .thenAnswer((_) async => true);
  });
  group('GetLastVersionPrivacyPolicy use case', () {
    test('getLastVersion Successfully', () async {
      var result = await getLastVersionPrivacyPolicyUsecase.call();

      expect(result!.version, 2);
      expect(result.urlVersion, 'urlVersion');

      verify(
        () => privacyPolicyService.getLastPrivacyPoliceVersion(),
      ).called(1);

      verify(
        () => privacyPolicyRepository.getLastVersionSaved(),
      ).called(1);
    });

    test('getLastVersion Successfully when privacyPolicySaved is null',
        () async {
      when(() => privacyPolicyRepository.getLastVersionSaved())
          .thenAnswer((_) async => null);

      var result = await getLastVersionPrivacyPolicyUsecase.call();

      expect(result!.version, 2);
      expect(result.urlVersion, 'urlVersion');

      verify(
        () => privacyPolicyService.getLastPrivacyPoliceVersion(),
      ).called(1);

      verify(
        () => privacyPolicyRepository.getLastVersionSaved(),
      ).called(1);
    });
  });
}
