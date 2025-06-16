import '../../domain/entities/clocking_event.dart';
import '../../external/drift/collector_database.dart';

class ClockingEventAdapter {

  // TO DO: verificar usabilidade, é necessário? já tem um metodo que converte dentro do repository
  static ClockingEvent fromDataTable(ClockingEventTableData dataTable) {

    return ClockingEvent(
      companyIdentifier: dataTable.companyIdentifier,
      companyName: dataTable.companyName,
      cpf: dataTable.cpf,
      dateEvent: dataTable.dateEvent,
      employeeName: dataTable.employeeName,
      signature: dataTable.signature,
      timeEvent: dataTable.timeEvent,
      timeZone: dataTable.timeZone,
      use: dataTable.use.toString(),
      isMealBreak: dataTable.isMealBreak,
      journeyEventName: dataTable.journeyEventName,
      id: dataTable.clockingEventId,
      signatureVersion: dataTable.signatureVersion,
      employeeId: dataTable.employeeId,
    );
  }
}
