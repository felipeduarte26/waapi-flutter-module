import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../../../../profile/presenter/blocs/company_name_bloc/company_name_bloc.dart';
import '../../../../profile/presenter/blocs/company_name_bloc/company_name_event.dart';
import '../../../../profile/presenter/blocs/company_name_bloc/company_name_state.dart';
import '../../../domain/entities/payroll_entity.dart';
import '../../bloc/payroll_bloc/payroll_bloc.dart';
import '../../bloc/payroll_bloc/payroll_event.dart';
import '../../bloc/payroll_bloc/payroll_state.dart';
import '../payroll_view_pdf_screen/payroll_pdf_create_screen.dart';
import 'bloc/payroll_screen_bloc.dart';
import 'widgets/payroll_tab_content.dart';
import 'widgets/report_income_tab_screen.dart';

class PayrollScreen extends StatefulWidget {
  final String employeeId;

  const PayrollScreen({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  late PayrollEntity _payrollEntity;
  late PayrollScreenBloc _payrollScreenBloc;
  late CompanyNameBloc _companyNameBloc;

  int tabIndex = 0;
  final PageController _pageController = PageController();
  final _scrollController = ScrollController(
    keepScrollOffset: true,
  );
  var payrollEntityPdf = const PayrollEntity();
  NotificationMessage? notification;
  bool loadingpdfScreen = false;

  @override
  void initState() {
    super.initState();
    _payrollScreenBloc = Modular.get<PayrollScreenBloc>();
    _companyNameBloc = Modular.get<CompanyNameBloc>();
    _payrollEntity = const PayrollEntity();

    _companyNameBloc.add(
      GetCompanyNameEvent(
        employeeId: widget.employeeId,
      ),
    );

    _payrollScreenBloc.payrollBloc.add(
      GetPayrollListEvent(
        employeerId: widget.employeeId,
        paginationRequirements: const PaginationRequirements(
          page: 1,
          limit: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollBloc, PayrollState>(
      bloc: _payrollScreenBloc.payrollBloc,
      listener: (context, state) {
        if (state is LoadedPayrollState && _payrollEntity.netValue == null) {
          _payrollEntity = state.payroll.first;
        }

        if (state is LoadedPayrollSelectedState) {
          _payrollEntity = state.payrollEntitySelected;
        }
      },
      builder: (context, state) {
        return PopScope(
          onPopInvokedWithResult: (_, __) async => onWillPop(),
          child: Scaffold(
            body: WaapiColorfulHeader(
              onTapBack: onWillPop,
              titleLabel: context.translate.financialData,
              scrollController: _scrollController,
              tabBarConfig: _tabBarConfig(
                tabs: [
                  context.translate.statement,
                  context.translate.earningsReport,
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          _onSelect(value);
                        });
                      },
                      controller: _pageController,
                      children: [
                        _payrollEntity.employee != null
                            ? PayrollTabContent(
                                employeeId: widget.employeeId,
                                payrollBloc: _payrollScreenBloc.payrollBloc,
                                payrollEntity: _payrollEntity,
                              )
                            : const WaapiLoadingWidget(
                                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                              ),
                        ReportIncomeTabScreen(
                          employerName:
                              _payrollScreenBloc.contractEmployeeBloc.state.contractEmployeeEntity?.employer?.name ??
                                  context.translate.earningsReport,
                          companyNumber:
                              _payrollScreenBloc.contractEmployeeBloc.state.contractEmployeeEntity?.companyNumber ?? 0,
                          registerNumber: _payrollScreenBloc
                                  .contractEmployeeBloc.state.contractEmployeeEntity?.registerNumber
                                  .toString() ??
                              '',
                        ),
                      ],
                    ),
                  ),
                  if (tabIndex == 0 &&
                      (_payrollScreenBloc.payrollBloc.state is LoadedPayrollSelectedState ||
                          _payrollScreenBloc.payrollBloc.state is LoadedPayrollState))
                    EmployeeBottomSheetWidget(
                      horizontalPadding: false,
                      seniorButtons: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                            left: SeniorSpacing.normal,
                            right: SeniorSpacing.normal,
                          ),
                          child: SeniorButton(
                            disabled: loadingpdfScreen,
                            label: context.translate.viewPDF,
                            onPressed: () async {
                              setState(() {
                                _loadingPdfScreen();
                              });
                              if (_payrollScreenBloc.payrollBloc.state is LoadedPayrollSelectedState) {
                                payrollEntityPdf = _payrollScreenBloc.payrollBloc.state.payrollEntitySelected;
                              }
                              if (_payrollScreenBloc.payrollBloc.state is LoadedPayrollState) {
                                payrollEntityPdf = _payrollScreenBloc.payrollBloc.state.payroll.first;
                              }

                              final contract = _payrollScreenBloc.contractEmployeeBloc.state.contractEmployeeEntity!;

                              var companyName = contract.employer?.name ?? contract.employer?.tradingName ?? '';

                              if (_companyNameBloc.state is LoadedCompanyNameState) {
                                companyName = (_companyNameBloc.state as LoadedCompanyNameState).companyName;
                              }

                              await PayrollPdfCreateScreen.createPdf(
                                titlePage: context.translate.financialData,
                                payroll: payrollEntityPdf,
                                appLocalizations: context.translate,
                                personalizationEntity:
                                    (_payrollScreenBloc.personalizationBloc.state as LoadedPersonalizationState)
                                        .personalizationEntity,
                                profileEntity: _payrollScreenBloc.profileBloc.state.profileEntity!,
                                contractEmployeeEntity:
                                    _payrollScreenBloc.contractEmployeeBloc.state.contractEmployeeEntity!,
                                onFinishedCreate: () {
                                  setState(() {
                                    _loadingPdfScreen();
                                  });
                                },
                                onFinishedCreateError: pdfLoadingError,
                                companyName: companyName,
                              );
                            },
                            fullWidth: true,
                            busy: loadingpdfScreen,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onWillPop() {
    Modular.to.pop();
  }

  dynamic _onSelect(int newValue) {
    if (newValue == 0) {
      setState(() {
        _pageController.jumpToPage(0);
      });
    }

    if (newValue == 1) {
      setState(() {
        _pageController.jumpToPage(1);
      });
    }
    tabIndex = newValue;
  }

  TabBarConfig _tabBarConfig({
    required List<String> tabs,
  }) {
    return TabBarConfig(
      tabs: tabs,
      onSelect: _onSelect,
      tabIndex: tabIndex,
    );
  }

  bool _loadingPdfScreen() {
    return loadingpdfScreen = !loadingpdfScreen;
  }

  void pdfLoadingError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SeniorSnackBar.error(
        message: context.translate.messageErroCreatePdf,
      ),
    );
  }
}
