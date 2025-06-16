import 'dart:developer';

import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import '../../domain/entities/mobile_login_usecase_return.dart';
import '../../domain/enums/token_type.dart';
import '../../domain/input_model/device_info_dto.dart';
import '../../domain/services/platform/iplatform_service.dart';
import '../../infra/adapters/device_adapter.dart';
import '../../infra/datasources/mobile_login_datasource.dart';
import '../../infra/utils/enum/environment_enum.dart';
import '../mappers/mobile_login_configuration_mapper.dart';

class MobileLoginDataSourceImpl implements MobileLoginDataSource {
  final IPlatformService _platformService;
  final auth.MobileAuthenticationService _mobileAuthenticationService;
  final MobileLoginConfigurationMapper _mobileLoginConfiguratioMapper;

  const MobileLoginDataSourceImpl({
    required IPlatformService platformService,
    required auth.MobileAuthenticationService mobileAuthenticationService,
    required MobileLoginConfigurationMapper mobileLoginConfiguratioMapper,
  })  : _platformService = platformService,
        _mobileAuthenticationService = mobileAuthenticationService,
        _mobileLoginConfiguratioMapper = mobileLoginConfiguratioMapper;

  @override
  Future<MobileLoginUsecaseReturn?> call(
      EnvironmentEnum environmentEnum,) async {
    DeviceInfo deviceInfoDto = await _platformService.getDeviceInfoDto();

    auth.DeviceInfo deviceInfoAuth =  DeviceAdapter.toDeviceInfoAuth(deviceInfoDto);
    
    auth.Environment environment = EnvironmentEnum.mapToAuth(environmentEnum);

    try {
       
    auth.MobileLoginResponse? mobileLoginResponse = await _mobileAuthenticationService.getMobileLogin(
        deviceInfoAuth,
        environment,
        TokenType.user.value,
      );
      var response = _mobileLoginConfiguratioMapper.toMobileLoginConfigurationDto(
              mobileLoginResponse: mobileLoginResponse,);
      return  response;
              
    } on auth.ForbiddenException catch (e) {
      log('MobileLoginUsecase: ${e.errorDescription}');
      return null;
    } catch (e) {
      log('MobileLoginUsecase: ${e.toString()}');
      return null;
    }
  }
}
