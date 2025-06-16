import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../profile/presenter/string_formatters/salary_data_formatter.dart';
import '../../../../domain/entities/payroll_entity.dart';
import '../../../../enum/calculation_type_enum.dart';
import '../../../../enum/wage_type_enum.dart';
import '../../../bloc/payroll_bloc/payroll_bloc.dart';
import '../../../bloc/payroll_bloc/payroll_event.dart';
import '../../../bloc/payroll_bloc/payroll_state.dart';
import '../../payroll_filter_screen/payroll_filter_screen.dart';
import 'money_icons.dart';

class PayrollTabContent extends StatefulWidget {
  final String employeeId;
  final PayrollBloc payrollBloc;
  final PayrollEntity payrollEntity;

  const PayrollTabContent({
    Key? key,
    required this.employeeId,
    required this.payrollBloc,
    required this.payrollEntity,
  }) : super(key: key);

  @override
  State<PayrollTabContent> createState() => _PayrollTabContentState();
}

class _PayrollTabContentState extends State<PayrollTabContent> {
  bool showValues = false;

  @override
  Widget build(BuildContext context) {
    List<double> proceeds = [0];
    List<double> advantages = [0];
    List<double> deductions = [0];

    if (widget.payrollEntity.wageTypes != null &&
        widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.proceeds).isNotEmpty) {
      for (var proceed in widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.proceeds)) {
        proceeds.add(proceed.actualValue ?? 0);
      }
    }

    double totalProceeds = proceeds.reduce((buffer, number) => buffer + number);

    if (widget.payrollEntity.wageTypes != null &&
        widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.advantage).isNotEmpty) {
      for (var advantage in widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.advantage)) {
        advantages.add(advantage.actualValue ?? 0);
      }
    }

    double totalAdvantages = advantages.reduce((buffer, number) => buffer + number);

    if (widget.payrollEntity.wageTypes != null &&
        widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.deduction).isNotEmpty) {
      for (var proceed in widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.deduction)) {
        deductions.add(proceed.actualValue ?? 0);
      }
    }

    double totalDeductions = deductions.reduce((buffer, number) => buffer + number);

    final isDarkTheme = Provider.of<ThemeRepository>(context).isDarkTheme();

    return BlocBuilder<PayrollBloc, PayrollState>(
      bloc: widget.payrollBloc,
      builder: (context, state) {
        if (state is LoadedPayrollState ||
            state is LoadedPayrollSelectedState ||
            state is LastPagePayrollState ||
            state is LoadingMorePayrollgState) {
          return Scrollbar(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.normal,
                  ),
                  child: SeniorText.cta(
                    context.translate.paymentStatement,
                    color: SeniorColors.neutralColor800,
                  ),
                ),
                SeniorTextField(
                  readOnly: true,
                  onTap: () {
                    widget.payrollBloc.add(
                      GetPayrollListEvent(
                        employeerId: widget.employeeId,
                        paginationRequirements: const PaginationRequirements(
                          page: 1,
                          limit: 10,
                        ),
                      ),
                    );
                    documentCheckboxes(context);
                  },
                  disabled: false,
                  suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
                  helper: context.translate.searchStatement,
                  hintText: widget.payrollEntity.calculation?.paymentReference != null
                      ? paymentReference(
                          date: widget.payrollEntity.calculation!.paymentReference!,
                          calculationType: widget.payrollEntity.calculation!.type != null
                              ? widget.payrollEntity.calculation!.type!.name(context.translate)
                              : CalculationTypeEnum.calculoMensal.name(context.translate),
                        )
                      : context.translate.monthlyCalculation,
                  style: SeniorTextFieldStyle(
                    focusColor: isDarkTheme ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                    hintTextColor: isDarkTheme ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                    textColor: isDarkTheme ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: SeniorSpacing.normal,
                  ),
                  child: SeniorText.label(
                    context.translate.netValue,
                    color: SeniorColors.neutralColor700,
                  ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: showValues,
                      replacement: SizedBox(
                        width: 120,
                        child: Material(
                          borderRadius: BorderRadius.circular(
                            SeniorSpacing.normal,
                          ),
                          color: isDarkTheme ? SeniorColors.secondaryColor700 : SeniorColors.secondaryColor100,
                          child: SeniorText.body(
                            '',
                          ),
                        ),
                      ),
                      child: SeniorText.h4(
                        SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: widget.payrollEntity.currency,
                          salary: widget.payrollEntity.netValue ?? 0,
                        ),
                        color: SeniorColors.neutralColor800,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.small,
                    ),
                    Visibility(
                      visible: showValues,
                      replacement: SeniorIconButton(
                        icon: FontAwesomeIcons.solidEyeSlash,
                        onTap: () {
                          setState(() {
                            showValues = !showValues;
                          });
                        },
                        size: SeniorIconButtonSize.small,
                        type: SeniorIconButtonType.secondary,
                        style: SeniorIconButtonStyle(
                          buttonColor: Colors.transparent,
                          iconColor: isDarkTheme ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                        ),
                      ),
                      child: SeniorIconButton(
                        icon: FontAwesomeIcons.solidEye,
                        onTap: () {
                          setState(() {
                            showValues = !showValues;
                          });
                        },
                        size: SeniorIconButtonSize.small,
                        type: SeniorIconButtonType.secondary,
                        style: SeniorIconButtonStyle(
                          buttonColor: Colors.transparent,
                          iconColor: isDarkTheme ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.medium,
                  ),
                  child: SeniorText.bodyBold(
                    color: SeniorColors.neutralColor700,
                    _toReceivedPaidPayment(monthPayment: widget.payrollEntity.calculation!.paymentDate!),
                  ),
                ),
                Row(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(
                        SeniorSpacing.normal,
                      ),
                      color: SeniorColors.primaryColor100,
                      child: AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        curve: Curves.easeInOutCubicEmphasized,
                        height: SeniorSpacing.xmedium,
                        width: SeniorSpacing.xmedium,
                        child: const SeniorIcon(
                          icon: MoneyIcons.moneyMore,
                          size: SeniorSpacing.normal,
                          style: SeniorIconStyle(
                            color: SeniorColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.xsmall,
                    ),
                    SeniorText.label(
                      context.translate.proceeds,
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Visibility(
                      visible: showValues,
                      replacement: SizedBox(
                        width: 100,
                        child: Material(
                          borderRadius: BorderRadius.circular(
                            SeniorSpacing.normal,
                          ),
                          color: isDarkTheme ? SeniorColors.secondaryColor700 : SeniorColors.secondaryColor100,
                          child: SeniorText.body(''),
                        ),
                      ),
                      child: SeniorText.labelBold(
                        SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: widget.payrollEntity.currency,
                          salary: totalProceeds + totalAdvantages,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.big,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.payrollEntity.wageTypes != null)
                        for (var proceed
                            in widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.proceeds))
                          Row(
                            children: [
                              SeniorText.small(proceed.wageType!.name!),
                              const Expanded(child: SizedBox.shrink()),
                              Visibility(
                                visible: showValues,
                                replacement: SizedBox(
                                  height: SeniorSpacing.small,
                                  width: SeniorSpacing.xxhuge,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(
                                      SeniorSpacing.normal,
                                    ),
                                    color:
                                        isDarkTheme ? SeniorColors.secondaryColor700 : SeniorColors.secondaryColor100,
                                    child: SeniorText.body(''),
                                  ),
                                ),
                                child: SeniorText.small(
                                  SalaryDataFormatter.salaryFormatter(
                                    currencyTypeEnum: widget.payrollEntity.currency,
                                    salary: proceed.actualValue ?? 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      if (widget.payrollEntity.wageTypes != null)
                        for (var proceed
                            in widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.advantage))
                          Row(
                            children: [
                              SeniorText.small(proceed.wageType!.name!),
                              const Expanded(child: SizedBox.shrink()),
                              Visibility(
                                visible: showValues,
                                replacement: SizedBox(
                                  height: SeniorSpacing.small,
                                  width: SeniorSpacing.xxhuge,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(
                                      SeniorSpacing.normal,
                                    ),
                                    color:
                                        isDarkTheme ? SeniorColors.secondaryColor700 : SeniorColors.secondaryColor100,
                                    child: SeniorText.body(''),
                                  ),
                                ),
                                child: SeniorText.small(
                                  SalaryDataFormatter.salaryFormatter(
                                    currencyTypeEnum: widget.payrollEntity.currency,
                                    salary: proceed.actualValue ?? 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SeniorSpacing.xxsmall,
                  ),
                  child: Divider(
                    color: SeniorColors.neutralColor400,
                    thickness: 1,
                  ),
                ),
                Row(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(
                        SeniorSpacing.normal,
                      ),
                      color: SeniorColors.manchesterColorRed100,
                      child: AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        curve: Curves.easeInOutCubicEmphasized,
                        height: SeniorSpacing.xmedium,
                        width: SeniorSpacing.xmedium,
                        child: const SeniorIcon(
                          icon: MoneyIcons.moneyMinus,
                          style: SeniorIconStyle(
                            color: SeniorColors.manchesterColorRed400,
                          ),
                          size: SeniorSpacing.normal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.xsmall,
                    ),
                    SeniorText.label(context.translate.deductions),
                    const Expanded(
                      child: SizedBox.shrink(),
                    ),
                    Visibility(
                      visible: showValues,
                      replacement: SizedBox(
                        width: 100,
                        child: Material(
                          borderRadius: BorderRadius.circular(
                            SeniorSpacing.normal,
                          ),
                          color: isDarkTheme ? SeniorColors.secondaryColor700 : SeniorColors.secondaryColor100,
                          child: SeniorText.body(''),
                        ),
                      ),
                      child: SeniorText.labelBold(
                        SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: widget.payrollEntity.currency,
                          salary: totalDeductions,
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.payrollEntity.wageTypes != null &&
                    widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.deduction).isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: SeniorSpacing.big,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.payrollEntity.wageTypes != null)
                          for (var proceed in widget.payrollEntity.wageTypes!
                              .where((e) => e.wageType!.type == WageTypeEnum.deduction))
                            Row(
                              children: [
                                SeniorText.small(proceed.wageType!.name!),
                                const Expanded(
                                  child: SizedBox.shrink(),
                                ),
                                Visibility(
                                  visible: showValues,
                                  replacement: SizedBox(
                                    height: SeniorSpacing.small,
                                    width: SeniorSpacing.xxhuge,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(
                                        SeniorSpacing.normal,
                                      ),
                                      color:
                                          isDarkTheme ? SeniorColors.secondaryColor700 : SeniorColors.secondaryColor100,
                                      child: SeniorText.body(''),
                                    ),
                                  ),
                                  child: SeniorText.small(
                                    SalaryDataFormatter.salaryFormatter(
                                      currencyTypeEnum: widget.payrollEntity.currency,
                                      salary: proceed.actualValue ?? 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SeniorSpacing.xxsmall,
                  ),
                  child: Divider(
                    color: SeniorColors.neutralColor400,
                    thickness: 1,
                  ),
                ),
                if (widget.payrollEntity.wageTypes != null &&
                    widget.payrollEntity.wageTypes!.where((e) => e.wageType!.type == WageTypeEnum.grants).isNotEmpty)
                  Column(
                    children: [
                      Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(
                              SeniorSpacing.normal,
                            ),
                            color: SeniorColors.secondaryColor200,
                            child: AnimatedContainer(
                              duration: kThemeAnimationDuration,
                              curve: Curves.easeInOutCubicEmphasized,
                              height: SeniorSpacing.xmedium,
                              width: SeniorSpacing.xmedium,
                              child: const SeniorIcon(
                                icon: FontAwesomeIcons.solidInfo,
                                style: SeniorIconStyle(
                                  color: SeniorColors.secondaryColor600,
                                ),
                                size: SeniorSpacing.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: SeniorSpacing.xsmall,
                          ),
                          SeniorText.label(context.translate.informative),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: SeniorSpacing.big,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.payrollEntity.wageTypes != null)
                              for (var proceed in widget.payrollEntity.wageTypes!
                                  .where((e) => e.wageType!.type == WageTypeEnum.grants))
                                Row(
                                  children: [
                                    SeniorText.small(proceed.wageType?.name ?? ''),
                                    const Expanded(
                                      child: SizedBox.shrink(),
                                    ),
                                    Visibility(
                                      visible: showValues,
                                      replacement: SizedBox(
                                        height: SeniorSpacing.small,
                                        width: SeniorSpacing.xxhuge,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                            SeniorSpacing.normal,
                                          ),
                                          color: isDarkTheme
                                              ? SeniorColors.secondaryColor700
                                              : SeniorColors.secondaryColor100,
                                          child: SeniorText.body(''),
                                        ),
                                      ),
                                      child: SeniorText.small(
                                        SalaryDataFormatter.salaryFormatter(
                                          currencyTypeEnum: widget.payrollEntity.currency,
                                          salary: proceed.actualValue ?? 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: SeniorSpacing.xxsmall,
                        ),
                        child: Divider(
                          color: SeniorColors.neutralColor400,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }

        if (state is LoadingPayrollState) {
          return const WaapiLoadingWidget();
        }

        if (state is EmptyListPayrollState) {
          return EmptyStateWidget(
            title: context.translate.noStatementsAvailableTitle,
            subTitle: context.translate.noStatementsAvailableSubtitle,
            imagePath: AssetsPath.generalEmptyState,
          );
        }

        return ErrorStateWidget(
          title: context.translate.statementsErrorTitle,
          subTitle: context.translate.financialDataErrorDescription,
          onTapTryAgain: () {
            widget.payrollBloc.add(
              GetPayrollListEvent(
                employeerId: widget.employeeId,
                paginationRequirements: const PaginationRequirements(
                  page: 1,
                  limit: 1,
                ),
              ),
            );
          },
          imagePath: AssetsPath.generalErrorState,
        );
      },
    );
  }

  void documentCheckboxes(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: PayrollFilterScreen(
            employeeId: widget.employeeId,
            payrollBloc: widget.payrollBloc,
          ),
        ),
      ],
      hasCloseButton: false,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }

  String paymentReference({
    required String date,
    required String calculationType,
  }) {
    final dateReference = '$date-01';
    final dateConvert = DateTimeHelper.convertStringAaaaMmDdToDateTime(
      stringToConvert: dateReference,
    );
    return '$calculationType - ${DateTimeHelper.getNameMonth(
      month: dateConvert!.month,
      appLocalizations: context.translate,
    )} ${dateConvert.year}';
  }

  String _toReceivedPaidPayment({required DateTime monthPayment}) {
    if (monthPayment.isAfter(DateTime.now())) {
      return context.translate.receivableIn(
        DateTimeHelper.formatWithDefaultDatePattern(
          dateTime: monthPayment,
          locale: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        ),
      );
    }
    return context.translate.payedOn(
      DateTimeHelper.formatWithDefaultDatePattern(
        dateTime: monthPayment,
        locale: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
      ),
    );
  }
}
