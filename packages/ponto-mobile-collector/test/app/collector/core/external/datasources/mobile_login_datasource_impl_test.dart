// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/platform/iplatform_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/mobile_login_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/mobile_login_configuration_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';

import '../../../../../mocks/device_info_mock.dart';
import '../../../../../mocks/mobile_login_response_mock.dart';
import '../../../../../mocks/mobile_login_usecase_return_mock.dart';

class MockPlatformService extends Mock implements IPlatformService {}

class MockMobileAuthenticationService extends Mock
    implements auth.MobileAuthenticationService {}

class MockMobileLoginConfigurationMapper extends Mock
    implements MobileLoginConfigurationMapper {}

void main() {
  late MobileLoginDataSourceImpl dataSource;
  late MockPlatformService mockPlatformService;
  late MockMobileAuthenticationService mockMobileAuthenticationService;
  late MockMobileLoginConfigurationMapper mockMobileLoginConfigurationMapper;

    setUpAll(() {
    registerFallbackValue(deviceMockInfo);
    registerFallbackValue(deviceInfoMock);
    registerFallbackValue(EnvironmentEnum.prod);
    registerFallbackValue(auth.Environment.prod);
  });

  setUp(() {
    mockPlatformService = MockPlatformService();
    mockMobileAuthenticationService = MockMobileAuthenticationService();
    mockMobileLoginConfigurationMapper = MockMobileLoginConfigurationMapper();

    dataSource = MobileLoginDataSourceImpl(
      platformService: mockPlatformService,
      mobileAuthenticationService: mockMobileAuthenticationService,
      mobileLoginConfiguratioMapper: mockMobileLoginConfigurationMapper,
    );
  });

  group('MobileLoginDataSourceImpl', () {
    test('should return MobileLoginUsecaseReturn on successful login',
        () async {
      final deviceInfoDto = deviceMockInfo;
      final deviceInfoAuth = deviceInfoMock;
      const environmentEnum = EnvironmentEnum.prod;
      const environment = auth.Environment.prod;
      final mobileLoginResponse = mobileLoginResponseMock;
      final mobileLoginUsecaseReturn = mobileLoginUsecaseReturnMock;

      when(() => mockPlatformService.getDeviceInfoDto())
          .thenAnswer((_) async => deviceInfoDto);
      when(
        () => mockMobileAuthenticationService.getMobileLogin(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async => mobileLoginResponse);

      when(
        () => mockMobileLoginConfigurationMapper.toMobileLoginConfigurationDto(
          mobileLoginResponse: any(named: 'mobileLoginResponse'),
        ),
      ).thenReturn(mobileLoginUsecaseReturn);

      final result = await dataSource.call(environmentEnum);

      expect(result!.activationLocal, mobileLoginUsecaseReturn.activationLocal);
      verify(() => mockPlatformService.getDeviceInfoDto()).called(1);
      verify(
        () => mockMobileAuthenticationService.getMobileLogin(
          any(),
          any(),
          any(),
        ),
      ).called(1);
      verify(
        () => mockMobileLoginConfigurationMapper.toMobileLoginConfigurationDto(
          mobileLoginResponse: any(named: 'mobileLoginResponse'),
        ),
      ).called(1);
    });

    test('should return null on ForbiddenException', () async {
      final deviceInfoDto = deviceMockInfo;
      final deviceInfoAuth = deviceInfoMock;
      const environmentEnum = EnvironmentEnum.prod;
      const environment = auth.Environment.prod;

      when(() => mockPlatformService.getDeviceInfoDto())
          .thenAnswer((_) async => deviceInfoDto);
      when(
        () => mockMobileAuthenticationService.getMobileLogin(
          any(),
          any(),
          any(),
        ),
      ).thenThrow(auth.ForbiddenException());

      final result = await dataSource.call(environmentEnum);

      expect(result, isNull);
      verify(() => mockPlatformService.getDeviceInfoDto()).called(1);
      verify(
        () => mockMobileAuthenticationService.getMobileLogin(
          any(),
          any(),
          any(),
        ),
      ).called(1);
    });

    test('should return null on generic exception', () async {
      final deviceInfoDto = deviceMockInfo;
      final deviceInfoAuth = deviceInfoMock;
      const environmentEnum = EnvironmentEnum.prod;
      const environment = auth.Environment.prod;

      when(() => mockPlatformService.getDeviceInfoDto())
          .thenAnswer((_) async => deviceInfoDto);
      when(
        () => mockMobileAuthenticationService.getMobileLogin(
          deviceInfoAuth,
          any(),
          any(),
        ),
      ).thenThrow(Exception('Generic error'));

      final result = await dataSource.call(environmentEnum);

      expect(result, isNull);
      verify(() => mockPlatformService.getDeviceInfoDto()).called(1);
      verify(
        () => mockMobileAuthenticationService.getMobileLogin(
          any(),
          any(),
          any(),
        ),
      ).called(1);
    });
  });
}
