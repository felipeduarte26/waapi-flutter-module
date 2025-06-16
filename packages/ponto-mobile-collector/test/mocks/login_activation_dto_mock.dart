import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

auth.LoginActivationDTO loginActivationDTOMock = auth.LoginActivationDTO(
  deviceSituation: auth.StatusDevice.authorized,
  employeeSituation: auth.ActivationSituationType.authorized,
  requestDate: 'requestDate',
  requestTime: 'requestTime',
);
