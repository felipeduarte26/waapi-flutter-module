import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  ClockingEventReceiptModel model = ClockingEventReceiptModel(
    date: '202-05-12',
    time: '12:51',
    timeZone: '-0300',
    employeeName: 'employeeName',
    cpf: '00000000000',
    companyName: 'companyName',
    cnpj: '000000000000000',
    receiptIdentifier: 'c4d4d491764cacc7f5391cdcfc240f7e',
  );

  Widget getWidget(String locale) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: Column(
            children: [
              ClockingEventReceiptWidget(
                receipt: model,
              ),
            ],
          ),
        ),
      ),
    );
  }

  group(
    'ClockingEventReceiptWidget test',
    () {
      testWidgets(
        'ClockingEventReceiptWidget pt translation test',
        (tester) async {
          Widget widget = getWidget('pt');

          await tester.pumpWidget(
            widget,
          );

          expect(find.text('Comprovante de marcação'), findsOneWidget);
          expect(find.text('Data'), findsOneWidget);
          expect(find.text('Horário'), findsOneWidget);
          expect(find.text('Fuso'), findsOneWidget);
          expect(find.text('Colaborador'), findsOneWidget);
          expect(find.text('CPF'), findsOneWidget);
          expect(find.text('Empresa'), findsOneWidget);
          expect(find.text('CNPJ'), findsOneWidget);
          expect(find.text('Identificação da Marcação'), findsOneWidget);
          expect(find.text('Fechar'), findsOneWidget);
          expect(find.text(model.date), findsOneWidget);
          expect(find.text(model.time), findsOneWidget);
          expect(find.text(model.timeZone), findsOneWidget);
          expect(find.text(model.employeeName), findsOneWidget);
          expect(find.text(model.cpf), findsOneWidget);
          expect(find.text(model.cnpj), findsOneWidget);
          expect(find.text(model.companyName), findsOneWidget);
        },
      );

      testWidgets(
        'ClockingEventReceiptWidget en translation test',
        (tester) async {
          Widget widget = getWidget('en');

          await tester.pumpWidget(
            widget,
          );

          expect(find.text('Clocking event receipt'), findsOneWidget);
          expect(find.text('Date'), findsOneWidget);
          expect(find.text('Time'), findsOneWidget);
          expect(find.text('Time Zone'), findsOneWidget);
          expect(find.text('Employee'), findsOneWidget);
          expect(find.text('CPF'), findsOneWidget);
          expect(find.text('Company'), findsOneWidget);
          expect(find.text('CNPJ'), findsOneWidget);
          expect(find.text('Clocking event identifier'), findsOneWidget);
          expect(find.text('Close'), findsOneWidget);
          expect(find.text(model.date), findsOneWidget);
          expect(find.text(model.time), findsOneWidget);
          expect(find.text(model.timeZone), findsOneWidget);
          expect(find.text(model.employeeName), findsOneWidget);
          expect(find.text(model.cpf), findsOneWidget);
          expect(find.text(model.cnpj), findsOneWidget);
          expect(find.text(model.companyName), findsOneWidget);
        },
      );

      testWidgets(
        'ClockingEventReceiptWidget es translation test',
        (tester) async {
          Widget widget = getWidget('es');

          await tester.pumpWidget(
            widget,
          );

          expect(find.text('Comprobante de Marcación'), findsOneWidget);
          expect(find.text('Fecha'), findsOneWidget);
          expect(find.text('Hora'), findsOneWidget);
          expect(find.text('Zona'), findsOneWidget);
          expect(find.text('Empleado'), findsOneWidget);
          expect(find.text('CPF'), findsOneWidget);
          expect(find.text('Empresa'), findsOneWidget);
          expect(find.text('CNPJ'), findsOneWidget);
          expect(find.text('Identificador de marcación'), findsOneWidget);
          expect(find.text('Cerrar'), findsOneWidget);
          expect(find.text(model.date), findsOneWidget);
          expect(find.text(model.time), findsOneWidget);
          expect(find.text(model.timeZone), findsOneWidget);
          expect(find.text(model.employeeName), findsOneWidget);
          expect(find.text(model.cpf), findsOneWidget);
          expect(find.text(model.cnpj), findsOneWidget);
          expect(find.text(model.companyName), findsOneWidget);
        },
      );
    },
  );
}
