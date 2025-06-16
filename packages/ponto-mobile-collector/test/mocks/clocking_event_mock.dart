import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event.dart';

import 'device_entity_mock.dart';

ClockingEvent clockingEventMock = ClockingEvent(
  companyIdentifier: '41455758000100',
  companyName: 'Senior Sistemas S/A',
  cpf: '60918842042',
  dateEvent: '2023-10-29',
  employeeName: 'José Antônio',
  signature: 'signature',
  timeEvent: '20:44',
  timeZone: '-03:00',
  use: '2',
  employeeId: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  id: '1234567',
  signatureVersion: 1,
  appVersion: '2',
  appointmentImage: '',
  clientOriginInfo: 'clientOriginInfo',
  device: deviceEntityMock,
  facialRecognitionStatus: 'facialRecognitionStatus',
  isMealBreak: true,
);
