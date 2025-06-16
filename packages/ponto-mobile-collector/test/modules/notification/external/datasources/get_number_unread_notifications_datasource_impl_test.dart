import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/environment/ienvironment_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/get_number_unread_notification_datasource_exception.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/external/datasources/get_number_unread_notifications_datasource_impl.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late GetNumberUnreadNotificationsDatasourceImpl datasource;
  late MockHttpClient mockHttpClient;
  late MockEnvironmentService mockEnvironmentService;

  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(<String, String>{});
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockEnvironmentService = MockEnvironmentService();
    datasource = GetNumberUnreadNotificationsDatasourceImpl(
      httpClient: mockHttpClient,
      environmentService: mockEnvironmentService,
    );
  });

  group('GetNumberUnreadNotificationsDatasourceImpl', () {
    const employeeId = 'test_employee_id';

    test('should return HasUnreadPushMessageEntity with unread notifications',
        () async {
      when(() => mockEnvironmentService.environment())
          .thenReturn(EnvironmentEnum.test);

      HttpResponse httpResponse = HttpResponse(
        statusCode: 200,
        body: jsonEncode({'hasUnreadPushMessage': true, 'number': 5}),
      );
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => httpResponse,
      );

      final result =
          await datasource.call(employeeId: employeeId,);

      expect(result.hasUnreadPushMessage, true);
      expect(result.number, 5);
    });

    test(
        'should return HasUnreadPushMessageEntity with no unread notifications',
        () async {
      when(() => mockEnvironmentService.environment())
          .thenReturn(EnvironmentEnum.test);

      HttpResponse httpResponse = HttpResponse(
        statusCode: 200,
        body: jsonEncode({'hasUnreadPushMessage': false, 'number': 0}),
      );
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => httpResponse,
      );

      final result =
          await datasource.call(employeeId: employeeId,);

      expect(result.hasUnreadPushMessage, false);
      expect(result.number, 0);
    });

    test('should throw GetNumberUnreadNotificationsException on error',
        () async {
      when(() => mockEnvironmentService.environment())
          .thenReturn(EnvironmentEnum.test);

      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception());

      expect(
        () async => await datasource.call(employeeId: employeeId,),
        throwsA(isA<GetNumberUnreadNotificationsException>()),
      );

      verify(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
