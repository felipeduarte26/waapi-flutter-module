import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';

import 'clocking_event_use_entity_mock.dart';

Configuration configurationEntityMock =
    Configuration(
  onlyOnline: true,
  operationMode: OperationModeType.single,
  takePhoto: true,
  timezone: 'America/Sao_Paulo',
  id: 'id',
  faceRecognition: true,
  isManager: true,
  managerId: '12345',
  clockingEventUses: [clockingEventUseEntityMock],
  username: 'username@tenant.com.br',
  allowGpoOnApp: true,
);

Configuration configurationEntityFaceRecognitionNullMock =
    const Configuration(
  onlyOnline: true,
  operationMode: OperationModeType.single,
  takePhoto: true,
  timezone: 'America/Sao_Paulo',
  id: 'id',
);
