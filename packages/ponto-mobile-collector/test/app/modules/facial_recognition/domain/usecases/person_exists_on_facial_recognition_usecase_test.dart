import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/usecases/person_exists_on_facial_recognition_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockHttpClient extends Mock implements IHttpClient {}

class MockSessionService extends Mock implements ISessionService {}

class FakeEmployeeDto extends Fake implements EmployeeDto {
  @override
  String id;

  @override
  String? faceRegistered;

  FakeEmployeeDto({required this.id, this.faceRegistered});
}

void main() {
  String? employeeIdSelected;
  late IPersonExistsOnFacialRecognitionUsecase usecase;
  late IEnvironmentService environmentService;
  late IHttpClient httpClient;
  late ISessionService sessionService;

  setUpAll(() {
    environmentService = MockEnvironmentService();
    httpClient = MockHttpClient();
    sessionService = MockSessionService();

    usecase = PersonExistsOnFacialRecognitionUsecase(
      sessionService: sessionService,
      httpClient: httpClient,
      environmentService: environmentService,
    );
  });

  test(
    'should return true if person has faceRegisted',
    () async {
      when(() => sessionService.hasEmployee()).thenReturn(true);

      var fakeEmployeeDto = FakeEmployeeDto(
        id: '7b184a0b-4c5d-4afe-be87-7cb6ac681ecf',
        faceRegistered: '7b184a0b4c5d4afebe877cb6ac681ecf',
      );

      when(
        () => sessionService.getEmployee(),
      ).thenReturn(fakeEmployeeDto);

      final response = await usecase.call(employeeIdSelected);

      expect(response, equals(true));
    },
  );

  test(
    'should return true if person exists on facial recognition platform',
    () async {
      when(() => sessionService.hasEmployee()).thenReturn(false);
      when(() => environmentService.environment())
          .thenReturn(EnvironmentEnum.test);
      HttpResponse httpResponse =
          const HttpResponse(body: '{"exists": true}', statusCode: 200);
      when(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => httpResponse);

      final response = await usecase.call(employeeIdSelected);

      expect(response, equals(true));
    },
  );

  test(
    'should return false if person not exists on facial recognition platform',
    () async {

      when(() => sessionService.hasEmployee()).thenReturn(false);
      when(() => environmentService.environment())
          .thenReturn(EnvironmentEnum.test);
      HttpResponse httpResponse =
      const HttpResponse(body: '{"exists": false}', statusCode: 200);
      when(
            () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => httpResponse);

      final response = await usecase.call(employeeIdSelected);

      expect(response, equals(false));
    },
  );
}
