import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import 'device_dto_mock.dart';
import 'location_dto_mock.dart';

clock.ImportClockingEventDto importClockingEventDtoMock =
    clock.ImportClockingEventDto(
  appVersion: 'appVersion',
  clockingEventId: 'clockingEventId',
  companyIdentifier: 'cnpj',
  dateEvent: '2023-07-11',
  employeeId: 'employeeId',
  platform: 'platform',
  signature: 'signature',
  signatureVersion: 1,
  timeEvent: '20:52:33',
  appointmentImage: 'appointmentImage',
  clientOriginInfo: 'clientOriginInfo',
  cpf: 'cpf',
  device: deviceDtoMock,
  fenceState: clock.FenceStatusEnum.into,
  locationStatus: clock.LocationStatusEnum.location,
  mode: clock.OperationModeEnum.single,
  online: true,
  origin: clock.ClockingEventOriginEnum.mobile,
  use: 1,
  timeZone: 'timeZone',
  photoNotCaptured: 'photo',
  geolocation: locationDtoMock,
  geolocationIsMock: false,
  isSynchronized: true,
);

/*clock.ImportClockingEventDto clockingEventDtoMock =
    clock.ImportClockingEventDto(
  appVersion: 'appVersion',
  clockingEventId: 'clockingEventId',
  companyIdentifier: 'cnpj',
  dateEvent: '2023-07-11',
  employeeId: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  platform: 'platform',
  signature: 'signature',
  signatureVersion: 1,
  timeEvent: '20:52:33',
  appointmentImage: 'appointmentImage',
  clientOriginInfo: 'clientOriginInfo',
  cpf: 'cpf',
  device: deviceDtoMock,
  fenceState: clock.FenceStatusEnum.into,
  locationStatus: clock.LocationStatusEnum.location,
  mode: clock.OperationModeEnum.single,
  online: true,
  origin: clock.ClockingEventOriginEnum.mobile,
  use: 1,
  timeZone: 'timeZone',
  photoNotCaptured: 'photo',
  geolocation: locationDtoMock,
  geolocationIsMock: false,
  isSynchronized: true,
);*/
