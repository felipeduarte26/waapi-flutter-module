import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/privacy_policy_service/privacy_policy_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_environment_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/privacy_policy/privacy_policy_service_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/constants/constants_path.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockGetEnvironmentUsecase extends Mock implements GetEnvironmentUsecase {}

void main() {
  late http.Client mockHttpClient;
  late GetEnvironmentUsecase getEnvironmentUsecase;
  late PrivacyPolicyService privacyPolicyService;

  setUp(() {
    mockHttpClient = MockHttpClient();
    getEnvironmentUsecase = MockGetEnvironmentUsecase();
    privacyPolicyService = PrivacyPolicyServiceImpl(
      mockHttpClient,
      getEnvironmentUsecase,
    );

    when(
      () => getEnvironmentUsecase.call(),
    ).thenAnswer((_) async => EnvironmentEnum.test);
  });

  Uri tUrl = Uri.https(
    EnvironmentEnum.test.path,
    ConstantsPath.privacyPoliceVersion,
  );

  var privacyPoliceVersion = '';
  final tJSON = json.encode(
    {
      'version': 1,
      'url': 'url',
    },
  );

  group('getConfiguration', () {
    group('API', () {
      test('Should get configuration from API and save it successfully',
          () async {
        when(
          () => mockHttpClient.post(
            tUrl,
            body: json.encode(
              {'appVersion': privacyPoliceVersion},
            ),
            headers: getRequestHeaders(),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            tJSON,
            200,
          ),
        );

        // Act
        final result = await privacyPolicyService.getLastPrivacyPoliceVersion();

        expect(result!.version, 1);
        expect(result.urlVersion, 'url');

        // Assert
        verify(() => getEnvironmentUsecase.call()).called(1);
        verify(
          () => mockHttpClient.post(
            tUrl,
            body: json.encode(
              {'appVersion': privacyPoliceVersion},
            ),
            headers: getRequestHeaders(),
          ),
        ).called(1);
      });

      test(
          'getLastPrivacyPoliceVersion should return null when an exception is thrown',
          () async {
        // Arrange
        when(
          () => getEnvironmentUsecase.call(),
        ).thenThrow(Exception('Failed to get environment'));

        // Act
        final result = await privacyPolicyService.getLastPrivacyPoliceVersion();

        // Assert
        expect(result, isNull);
      });
    });
  });
}

Map<String, String> getRequestHeaders() {
  return {
    'Content-Type': 'application/json',
  };
}
