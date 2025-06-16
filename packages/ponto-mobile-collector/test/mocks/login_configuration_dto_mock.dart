import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import 'clocking_event_use_dto_mock.dart';

auth.LoginConfigurationDTO loginConfigurationDTOMock =
    auth.LoginConfigurationDTO(
  onlyOnline: true,
  operationMode: auth.OperationModeType.single,
  takePhoto: true,
  timezone: 'America/Sao_Paulo',
  id: 'id',
  faceRecognition: true,
  isManager: true,
  managerId: '12345',
  clockingEventUses: [clockingEventUseDTOMock],
  username: 'username@tenant.com.br',
);

auth.LoginConfigurationDTO loginConfigurationDTOFaceRecognitionNullMock =
    auth.LoginConfigurationDTO(
  onlyOnline: true,
  operationMode: auth.OperationModeType.single,
  takePhoto: true,
  timezone: 'America/Sao_Paulo',
  id: 'id',
);
