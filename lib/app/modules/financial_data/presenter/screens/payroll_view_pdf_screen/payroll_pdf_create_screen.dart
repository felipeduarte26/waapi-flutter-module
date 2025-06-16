import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/constants/supported_locales.dart';
import '../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../core/helper/cnpj_formatter.dart';
import '../../../../../core/helper/cpf_formatter.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../routes/attachment_routes.dart';
import '../../../../personalization/domain/entities/personalization_entity.dart';
import '../../../../profile/domain/entities/contract_employee_entity.dart';
import '../../../../profile/domain/entities/profile_entity.dart';
import '../../../../profile/presenter/string_formatters/salary_data_formatter.dart';
import '../../../domain/entities/payroll_entity.dart';
import '../../../enum/calculation_type_enum.dart';
import '../../../enum/payment_type_enum.dart';
import '../../../enum/wage_type_enum.dart';
import '../../../helper/senior_pdf_color.dart';

class PayrollPdfCreateScreen {
  static Future<void> createPdf({
    required PayrollEntity payroll,
    required AppLocalizations appLocalizations,
    required PersonalizationEntity personalizationEntity,
    required ProfileEntity profileEntity,
    required ContractEmployeeEntity contractEmployeeEntity,
    required VoidCallback onFinishedCreate,
    required VoidCallback onFinishedCreateError,
    required String titlePage,
    required String companyName,
  }) async {
    try {
      pw.ImageProvider logoImage;
      String? jobPositionName;
      if (payroll.historicalJobPositions != null) {
        jobPositionName = payroll.historicalJobPositions?.name;
      } else {
        jobPositionName = contractEmployeeEntity.jobPositionName;
      }
      var logoPersonalizationUrl = '';
      bool islogoPreviewImageURL = false;
      if (personalizationEntity.logoPreviewImageURL != null) {
        logoPersonalizationUrl = personalizationEntity.logoPreviewImageURL!;
        islogoPreviewImageURL = true;
      }
      try {
        logoImage = logoPersonalizationUrl.isEmpty
            ? pw.MemoryImage((await rootBundle.load(AssetsPath.appIconPng)).buffer.asUint8List())
            : await networkImage(logoPersonalizationUrl);
      } catch (e) {
        logoImage = pw.MemoryImage((await rootBundle.load(AssetsPath.appIconPng)).buffer.asUint8List());
        islogoPreviewImageURL = false;
      }

      final fontNomal = await rootBundle.load(AssetsPath.arialFont);
      final ttfNormal = pw.Font.ttf(fontNomal);
      final fontBold = await rootBundle.load(AssetsPath.arialBoldFont);
      final ttfBold = pw.Font.ttf(fontBold);

      final pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          header: (context) {
            return pw.Header(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: SeniorPdfColor.secondaryColor100,
                    width: 1,
                  ),
                ),
              ),
              level: 1,
              padding: const pw.EdgeInsets.only(
                bottom: SeniorSpacing.xsmall,
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Flexible(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          height: SeniorSpacing.xxsmall,
                        ),
                        pw.Text(
                          '${appLocalizations.salaryPaymentStatement} - ${paymentReference(
                            paymentReference: payroll.calculation!.paymentReference!,
                            locale: appLocalizations.localeName,
                          )}',
                          textScaleFactor: 2,
                          style: pw.TextStyle(
                            fontSize: 7.63,
                            fontWeight: pw.FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        pw.SizedBox(
                          height: SeniorSpacing.xxsmall,
                        ),
                        pw.Text(
                          payroll.calculation!.type != null
                              ? payroll.calculation!.type!.name(
                                  appLocalizations,
                                )
                              : CalculationTypeEnum.calculoMensal.name(
                                  appLocalizations,
                                ),
                          textScaleFactor: 2,
                          style: pw.TextStyle(
                            fontSize: 5.39,
                            fontWeight: pw.FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        _buildRowHeader(
                          letfTitle: appLocalizations.company,
                          leftValue: companyName,
                          rightTitle: appLocalizations.nationalRegisterOfLegalEntities,
                          rightValue: CnpjFormatter.cnpjFormatter(
                            cnpj: contractEmployeeEntity.employer!.cnpj!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(
                      right: SeniorSpacing.xxsmall,
                    ),
                    child: pw.Container(
                      height: SeniorSpacing.big,
                      width: SeniorSpacing.big,
                      color: islogoPreviewImageURL ? SeniorPdfColor.secondaryColor200 : SeniorPdfColor.pureWhite,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(
                          SeniorSpacing.xxsmall,
                        ),
                        child: pw.Center(
                          child: pw.Image(
                            alignment: pw.Alignment.center,
                            logoImage,
                            height: SeniorSpacing.big,
                            width: SeniorSpacing.big,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          build: (context) {
            return <pw.Widget>[
              _buildRowHeader(
                isFirst: true,
                letfTitle: appLocalizations.employee,
                leftValue: profileEntity.name,
                rightTitle: appLocalizations.cpfAbbreviate,
                rightValue: CPFFormatter.cpfFormatter(
                  cpf: profileEntity.cpf!,
                ),
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.registrationNumber,
                leftValue: contractEmployeeEntity.registerNumber!.toString(),
                rightTitle: appLocalizations.cboJobCodeAbbreviate,
                rightValue: contractEmployeeEntity.cboCode != null ? contractEmployeeEntity.cboCode!.toString() : '',
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.admissionDate,
                leftValue: DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: contractEmployeeEntity.hireDate!,
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Locale(appLocalizations.localeName),
                  ),
                ),
                rightTitle: jobPositionName != null ? appLocalizations.job : '',
                rightValue: jobPositionName ?? '',
              ),
              _buildRowHeader(
                letfTitle: payroll.details?.paymentType == PaymentTypeEnum.bankDeposit
                    ? appLocalizations.profileBankName
                    : appLocalizations.paymentType,
                leftValue: _paymentType(
                  appLocalizations: appLocalizations,
                  bankNameDeposit: payroll.details!.bankPayment?.first.bank,
                  paymentTypeEnum: payroll.details?.paymentType ?? PaymentTypeEnum.empty,
                ),
                rightTitle: appLocalizations.profileBranch,
                rightValue: payroll.details!.bankPayment?.first.agency ?? '',
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.profileAccountNumber,
                leftValue: payroll.details!.bankPayment?.first.account ?? '',
                rightTitle: appLocalizations.paymentDate,
                rightValue: DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: payroll.calculation!.paymentDate!,
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Locale(appLocalizations.localeName),
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                  top: SeniorSpacing.xsmall,
                ),
                child: pw.Table(
                  tableWidth: pw.TableWidth.max,
                  border: pw.TableBorder(
                    left: _borderSideBuilder(),
                    right: _borderSideBuilder(),
                    top: _borderSideBuilder(),
                    bottom: _borderSideBuilder(),
                    horizontalInside: _borderSideBuilder(),
                  ),
                  children: _buildTableRow(
                    payroll: payroll,
                    fontBold: ttfBold,
                    fontNormal: ttfNormal,
                    appLocalizations: appLocalizations,
                  ),
                ),
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.numberDependentsIncomeTax,
                leftValue: payroll.amountDependentsForIncomeTax.toString(),
                rightTitle: appLocalizations.numberDependentsFamilySalary,
                rightValue: payroll.amountDependentsForFamilySalary.toString(),
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.baseSalary,
                leftValue: SalaryDataFormatter.salaryFormatter(
                  currencyTypeEnum: payroll.currency,
                  salary: payroll.referenceSalary!,
                ),
                rightTitle: appLocalizations.inssCalculationBasis,
                rightValue: SalaryDataFormatter.salaryFormatter(
                  currencyTypeEnum: payroll.currency,
                  salary: payroll.baseValueINSS!,
                ),
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.incometTaxCalculationBasis,
                leftValue: SalaryDataFormatter.salaryFormatter(
                  currencyTypeEnum: payroll.currency,
                  salary: payroll.baseValueIR!,
                ),
                rightTitle: appLocalizations.fgtsCalculationBasis,
                rightValue: SalaryDataFormatter.salaryFormatter(
                  currencyTypeEnum: payroll.currency,
                  salary: payroll.baseValueFGTS!,
                ),
              ),
              _buildRowHeader(
                letfTitle: appLocalizations.fgtsMonth,
                leftValue: SalaryDataFormatter.salaryFormatter(
                  currencyTypeEnum: payroll.currency,
                  salary: payroll.valueFGTS!,
                ),
                rightTitle: '',
                rightValue: '',
              ),
            ];
          },
          footer: (context) {
            return pw.Column(
              children: [
                pw.Divider(
                  color: SeniorPdfColor.secondaryColor200,
                  thickness: 0.5,
                ),
                pw.Footer(
                  leading: pw.Text(
                    companyName,
                    style: const pw.TextStyle(
                      fontSize: SeniorSpacing.small,
                    ),
                  ),
                  trailing: pw.Text(
                    appLocalizations.pageTo(
                      context.pageNumber.toString(),
                      context.pagesCount.toString(),
                    ),
                    style: const pw.TextStyle(
                      fontSize: SeniorSpacing.small,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/${payroll.calculation!.paymentReference}.pdf';
      final file = File(path);
      await file.writeAsBytes(
        await pdf.save(),
      );
      Modular.to.pushNamed(
        AttachmentRoutes.attachmentPdfScreenInitialRoute,
        arguments: {
          'filePath': path,
          'title': titlePage,
          'pdfErrorAnalytics': AnalyticsEventEnum.payrollPdfCreatedError,
          'pdfSharedAnalytics': AnalyticsEventEnum.payrollPdfShared,
        },
      );
    } catch (e) {
      onFinishedCreateError();
    } finally {
      onFinishedCreate();
    }
  }

  static String paymentReference({
    required String paymentReference,
    required String locale,
  }) {
    final dateReference = '$paymentReference-01';
    final dateConvert = DateTimeHelper.convertStringAaaaMmDdToDateTime(
      stringToConvert: dateReference,
    );
    String month = dateConvert!.month < 10 ? '0${dateConvert.month}' : '${dateConvert.month}';
    switch (LocaleHelper.languageAndCountryCode(locale: Locale(locale))) {
      case SupportedLocales.americanEnglish:
        return paymentReference;
      case SupportedLocales.brazilianPortuguese:
      case SupportedLocales.spainSpanish:
      case SupportedLocales.colombianSpanish:
        return '$month/${dateConvert.year}';
      default:
        return '$month/${dateConvert.year}';
    }
  }

  static String _paymentType({
    required PaymentTypeEnum paymentTypeEnum,
    required AppLocalizations appLocalizations,
    required String? bankNameDeposit,
  }) {
    switch (paymentTypeEnum) {
      case PaymentTypeEnum.empty:
        return '';
      case PaymentTypeEnum.money:
        return PaymentTypeEnum.money.name(appLocalizations);
      case PaymentTypeEnum.check:
        return PaymentTypeEnum.check.name(appLocalizations);
      case PaymentTypeEnum.bankDeposit:
        return bankNameDeposit ?? '';
      case PaymentTypeEnum.moneyOrder:
        return PaymentTypeEnum.moneyOrder.name(appLocalizations);
    }
  }

  static pw.BorderSide _borderSideBuilder() {
    return const pw.BorderSide(
      color: SeniorPdfColor.secondaryColor200,
      width: 1,
    );
  }
}

pw.TableRow _buildTableHead({pw.Font? font, required AppLocalizations appLocalizations}) {
  return pw.TableRow(
    decoration: const pw.BoxDecoration(
      color: SeniorPdfColor.secondaryColor200,
    ),
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: pw.Text(
          appLocalizations.description,
          style: _textStyle(
            font: font,
            isColorDefault: true,
          ),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: pw.Text(
          appLocalizations.reference,
          style: _textStyle(
            font: font,
            isColorDefault: true,
          ),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: pw.Text(
          appLocalizations.proceeds,
          style: _textStyle(
            font: font,
            isColorDefault: true,
          ),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: pw.Text(
          appLocalizations.deductions,
          style: _textStyle(
            font: font,
            isColorDefault: true,
          ),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: pw.Text(
          appLocalizations.informative,
          style: _textStyle(
            font: font,
            isColorDefault: true,
          ),
        ),
      ),
    ],
  );
}

List<pw.TableRow> _buildTableRow({
  required PayrollEntity payroll,
  required AppLocalizations appLocalizations,
  pw.Font? fontNormal,
  pw.Font? fontBold,
}) {
  List<double> proceeds = [0];
  List<double> advantages = [0];
  List<double> deductions = [0];

  if (payroll.wageTypes != null &&
      payroll.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.proceeds).isNotEmpty) {
    for (var proceed in payroll.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.proceeds)) {
      proceeds.add(proceed.actualValue ?? 0);
    }
  }

  double totalProceeds = proceeds.reduce((buffer, number) => buffer + number);

  if (payroll.wageTypes != null &&
      payroll.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.advantage).isNotEmpty) {
    for (var advantage in payroll.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.advantage)) {
      advantages.add(advantage.actualValue ?? 0);
    }
  }

  double totalAdvantage = advantages.reduce((buffer, number) => buffer + number);

  if (payroll.wageTypes != null &&
      payroll.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.deduction).isNotEmpty) {
    for (var deduction in payroll.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.deduction)) {
      deductions.add(deduction.actualValue ?? 0);
    }
  }

  double totalDeductions = deductions.reduce((buffer, number) => buffer + number);

  List<pw.TableRow> rows = [];

  rows.add(
    _buildTableHead(
      font: fontNormal,
      appLocalizations: appLocalizations,
    ),
  );

  for (var i = 0; i < payroll.wageTypes!.length; i++) {
    rows.add(
      pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              payroll.wageTypes![i].wageType!.name!,
              style: _textStyle(
                font: fontNormal,
                wageTypeEnum: payroll.wageTypes?[i].wageType!.type,
                isColorDefault: true,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              payroll.wageTypes![i].referenceValue!.toStringAsFixed(2),
              style: _textStyle(
                font: fontNormal,
                wageTypeEnum: payroll.wageTypes?[i].wageType!.type,
                isColorDefault: true,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              payroll.wageTypes?[i].wageType?.type == null
                  ? '-'
                  : payroll.wageTypes?[i].wageType?.type == WageTypeEnum.proceeds
                      ? SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: payroll.currency,
                          salary: payroll.wageTypes?[i].actualValue ?? 0,
                        )
                      : payroll.wageTypes?[i].wageType?.type == WageTypeEnum.advantage
                          ? SalaryDataFormatter.salaryFormatter(
                              currencyTypeEnum: payroll.currency,
                              salary: payroll.wageTypes?[i].actualValue ?? 0,
                            )
                          : '-',
              style: _textStyle(
                font: fontNormal,
                wageTypeEnum: payroll.wageTypes?[i].wageType!.type,
                isColorDefault: payroll.wageTypes?[i].wageType?.type == null ||
                    (payroll.wageTypes?[i].wageType?.type != WageTypeEnum.proceeds ||
                        payroll.wageTypes?[i].wageType?.type != WageTypeEnum.advantage),
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              payroll.wageTypes?[i].wageType?.type == null
                  ? '-'
                  : payroll.wageTypes?[i].wageType?.type == WageTypeEnum.deduction
                      ? '-${SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: payroll.currency,
                          salary: payroll.wageTypes?[i].actualValue ?? 0,
                        )}'
                      : '-',
              style: _textStyle(
                font: fontNormal,
                wageTypeEnum: payroll.wageTypes?[i].wageType?.type,
                isColorDefault: payroll.wageTypes?[i].wageType?.type == null ||
                    payroll.wageTypes?[i].wageType?.type != WageTypeEnum.deduction,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              payroll.wageTypes?[i].wageType?.type == null ||
                      payroll.wageTypes?[i].wageType?.type == WageTypeEnum.deduction ||
                      payroll.wageTypes?[i].wageType?.type == WageTypeEnum.proceeds ||
                      payroll.wageTypes?[i].wageType?.type == WageTypeEnum.advantage
                  ? '-'
                  : SalaryDataFormatter.salaryFormatter(
                      currencyTypeEnum: payroll.currency,
                      salary: payroll.wageTypes?[i].actualValue ?? 0,
                    ),
              style: _textStyle(
                font: fontNormal,
                wageTypeEnum: payroll.wageTypes?[i].wageType!.type,
                isColorDefault: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  var count = 2;
  for (var i = 0; i < count; i++) {
    rows.add(
      pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              i == 0 ? appLocalizations.totals : appLocalizations.netReceivableValue,
              style: _textStyle(
                font: fontBold,
                isColorDefault: true,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              '',
              style: _textStyle(
                font: fontBold,
                isColorDefault: true,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              i == 0
                  ? SalaryDataFormatter.salaryFormatter(
                      currencyTypeEnum: payroll.currency,
                      salary: totalProceeds + totalAdvantage,
                    )
                  : SalaryDataFormatter.salaryFormatter(
                      currencyTypeEnum: payroll.currency,
                      salary: payroll.netValue!,
                    ),
              style: _textStyle(
                font: fontBold,
                wageTypeEnum: WageTypeEnum.proceeds,
                isColorDefault: i != 0,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: pw.Text(
              i == 0
                  ? '-${SalaryDataFormatter.salaryFormatter(
                      currencyTypeEnum: payroll.currency,
                      salary: totalDeductions,
                    )}'
                  : '',
              style: _textStyle(
                font: fontBold,
                wageTypeEnum: WageTypeEnum.deduction,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(
              SeniorSpacing.xsmall,
            ),
            child: pw.Text(
              '',
              style: _textStyle(
                font: fontBold,
                isColorDefault: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  return rows;
}

pw.TextStyle _textStyle({
  pw.Font? font,
  WageTypeEnum? wageTypeEnum,
  bool isColorDefault = false,
  pw.FontWeight? fontWeight = pw.FontWeight.normal,
}) {
  PdfColor? color;

  if (wageTypeEnum == null || isColorDefault) {
    color = SeniorPdfColor.pureBlack;
  } else if (wageTypeEnum == WageTypeEnum.proceeds) {
    color = SeniorPdfColor.primaryColor600;
  } else if (wageTypeEnum == WageTypeEnum.deduction) {
    color = SeniorPdfColor.manchesterColorRed500;
  }
  return pw.TextStyle(
    fontWeight: fontWeight,
    color: color,
    fontSize: 11,
    height: 1.2,
    font: font,
  );
}

pw.Widget _buildRowHeader({
  required String letfTitle,
  required String leftValue,
  required String rightTitle,
  required String rightValue,
  bool isFirst = false,
  pw.EdgeInsets? padding,
}) {
  return pw.Container(
    padding: padding ??
        pw.EdgeInsets.only(
          top: isFirst ? 0 : SeniorSpacing.xsmall,
        ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Container(
          width: PdfPageFormat.a4.width / 2,
          child: pw.Container(
            child: pw.RichText(
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(
                    text: letfTitle == '' ? '' : '$letfTitle: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: SeniorPdfColor.pureBlack,
                      fontSize: SeniorSpacing.small,
                      height: 1.0,
                    ),
                  ),
                  pw.TextSpan(
                    text: leftValue,
                    style: pw.TextStyle(
                      fontSize: SeniorSpacing.small,
                      fontWeight: pw.FontWeight.normal,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.Container(
            child: pw.RichText(
              textAlign: pw.TextAlign.left,
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(
                    text: rightTitle == '' ? '' : '$rightTitle: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: SeniorPdfColor.pureBlack,
                      fontSize: SeniorSpacing.small,
                      height: 1.0,
                    ),
                  ),
                  pw.TextSpan(
                    text: rightValue,
                    style: pw.TextStyle(
                      fontSize: SeniorSpacing.small,
                      fontWeight: pw.FontWeight.normal,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
