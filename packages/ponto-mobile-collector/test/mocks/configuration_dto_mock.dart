import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/configuration_dto.dart';

import 'clocking_event_use_dto_mock.dart';

ConfigurationDto configurationDTOMock =
    ConfigurationDto(
  onlyOnline: true,
  operationMode: OperationModeType.single,
  takePhoto: true,
  timezone: 'America/Sao_Paulo',
  id: 'id',
  faceRecognition: true,
  isManager: true,
  managerId: '12345',
  clockingEventUses: [clockingEventUseMockDto],
  username: 'username@tenant.com.br',
);

ConfigurationDto configurationDTOFaceRecognitionNullMock =
    ConfigurationDto(
  onlyOnline: true,
  operationMode: OperationModeType.single,
  takePhoto: true,
  timezone: 'America/Sao_Paulo',
  id: 'id',
);
