import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
  as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/mobile_login_usecase_return.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/data_origin_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/company_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/hlb_time_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/mobile_login_configuration_mapper.dart';

import '../../../../../mocks/login_activation_dto_mock.dart';
import '../../../../../mocks/login_configuration_dto_mock.dart';
import '../../../../../mocks/login_employee_dto_mock.dart';
void main() {
  group('MobileLoginConfigurationMapper', () {
  final mapper = MobileLoginConfigurationMapper();

  test('toMobileLoginConfigurationDto returns null when response is null', () {
    final result = mapper.toMobileLoginConfigurationDto(mobileLoginResponse: null);
    expect(result, isNull);
  });

  test('toMobileLoginConfigurationDto maps correctly', () {
    final mockResponse = auth.MobileLoginResponse(
    loginActivation: loginActivationDTOMock,
    loginConfiguration: loginConfigurationDTOMock,
    loginEmployee: loginEmployeeDtoMock,
    hlbTime: auth.HlbTimeDTO(hlbTime: 124, defaultTimezone: 'UTC'),
    );

    final result = mapper.toMobileLoginConfigurationDto(mobileLoginResponse: mockResponse);

    expect(result, isA<MobileLoginUsecaseReturn>());
    expect(result?.hlbTimeLocal?.defaultTimezone, 'UTC');
  });

  test('toHlbTimeDtoCollector returns null when hlbTime is null', () {
    final result = mapper.toHlbTimeDtoCollector(null);
    expect(result, isNull);
  });

  test('toHlbTimeDtoCollector maps correctly', () {
    final mockHlbTime = auth.HlbTimeDTO(hlbTime: 124, defaultTimezone: 'UTC');
    final result = mapper.toHlbTimeDtoCollector(mockHlbTime);

    expect(result, isA<HlbTimeDto>());
    expect(result?.defaultTimezone, 'UTC');
  });

  test('convertToCompanyDto maps correctly', () {
    final mockCompany = auth.CompanyDto(
    id: '1',
    name: 'Test Company',
    cnpj: '123456789',
    dataOrigin: auth.DataOriginType.g5,
    timeZone: 'UTC',
    arpId: 'ARP123',
    caepf: 'CAEPF123',
    cnoNumber: 'CNO123',
    );

    final result = mapper.convertToCompanyDto(mockCompany);

    expect(result, isA<CompanyDto>());
    expect(result.id, '1');
    expect(result.name, 'Test Company');
    expect(result.dataOrigin, DataOriginType.g5);
  });

  test('toDataOriginEnum maps correctly', () {
    expect(mapper.toDataOriginEnum(auth.DataOriginType.g5), DataOriginType.g5);
    expect(mapper.toDataOriginEnum(auth.DataOriginType.manual), DataOriginType.manual);
  });

  test('toDeviceSituation maps correctly', () {
    expect(mapper.toDeviceSituation(auth.StatusDevice.authorized), StatusDevice.authorized);
    expect(mapper.toDeviceSituation(auth.StatusDevice.pending), StatusDevice.pending);
  });

  test('toEmployeeSituation maps correctly', () {
    expect(mapper.toEmployeeSituation(auth.ActivationSituationType.authorized),
      ActivationSituationType.authorized,);
    expect(mapper.toEmployeeSituation(auth.ActivationSituationType.rejected),
      ActivationSituationType.rejected,);
  });
  });
}