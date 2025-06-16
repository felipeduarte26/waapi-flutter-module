import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/helper/scroll_helper.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../domain/entities/payroll_entity.dart';
import '../../bloc/payroll_bloc/payroll_bloc.dart';
import '../../bloc/payroll_bloc/payroll_event.dart';
import '../../bloc/payroll_bloc/payroll_state.dart';

class PayrollFilterScreen extends StatefulWidget {
  final String employeeId;
  final PayrollBloc payrollBloc;

  const PayrollFilterScreen({
    Key? key,
    required this.payrollBloc,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<PayrollFilterScreen> createState() => _PayrollFilterScreenState();
}

class _PayrollFilterScreenState extends State<PayrollFilterScreen> {
  final ScrollController scrollController = ScrollController();
  late PayrollEntity selectedPayroll;
  late bool listEnd;
  var isButtonDisabled = false;
  var nextPage = 1;

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    selectedPayroll = const PayrollEntity();
    listEnd = false;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients && scrollController.position.maxScrollExtent != 0) {
        widget.payrollBloc.add(
          GetPayrollListEvent(
            employeerId: widget.employeeId,
            paginationRequirements: PaginationRequirements(
              page: nextPage,
              limit: 10,
            ),
            overrideNotAllowedStates: true,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollBloc, PayrollState>(
      bloc: widget.payrollBloc,
      listener: (context, state) {
        if (state is LoadedPayrollState) {
          nextPage++;
        }

        if (state is ErrorPayrollState) {
          Modular.to.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.payrollLoadingMoreError,
              action: SeniorSnackBarAction(
                label: context.translate.repeat,
                onPressed: _getMorePayroll,
              ),
            ),
          );
        }
      },
      listenWhen: (oldSate, newState) => oldSate.payroll != newState.payroll,
      builder: (context, state) {
        if ((state is LoadingMorePayrollgState || state is LoadingPayrollState) && !listEnd) {
          return const SizedBox(
            child: Center(
              child: WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
              ),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    height: SeniorSpacing.xsmall,
                  ),
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: SeniorSpacing.xxxsmall,
                  ),
                  itemBuilder: (_, index) {
                    if (index == state.payroll.length - 1 && state.payroll.length > 1) {
                      final show = state is! LoadingPayrollState && state is! LoadingMorePayrollgState;
                      return Column(
                        children: [
                          Offstage(
                            offstage: show,
                            child: const WaapiLoadingWidget(
                              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                            ),
                          ),
                          Offstage(
                            offstage: !show,
                            child: loadedCard(
                              state: state,
                              index: index,
                            ),
                          ),
                        ],
                      );
                    }

                    return loadedCard(
                      state: state,
                      index: index,
                    );
                  },
                  itemCount: state.payroll.length,
                ),
              ),
            ),
            EmployeeBottomSheetWidget(
              horizontalPadding: false,
              seniorButtons: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.normal,
                  ),
                  child: SeniorButton(
                    disabled: !isButtonDisabled,
                    label: context.translate.select,
                    onPressed: () {
                      widget.payrollBloc.add(
                        GetPayrollEntityEvent(
                          payroll: selectedPayroll,
                        ),
                      );
                      state.payroll.clear();
                      Modular.to.pop();
                    },
                    fullWidth: true,
                  ),
                ),
                SeniorButton.ghost(
                  label: context.translate.optionCancel,
                  onPressed: () {
                    Modular.to.pop();
                  },
                  fullWidth: true,
                ),
                const SizedBox(
                  height: SeniorSpacing.normal,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget loadedCard({
    required PayrollState state,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 0 ? SeniorSpacing.xxxsmall : 0,
        bottom: index == state.payroll.length - 1 ? SeniorSpacing.xxxsmall : 0,
      ),
      child: WaapiCardWidget(
        key: const Key('financial_data-payroll_filter_screen-list-card'),
        showActionIcon: false,
        showRadioButton: true,
        leftBorder: selectedPayroll == state.payroll.elementAt(index),
        selectedRadioButton: selectedPayroll == state.payroll.elementAt(index),
        onTap: () {
          setState(() {
            selectedPayroll = state.payroll.elementAt(index);
            isButtonDisabled = true;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.xxsmall,
              ),
              child: SeniorText.labelBold(
                paymentReference(
                  date: state.payroll.elementAt(index).calculation!.paymentReference!,
                  calculationType: state.payroll.elementAt(index).calculation!.type!.name(
                        context.translate,
                      ),
                ),
                color: SeniorColors.neutralColor900,
              ),
            ),
            SeniorText.small(
              _toReceivedPaidPayment(monthPayment: state.payroll.elementAt(index).calculation!.paymentDate!),
            ),
          ],
        ),
      ),
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

  void _onScroll() {
    listEnd = ScrollHelper.reachedListEnd(
      scrollController: scrollController,
    );
    if (listEnd) {
      widget.payrollBloc.add(
        GetPayrollListEvent(
          employeerId: widget.employeeId,
          paginationRequirements: PaginationRequirements(
            page: nextPage,
            limit: 10,
          ),
        ),
      );
    }
  }

  void _getMorePayroll() {
    widget.payrollBloc.add(
      GetPayrollListEvent(
        employeerId: widget.employeeId,
        paginationRequirements: PaginationRequirements(
          page: nextPage,
          limit: 10,
        ),
        overrideNotAllowedStates: true,
      ),
    );
  }
}
