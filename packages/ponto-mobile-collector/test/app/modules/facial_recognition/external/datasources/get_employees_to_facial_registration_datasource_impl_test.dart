import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/employee_adapter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/external/datasources/get_employees_to_facial_registration_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/models/employee_item_model.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockEmployeeAdapter extends Mock implements EmployeeAdapter {}

void main() {
  late GetEmployeesToFacialRegistrationDatasourceImpl datasource;
  late MockHttpClient httpClient;
  late MockEnvironmentService environmentService;

  setUp(() {
    httpClient = MockHttpClient();
    environmentService = MockEnvironmentService();
    datasource = GetEmployeesToFacialRegistrationDatasourceImpl(
      httpClient: httpClient,
      environmentService: environmentService,
    );
  });

  group('GetEmployeesToFacialRegistrationDatasourceImpl', () {
    test('should call the correct API endpoint and return the correct data',
        () async {
      EmployeeItemModel employeeItemModel = const EmployeeItemModel(
          id: '1', name: 'John Doe', identifier: '123456789',);

      List<EmployeeItemModel> employeesResult = [];
      employeesResult.add(employeeItemModel);

      when(() => environmentService.environment())
          .thenReturn(EnvironmentEnum.dev);

      const fakeToken = 'fakeToken';
      const fakeName = 'John Doe';
      const fakePageNumber = 0;
      const fakePageSize = 10;

      final fakeResponse = {
        'employeesFacialAuthOn': [
          {'id': 1, 'name': 'John Doe', 'cpfNumber': '123456789'},
        ],
        'pageNumber': fakePageNumber,
        'pageSize': fakePageSize,
        'totalElements': 1,
      };

      final response = HttpResponse(
        statusCode: 200,
        body: jsonEncode(fakeResponse),
      );

      when(
        () => httpClient.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => response,
      );

       final result = await datasource(
        name: fakeName,
        pageNumber: fakePageNumber,
        pageSize: fakePageSize,
        token: fakeToken,
      );

      expect(result.pageNumber, fakePageNumber);
      expect(result.pageSize, fakePageSize);
      expect(result.totalPage, 1);
      expect(result.employees.length, 0);
    });

    test('should throw GetEmployeesFacialRegistrationException on error',
        () async {
      when(() => environmentService.environment())
          .thenReturn(EnvironmentEnum.dev);

      const fakeToken = 'fakeToken';
      const fakeName = 'John Doe';
      const fakePageNumber = 1;
      const fakePageSize = 10;
      
      when(
        () => httpClient.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => const HttpResponse(
          statusCode: 500,
          body: 'Internal Server Error',
        ),
      );

      final result = await datasource(
        name: fakeName,
        pageNumber: fakePageNumber,
        pageSize: fakePageSize,
        token: fakeToken,
      );

      expect(result.pageNumber, fakePageNumber);
      expect(result.pageSize, fakePageSize);
      expect(result.totalPage, 0);
      expect(result.employees.length, 0);
    });
  });
}
