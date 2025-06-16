import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:intl/intl.dart';

import '../../../../../../ponto_mobile_collector.dart';

abstract class IGetReceiptUsecase {
  ClockingEventReceiptModel call({
    required ClockingEvent clockingEvent,
    required String locale,
  });
}

class GetReceiptUsecase implements IGetReceiptUsecase {
  final IUtils utils;

  const GetReceiptUsecase({
    required this.utils,
  });

  @override
  ClockingEventReceiptModel call({
    required ClockingEvent clockingEvent,
    required String locale,
  }) {
    ClockingEventReceiptModel model = ClockingEventReceiptModel(
      date: DateFormat.yMd(locale).format(clockingEvent.getDateTimeEvent()),
      time: utils.formatTime(
        dateTime: DateTime.parse(
          '${clockingEvent.dateEvent} ${clockingEvent.timeEvent}',
        ),
        locale: locale,
      ),
      timeZone:
          'GMT ${TimeZonePontoMobile.buildByTimeZone(clockingEvent.timeZone).timeZone}',
      employeeName: clockingEvent.employeeName,
      cpf: utils.maskCPF(cpf: clockingEvent.cpf),
      companyName: clockingEvent.companyName,
      cnpj: utils.formatCNPJ(cnpj: clockingEvent.companyIdentifier),
      receiptIdentifier: clockingEvent.signature,
    );

    return model;
  }
}
