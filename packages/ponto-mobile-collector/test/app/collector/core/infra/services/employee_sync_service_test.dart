// ignore_for_file: unnecessary_cast

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_environment_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/device_info_mock.dart';

final employeesData = {
  'employeeList': [
    {
      'loginConfiguration': {
        'onlyOnline': true,
        'operationMode': 'SINGLE',
        'timezone': 'America/Sao_Paulo',
        'takePhoto': false,
        'allowChangeTime': false,
        'faceRecognition': true,
      },
      'loginEmployee': {
        'id': '44a44481-9433-42e8-b171-9a08617999c8',
        'name': 'Bruno',
        'cpfNumber': '05721648902',
        'mail': 'bruno@empresa1.com.br',
        'faceRegistered': '44a44481-9433-42e8-b171-9a08617999c8',
        'company': {
          'id': '7572ad2f-de46-4027-aa66-97ea0dbd51d3',
          'cnpj': '81006367000114',
          'name': 'Empresa 1',
          'timeZone': 'America/Sao_Paulo',
          'dataOrigin': 'MANUAL',
          'arpId': '23c8caff-af98-44c9-8a44-643fa1357df1',
        },
        'fences': [],
        'employeeType': 'COMPANY_EMPLOYEE',
        'registrationNumber': '1',
        'enabled': true,
      },
    },
    {
      'loginConfiguration': {
        'onlyOnline': true,
        'operationMode': 'SINGLE',
        'timezone': 'America/Sao_Paulo',
        'takePhoto': false,
        'allowChangeTime': false,
        'faceRecognition': false,
      },
      'loginEmployee': {
        'id': '574fb7f3-7980-4153-a708-442722942836',
        'name': 'Colaborador 2',
        'cpfNumber': '86751444079',
        'faceRegistered': '574fb7f3-7980-4153-a708-442722942836',
        'company': {
          'id': '7572ad2f-de46-4027-aa66-97ea0dbd51d3',
          'cnpj': '81006367000114',
          'name': 'Empresa 1',
          'timeZone': 'America/Sao_Paulo',
          'dataOrigin': 'MANUAL',
          'arpId': '23c8caff-af98-44c9-8a44-643fa1357df1',
        },
        'nfcCode': '123456789',
        'fences': [],
        'employeeType': 'COMPANY_EMPLOYEE',
        'registrationNumber': '2',
        'arpId': '136e8db5-41dd-4e15-bf41-b8ad993022aa',
        'enabled': true,
      },
    },
  ],
  'pageData': {
    'totalElements': 2,
    'pageNumber': 1,
  },
};

final emptyEmployeesData = {
  'employeeList': [],
};

final pageEntity = PageEntity(page: 1, pageSize: 10);

