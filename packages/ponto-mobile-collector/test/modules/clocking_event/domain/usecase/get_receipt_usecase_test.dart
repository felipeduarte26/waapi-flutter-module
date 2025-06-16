import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_receipt_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/clocking_event_mock.dart';

class FakeLoginConfigurationDTO extends Fake
    implements auth.LoginConfigurationDTO {
  @override
  final bool takePhoto;

  FakeLoginConfigurationDTO({required this.takePhoto});
}

void main() {
  late IGetReceiptUsecase getReceiptUsecase;
  final IUtils utils = Utils();

  setUp(
    () {
      getReceiptUsecase = GetReceiptUsecase(
        utils: Utils(),
      );
    },
  );

  group(
    'TakePhotoConfigUsecase',
    () {
      test(
        'call test.',
        () async {
          initializeDateFormatting();

          ClockingEventReceiptModel receipt = getReceiptUsecase.call(
            clockingEvent: clockingEventMock,
            locale: 'pt',
          );

          expect(
            receipt.cnpj,
            utils.formatCNPJ(cnpj: clockingEventMock.companyIdentifier),
          );
          expect(receipt.companyName, clockingEventMock.companyName);
          expect(receipt.cpf, utils.maskCPF(cpf: clockingEventMock.cpf));
          expect(receipt.date, '29/10/2023');
          expect(receipt.employeeName, clockingEventMock.employeeName);
          expect(receipt.receiptIdentifier, clockingEventMock.signature);
          expect(
            receipt.timeZone,
            'GMT ${clock.TimeZonePontoMobile.buildByTimeZone(clockingEventMock.timeZone).timeZone}',
          );
        },
      );
    },
  );
}
