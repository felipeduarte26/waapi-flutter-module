import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/clocking_event_mock.dart';
import '../../../../../../mocks/import_clocking_event_dto_mock.dart';

class MockInternalClockService extends Mock implements IInternalClockService {}

void main() {
  group('RegisterClockingState', () {
    test(
      'RegisterClockingEventState test',
      () async {
        ImportClockingEventDto dto = ImportClockingEventDto(
          clockingEventId: 'clockingEventId',
          dateEvent: '2023-01-01',
          timeEvent: '10:40',
          timeZone: '+00:00',
          companyIdentifier: 'cnpj',
          cpf: 'cpf',
          appVersion: 'appVersion',
          platform: 'platform',
          employeeId: 'employeeId',
          use: 1,
          signature: 'signature',
          signatureVersion: 2,
        );

        RegisterClockingEventState state = RegisterClockingEventState(
          data: dto,
        );

        expect(state.data, dto);
      },
    );

    test(
      'RegisterClockingEventState test',
      () async {
        expect(
          RegisterClockingEventState(data: importClockingEventDtoMock).data,
          importClockingEventDtoMock,
        );
      },
    );

    test(
      'InitialRegisterClockingEventState test',
      () async {
        expect(initialRegisterClockingEventState.data, null);
      },
    );

    test(
      'SuccessRegisterState test',
      () async {
        expect(
          SuccessRegisterState(clockingEvent: clockingEventMock).clockingEvent,
          clockingEventMock,
        );
      },
    );

    test(
      'ShowSnackbarMessageState test',
      () async {
        expect(
          ShowSnackbarMessageState(clockingEvent: clockingEventMock)
              .clockingEvent,
          clockingEventMock,
        );
      },
    );
  });
}
