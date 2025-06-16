import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/environment/ienvironment_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/confirm_read_push_message_datasource_exception.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/external/datasources/confirm_read_push_message_datasource_impl.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late ConfirmReadPushMessageDataSourceImpl datasource;
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
    datasource = ConfirmReadPushMessageDataSourceImpl(
      httpClient: mockHttpClient,
      environmentService: mockEnvironmentService,
    );
  });

  group('ConfirmReadPushMessageDataSourceImpl', () {
    const messageId = 'test_message_id';

    test(
        'should return ConfirmReadPushMessageEntity when the HTTP call is successful',
        () async {
      when(() => mockEnvironmentService.environment())
          .thenReturn(EnvironmentEnum.test);

      HttpResponse httpResponse = HttpResponse(
        statusCode: 200,
        body: jsonEncode({'confirmed': true}),
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

      final result = await datasource.call(messageId: messageId,);

      expect(result.confirmed, true);
      verify(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });

    test(
        'should throw ConfirmReadPushMessageDatasourceException when the HTTP call fails',
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
        () async => await datasource.call(messageId: messageId,),
        throwsA(isA<ConfirmReadPushMessageDataSourceException>()),
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
