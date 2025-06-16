import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/mobile_login_usecase_return.dart';
import '../../domain/enums/activation_situation_type.dart';
import '../../domain/enums/data_origin_type.dart';
import '../../domain/enums/status_device.dart';
import '../../domain/input_model/company_dto.dart';
import '../../domain/input_model/hlb_time_dto.dart';
import 'activation_mapper.dart';
import 'configuration_mapper.dart';
import 'employee_mapper.dart';

class MobileLoginConfigurationMapper {
  MobileLoginUsecaseReturn? toMobileLoginConfigurationDto({
    required auth.MobileLoginResponse? mobileLoginResponse,
  }) {
    if (mobileLoginResponse == null) {
      return null;
    }
    return MobileLoginUsecaseReturn(
      activationLocal:
          ActivationMapper.fromAuthToCollectorDto(mobileLoginResponse.loginActivation),
      configurationLocal:
          ConfigurationMapper.fromAuthToCollectorDto(mobileLoginResponse.loginConfiguration),
      employeeLocal: EmployeeMapper.fromAuthToCollectorDto(mobileLoginResponse.loginEmployee),
      hlbTimeLocal: toHlbTimeDtoCollector(mobileLoginResponse.hlbTime),
    );
  }

  HlbTimeDto? toHlbTimeDtoCollector(auth.HlbTimeDTO? hlbTime) {
    if (hlbTime == null) {
      return null;
    }
    return HlbTimeDto(
      hlbTime: hlbTime.hlbTime,
      defaultTimezone: hlbTime.defaultTimezone,
    );
  }

  CompanyDto convertToCompanyDto(auth.CompanyDto company) {
    return CompanyDto(
      id: company.id,
      name: company.name,
      cnpj: company.cnpj,
      dataOrigin: toDataOriginEnum(company.dataOrigin),
      timeZone: company.timeZone,
      arpId: company.arpId,
      caepf: company.caepf,
      cnoNumber: company.cnoNumber,
    );
  }

  DataOriginType toDataOriginEnum(auth.DataOriginType dataOrigin) {
    switch (dataOrigin) {
      case auth.DataOriginType.g5:
        return DataOriginType.g5;
      case auth.DataOriginType.manual:
        return DataOriginType.manual;
    }
  }

  StatusDevice toDeviceSituation(auth.StatusDevice deviceSituation) {
    switch (deviceSituation) {
      case auth.StatusDevice.authorized:
        return StatusDevice.authorized;
      case auth.StatusDevice.authorizedByEmployee:
        return StatusDevice.authorizedByEmployee;
      case auth.StatusDevice.pending:
        return StatusDevice.pending;
      case auth.StatusDevice.rejected:
        return StatusDevice.rejected;
    }
  }

  ActivationSituationType toEmployeeSituation(
      auth.ActivationSituationType employeeSituation,) {
    switch (employeeSituation) {
      case auth.ActivationSituationType.authorized:
        return ActivationSituationType.authorized;
      case auth.ActivationSituationType.pending:
        return ActivationSituationType.pending;
      case auth.ActivationSituationType.rejected:
        return ActivationSituationType.rejected;
    }
  }


  
}