class MockHttpClient extends Mock implements IHttpClient {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockGetEnvironmentUsecase extends Mock implements GetEnvironmentUsecase {}

class FakeToken extends Fake implements Token {
  @override
  String get accessToken => 'accessToken';
}

void main() {
  late IHttpClient httpClient;
  late IPlatformService platformService;
  late IEmployeeSyncService service;
  late ISharedPreferencesService sharedPreferencesService;
  late GetEnvironmentUsecase getEnvironmentUsecase;

  setUpAll(() {
    registerFallbackValue(pageEntity);
  });

  setUp(() {
    httpClient = MockHttpClient();
    platformService = MockPlatformService();
    sharedPreferencesService = MockSharedPreferencesService();
    getEnvironmentUsecase = MockGetEnvironmentUsecase();

    service = EmployeeSyncService(
      httpClient: httpClient,
      platformService: platformService,
      sharedPreferencesService: sharedPreferencesService,
      getEnviromentUsecase: getEnvironmentUsecase,
    );
  });

  group('EmployeeSyncService', () {
    test(
      'should return List<MultiEmployeeSync> if service returns employees',
      () async {
        when(() => platformService.getDeviceInfoDto()).thenAnswer(
          (_) async => Future.value(deviceMockInfo),
        );

        when(() => getEnvironmentUsecase.call())
            .thenAnswer((_) async => EnvironmentEnum.dev);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: json.encode(
              {
                'identifier': 'identifier',
                'pageInfo': {
                  'page': pageEntity.page,
                  'pageSize': pageEntity.pageSize,
                },
                'employeeIdFilter': '1',
              },
            ),
          ),
        ).thenAnswer(
          (_) async => Future.value(
            HttpResponse(
              body: json.encode(employeesData),
              statusCode: 200,
            ) as FutureOr<HttpResponse>?,
          ),
        );

        const employeeId = '1';

        final response = await service.getEmployees(
          pageEntity: pageEntity,
          employeeIdFilter: employeeId,
        );

        expect(response.content.length, equals(2));
        expect(response.content[0].configuration.onlyOnline, equals(true));
        expect(
          response.content[0].configuration.operationMode,
          equals(OperationModeType.single),
        );
        expect(
          response.content[0].configuration.timezone,
          equals('America/Sao_Paulo'),
        );
        expect(response.content[0].configuration.takePhoto, equals(false));
        expect(
          response.content[0].configuration.allowChangeTime,
          equals(false),
        );
        expect(
          response.content[0].configuration.faceRecognition,
          equals(true),
        );
        expect(
          response.content[0].employee.id,
          equals('44a44481-9433-42e8-b171-9a08617999c8'),
        );
        expect(response.content[0].employee.name, equals('Bruno'));
        expect(response.content[0].employee.cpfNumber, equals('05721648902'));
        expect(
          response.content[0].employee.faceRegistered,
          equals('44a44481-9433-42e8-b171-9a08617999c8'),
        );
        expect(
          response.content[0].employee.mail,
          equals('bruno@empresa1.com.br'),
        );
        expect(
          response.content[0].employee.employeeType,
          equals('COMPANY_EMPLOYEE'),
        );
        expect(response.content[0].employee.registrationNumber, equals('1'));
        expect(response.content[0].employee.enabled, equals(true));
        expect(response.content[0].employee.fences!.length, equals(0));
        expect(
          response.content[0].employee.company!.id,
          equals('7572ad2f-de46-4027-aa66-97ea0dbd51d3'),
        );
        expect(
          response.content[0].employee.company!.identifier,
          equals('81006367000114'),
        );
        expect(
          response.content[0].employee.company!.name,
          equals('Empresa 1'),
        );
        expect(
          response.content[0].employee.company!.timeZone,
          equals('America/Sao_Paulo'),
        );
        expect(
          response.content[0].employee.company!.arpId,
          equals('23c8caff-af98-44c9-8a44-643fa1357df1'),
        );
      },
    );

    test(
      'should return [] if service returns none employees',
      () async {
        when(() => platformService.getDeviceInfoDto()).thenAnswer(
          (_) async => deviceMockInfo,
        );

        when(() => getEnvironmentUsecase.call())
            .thenAnswer((_) async => EnvironmentEnum.dev);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: json.encode(
              {'identifier': 'TP1A.220624.014', 'lastSync': '2023-11-01'},
            ),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            body: json.encode(emptyEmployeesData),
            statusCode: 200,
          ),
        );

        final response = await service.getEmployees(
          pageEntity: pageEntity,
        );

        expect(response.content.length, equals(0));
      },
    );

    test(
      'should return [] if service returns status code different from 200',
      () async {
        when(() => platformService.getDeviceInfoDto()).thenAnswer(
          (_) async => deviceMockInfo,
        );

        when(() => getEnvironmentUsecase.call())
            .thenAnswer((_) async => EnvironmentEnum.dev);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: json.encode(
              {'identifier': 'TP1A.220624.014', 'lastSync': '2023-11-01'},
            ),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            body: json.encode(emptyEmployeesData),
            statusCode: 500,
          ),
        );

        final response = await service.getEmployees(pageEntity: pageEntity);

        expect(response.content.length, equals(0));
      },
    );

    test(
      'should return [] if service returns Exception',
      () async {
        when(() => platformService.getDeviceInfoDto()).thenAnswer(
          (_) async => deviceMockInfo,
        );

        when(() => getEnvironmentUsecase.call())
            .thenAnswer((_) async => EnvironmentEnum.dev);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: json.encode(
              {'identifier': 'TP1A.220624.014', 'lastSync': '2023-11-01'},
            ),
          ),
        ).thenThrow(const HttpException('Error'));

        final response = await service.getEmployees(pageEntity: pageEntity);

        expect(response.content.length, equals(0));
      },
    );
  });
}
