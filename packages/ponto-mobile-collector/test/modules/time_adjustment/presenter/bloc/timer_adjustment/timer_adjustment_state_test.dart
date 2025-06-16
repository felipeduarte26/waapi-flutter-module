import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'TimerAdjustmentState state test',
    () {
      // Act
      ClockingEventReceiptModel clockingEventReceiptModel =
          ClockingEventReceiptModel(
        date: '2023-01-01',
        time: '10:41:32',
        timeZone: '-03:00',
        employeeName: 'employeeName',
        cpf: '99999999999',
        companyName: 'companyName',
        cnpj: 'cnpj',
        receiptIdentifier: 'receiptIdentifier',
      );
      ReceiptTimerAdjustmentState state = ReceiptTimerAdjustmentState(
        receiptModel: clockingEventReceiptModel,
      );

      // Assert
      expect(state.receiptModel, clockingEventReceiptModel);
    },
  );
}
