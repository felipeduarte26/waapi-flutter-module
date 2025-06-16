
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';

import 'clock_company_dto_mock.dart';
import 'device_dto_mock.dart';
import 'employee_dto_mock.dart';

ClockingEventDto clockingEventDtoMock =
    ClockingEventDto(
   companyIdentifier: '41455758000100',
  companyDto: companyDtoMock,
  cpf: '60918842042',
  dateEvent: '2023-10-29',
  employeeDto: employeeMockDto,
  signature: 'signature',
  timeEvent: '20:44',
  timeZone: '-03:00',
  use: '2',
  clockingEventId: '1234567',
  signatureVersion: 1,
  appVersion: '2',
  appointmentImage: '',
  clientOriginInfo: 'clientOriginInfo',
  device: deviceMockDto,
  facialRecognitionStatus: 'facialRecognitionStatus',
  isMealBreak: true,
  platform: '',
);


ClockingEventDto clockingEventDtoMock2 =
    ClockingEventDto(
   companyIdentifier: '41455758000100',
  companyDto: companyDtoMock,
  cpf: '60918842042',
  dateEvent: '2023-10-29',
  employeeDto: employeeMockDto2,
  signature: 'signature',
  timeEvent: '20:44',
  timeZone: '-03:00',
  use: '2',
  clockingEventId: '1234567',
  signatureVersion: 1,
  appVersion: '2',
  appointmentImage: '',
  clientOriginInfo: 'clientOriginInfo',
  device: deviceMockDto,
  facialRecognitionStatus: 'facialRecognitionStatus',
  isMealBreak: true,
  platform: '',
);
