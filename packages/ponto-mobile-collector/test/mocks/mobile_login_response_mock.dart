import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import 'login_activation_dto_mock.dart';
import 'login_configuration_dto_mock.dart';
import 'login_employee_dto_mock.dart';

auth.MobileLoginResponse mobileLoginResponseMock = auth.MobileLoginResponse(
  loginConfiguration: loginConfigurationDTOMock,
  loginActivation: loginActivationDTOMock,
  loginEmployee: loginEmployeeDtoMock,
);


auth.MobileLoginResponse mobileLoginResponseWithManagersAndPlatformUsersMock = auth.MobileLoginResponse(
  loginConfiguration: loginConfigurationDTOMock,
  loginActivation: loginActivationDTOMock,
  loginEmployee: loginEmployeeDtoMockwithManagersAndPlatformUsers,
);
