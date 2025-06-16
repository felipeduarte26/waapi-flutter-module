import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/privacy_policy_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/privacy_policy_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_last_version_privacy_policy_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/privacy_policy/domain/presenter/cubit/privacy_policy_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/privacy_policy/domain/presenter/cubit/privacy_policy_state.dart';

class MockGetLastVersionPrivacyPolicyUsecase extends Mock
    implements GetLastVersionPrivacyPolicyUsecase {}

class MockPrivacyPolicyRepository extends Mock
    implements PrivacyPolicyRepository {}

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PrivacyPolicyCubit cubit;
  late GetLastVersionPrivacyPolicyUsecase getLastVersionPrivacyPolicyUsecase;
  late PrivacyPolicyRepository privacyPolicyRepository;
  late HasConnectivityUsecase hasConnectivityUsecase;

  PrivacyPolicyEntity privacyPolicyMock = PrivacyPolicyEntity(
    dateTimeEventRead: DateTime.now(),
    urlVersion: 'https://www.google.com',
    version: 1,
  );

  setUp(() {
    getLastVersionPrivacyPolicyUsecase =
        MockGetLastVersionPrivacyPolicyUsecase();
    privacyPolicyRepository = MockPrivacyPolicyRepository();
    hasConnectivityUsecase = MockHasConnectivityUsecase();

    cubit = PrivacyPolicyCubit(
      getLastVersionPrivacyPolicyUseCase: getLastVersionPrivacyPolicyUsecase,
      privacyPolicyRepository: privacyPolicyRepository,
      hasConnectivityUsecase: hasConnectivityUsecase,
      isTest: true,
    );

    when(
      () => getLastVersionPrivacyPolicyUsecase.call(),
    ).thenAnswer((invocation) => Future.value(privacyPolicyMock));
  });

  tearDown(() {
    cubit.close();
  });

  test('initialize should return last version privacy policy', () async {
    when(
      () => getLastVersionPrivacyPolicyUsecase.call(),
    ).thenAnswer((invocation) => Future.value(privacyPolicyMock));

    when(
      () => hasConnectivityUsecase.call(),
    ).thenAnswer(
      (invocation) => Future.value(true),
    );

    await cubit.initialize();

    expect(cubit.state, isA<ReadContentState>());
  });

  test('should save date read policy privacy and open url', () async {
    // Arrange
    when(
      () => privacyPolicyRepository.save(privacyPolicy: privacyPolicyMock),
    ).thenAnswer((invocation) => Future.value(true));

    // Act
    await cubit.goToPrivacyPolicyPage(lastVersionSaved: privacyPolicyMock);

    // Assert
    verifyNever(
      () => privacyPolicyRepository.save(privacyPolicy: privacyPolicyMock),
    );
  });
}
