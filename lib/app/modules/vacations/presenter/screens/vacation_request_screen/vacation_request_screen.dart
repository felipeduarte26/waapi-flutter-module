import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/helper/string_helper.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/input_attachments_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../attachment/domain/entities/attachment_entity.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../domain/entities/vacation_detail_entity.dart';
import '../../../domain/input_models/send_vacation_request_attachments_input_model.dart';
import '../../../domain/input_models/send_vacation_request_attachments_update_input_model.dart';
import '../../../domain/input_models/send_vacation_request_input_model.dart';
import '../../../domain/input_models/send_vacation_request_update_input_model.dart';
import '../../blocs/vacation_request/vacation_request_bloc.dart';
import '../../blocs/vacations_bloc/vacations_event.dart';
import '../../blocs/vacations_bloc/vacations_state.dart';
import '../../widgets/vacation_request_restrictions_actions_senior_colorful_header_structure_widget.dart';
import 'bloc/vacation_request_screen_bloc.dart';
import 'bloc/vacation_request_screen_state.dart';
import 'components/fix_request_vacation_update_screen.dart';
import 'components/restrictions_bottom_sheet_widget.dart';
import 'components/select_date_screen.dart';
import 'components/select_period_screen.dart';

class VacationRequestScreen extends StatefulWidget {
  final VacationDetailEntity? vacationDetailEntity;
  final String employeeId;
  final bool isRequestVacationUpdate;
  final String? vacationPeriodId;
  final String? id;

  const VacationRequestScreen({
    Key? key,
    required this.employeeId,
    this.vacationDetailEntity,
    required this.isRequestVacationUpdate,
    this.vacationPeriodId,
    this.id,
  }) : super(key: key);

  @override
  State<VacationRequestScreen> createState() {
    return _VacationRequestScreenState();
  }
}

class _VacationRequestScreenState extends State<VacationRequestScreen> {
  var currentStep = 1;
  late final PageController _pageController;
  late final VacationRequestScreenBloc _vacationRequestScreenBloc;
  late final WaapiManagementPanelUploaderBloc _waapiManagementPanelUploaderBloc;

  String? _vacationPeriodSelected;
  double _vacationBalance = 0;
  final TextEditingController _qntDaysController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _qntDaysVacationBonusController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final List<AttachmentEntity> _attachments = [];
  late String vacationPeriodId = '';
  late String approverCommentary = '';
  late String integrationErrorMessage = '';

  DateTime? selectedDate;

  bool christmasBonus = false;
  bool vacationBonus = false;
  bool openModal = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _isRequestVacationUpdate() ? 0 : 1);
    _vacationRequestScreenBloc = Modular.get<VacationRequestScreenBloc>();
    _waapiManagementPanelUploaderBloc = Modular.get<WaapiManagementPanelUploaderBloc>();
    if (_vacationRequestScreenBloc.vacationsBloc.state is! LoadedVacationsState) {
      _vacationRequestScreenBloc.vacationsBloc.add(
        GetVacationsEvent(
          employeeId: widget.employeeId,
        ),
      );
    }

    _dateController.addListener(() {
      setState(() {});
    });

    _qntDaysController.addListener(() {
      setState(() {});
    });

    _qntDaysVacationBonusController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _validateAndInitializeParams();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<WaapiManagementPanelUploaderBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isNextEnabled() {
      if (currentStep == 1) {
        return (_vacationPeriodSelected != null || widget.vacationPeriodId != '' && widget.isRequestVacationUpdate);
      }
      if (currentStep == 2) {
        final qntDays = int.tryParse(_qntDaysController.text) ?? 0;
        final qntBonusDays = int.tryParse(_qntDaysVacationBonusController.text) ?? 0;

        final exceedsVacationBalance = qntDays > _vacationBalance.floor();
        final exceedsBonusLimit = qntBonusDays > (_vacationBalance / 3).floor();

        if (exceedsVacationBalance || exceedsBonusLimit || (vacationBonus && qntBonusDays <= 0)) {
          return false;
        }

        return (qntDays > 0 || (vacationBonus && qntBonusDays > 0)) && _dateController.text.isNotEmpty;
      }
      return currentStep == 3 || currentStep == 0;
    }

    void onWillPop() {
      if (openModal) return;
      final vacationNotEmpty = !(currentStep == 1 && _vacationPeriodSelected == null);
      if (vacationNotEmpty) {
        openModal = true;
        showDialog(
          barrierDismissible: false,
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return SeniorModal(
              title: context.translate.cancelRequest,
              content: context.translate.cancelRequestAlert,
              defaultAction: SeniorModalAction(
                label: context.translate.no,
                action: () {
                  openModal = false;
                  Modular.to.pop();
                },
              ),
              otherAction: SeniorModalAction(
                label: context.translate.yes,
                action: () {
                  Modular.to.pop(true);
                  Modular.to.pop(true);
                },
                danger: true,
              ),
            );
          },
        );
      } else {
        Modular.to.pop();
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: onWillPop,
          actions: [
            BlocBuilder<VacationRequestBloc, VacationRequestState>(
              bloc: _vacationRequestScreenBloc.vacationRequestBloc,
              builder: (context, state) {
                if (state is ErrorVacationRequestState && state.vacationRequestResult != null) {
                  return VacationRequestRestrictionsActionsSeniorColorfulHeaderStructureWidget(
                    numberRestrictionRequest: state.vacationRequestResult!.length,
                    onTapRestrictions: () {
                      RestrictionsBottomSheetWidget.showBottomSheet(
                        context: context,
                        messages: state.vacationRequestResult!,
                        isReview: true,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          titleLabel: _isRequestVacationUpdate() ? context.translate.adjustRequest : context.translate.requestVacation,
          body: Column(
            children: [
              BlocBuilder<VacationRequestScreenBloc, VacationRequestScreenState>(
                bloc: _vacationRequestScreenBloc,
                builder: (context, state) {
                  final vacationsState = state.vacationsState;

                  if (vacationsState is LoadedVacationsState && vacationsState.vacations!.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                      child: SeniorStepper(
                        steps: 3,
                        current: currentStep,
                        style: themeRepository.isCustomTheme()
                            ? null
                            : SeniorStepperStyle(
                                uncompletedStepColor: themeRepository.isDarkTheme()
                                    ? SeniorColors.grayscale40
                                    : SeniorColors.neutralColor400,
                                currentStepColor: themeRepository.isDarkTheme()
                                    ? SeniorColors.primaryColor500
                                    : SeniorColors.primaryColor400,
                                completedStepColor: themeRepository.isDarkTheme()
                                    ? SeniorColors.primaryColor300
                                    : SeniorColors.primaryColor200,
                              ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    FixRequestVacationUpdateScreen(
                      employeeId: widget.employeeId,
                      approverCommentary: approverCommentary,
                      integrationErrorMessage: integrationErrorMessage,
                    ),
                    SelectPeriodScreen(
                      isRequestVacationUpdate: _isRequestVacationUpdate(),
                      vacationPeriodId: _vacationPeriodSelected,
                      onSelected: (vacationEntity) {
                        setState(() {
                          _vacationPeriodSelected = vacationEntity.vacationPeriodId;
                          _vacationBalance = vacationEntity.vacationBalance ?? 0;
                        });
                      },
                    ),
                    SelectDateScreen(
                      qntDaysController: _qntDaysController,
                      dateController: _dateController,
                      selectedDate: selectedDate,
                      onDateChanged: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      christmasBonus: christmasBonus,
                      vacationBonus: vacationBonus,
                      onChangedChristmasBonus: (hasChristmasBonus) {
                        setState(() {
                          christmasBonus = hasChristmasBonus ?? false;
                        });
                      },
                      onChangedVacationBonus: (hasVacationBonus) {
                        setState(() {
                          vacationBonus = hasVacationBonus ?? false;
                        });
                        if (!vacationBonus) {
                          _qntDaysVacationBonusController.clear();
                        }
                      },
                      qntDaysVacationBonusController: _qntDaysVacationBonusController,
                      notesController: _notesController,
                      vacationBalance: _vacationBalance,
                    ),
                    InputAttachmentsWidget(
                      panelUploaderBloc: _waapiManagementPanelUploaderBloc,
                      attachments: _attachments,
                      isRequestVacationUpdate: widget.isRequestVacationUpdate,
                      header: context.translate.receipts,
                    ),
                  ],
                ),
              ),
              MultiBlocListener(
                listeners: [
                  BlocListener<VacationRequestBloc, VacationRequestState>(
                    bloc: _vacationRequestScreenBloc.vacationRequestBloc,
                    listener: (context, vacationRequestState) {
                      if (vacationRequestState is LoadedVacationRequestState) {
                        if (widget.isRequestVacationUpdate) {
                          Modular.to.pop(true);
                          Modular.to.pop(true);
                          Modular.to.pop(true);
                        } else {
                          Modular.to.pop(true);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.success(
                            message: context.translate.requestVacationSubmitted,
                          ),
                        );
                      }

                      if (vacationRequestState is ErrorVacationRequestState) {
                        if (vacationRequestState.vacationRequestResult == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SeniorSnackBar.error(
                              message: context.translate.genericErrorAndTryAgain,
                              action: SeniorSnackBarAction(
                                label: context.translate.repeat,
                                onPressed: () {
                                  if (_isRequestVacationUpdate()) {
                                    _sendRequestUpdate();
                                  } else {
                                    _sendRequest();
                                  }
                                },
                              ),
                            ),
                          );
                          return;
                        }

                        RestrictionsBottomSheetWidget.showBottomSheet(
                          context: context,
                          messages: vacationRequestState.vacationRequestResult!,
                          isReview: false,
                          primaryButtonPressed: () {
                            Modular.to.pop();

                            setState(() {
                              currentStep = 1;
                            });

                            _pageController.animateToPage(
                              0,
                              duration: kTabScrollDuration,
                              curve: Curves.easeIn,
                            );
                          },
                          secondaryButtonPressed: Modular.to.pop,
                        );
                      }
                    },
                  ),
                ],
                child: const SizedBox.shrink(),
              ),
              BlocBuilder<VacationRequestScreenBloc, VacationRequestScreenState>(
                bloc: _vacationRequestScreenBloc,
                builder: (context, state) {
                  final vacationsState = state.vacationsState;
                  final vacationRequestState = state.vacationRequestState;

                  if (vacationsState is LoadedVacationsState && vacationsState.vacations!.isNotEmpty) {
                    return EmployeeBottomSheetWidget(
                      horizontalPadding: true,
                      seniorButtons: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                          ),
                          child: SeniorButton(
                            disabled: !isNextEnabled() || vacationRequestState is LoadingVacationRequestState,
                            busy: vacationRequestState is LoadingVacationRequestState,
                            fullWidth: true,
                            label: currentStep == 3
                                ? _isRequestVacationUpdate()
                                    ? context.translate.sendAdjustments
                                    : context.translate.request
                                : context.translate.next,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (currentStep < 3) {
                                _pageController.nextPage(
                                  duration: kTabScrollDuration,
                                  curve: Curves.easeIn,
                                );
                                currentStep++;
                                setState(() {});
                                return;
                              }
                              if (_isRequestVacationUpdate()) {
                                _sendRequestUpdate();
                              } else {
                                _sendRequest();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                          ),
                          child: SeniorButton.ghost(
                            disabled: vacationRequestState is LoadingVacationRequestState,
                            fullWidth: true,
                            label: ((currentStep > 1 || _isRequestVacationUpdate()) && currentStep != 0)
                                ? context.translate.back
                                : currentStep == 0
                                    ? context.translate.cancelAdjustment
                                    : context.translate.optionCancel,
                            onPressed: () {
                              if ((currentStep > 1 || _isRequestVacationUpdate()) && currentStep != 0) {
                                setState(() {
                                  _pageController.previousPage(
                                    duration: kTabScrollDuration,
                                    curve: Curves.easeIn,
                                  );
                                  currentStep--;
                                });
                                return;
                              }
                              onWillPop();
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendRequest() {
    final attachments = _waapiManagementPanelUploaderBloc.state.attachments
        .map(
          (attachment) => SendVacationRequestAttachmentsInputModel(
            id: attachment.id,
            name: attachment.name,
            link: attachment.link,
            personId: attachment.personId,
            operation: 'INSERT',
          ),
        )
        .toList();

    _vacationRequestScreenBloc.vacationRequestBloc.add(
      SendVacationRequestEvent(
        sendVacationRequestInputModel: SendVacationRequestInputModel(
          employeeId: widget.employeeId,
          has13thSalaryAdvance: christmasBonus,
          vacationBonusDays: vacationBonus ? int.parse(_qntDaysVacationBonusController.text).toString() : null,
          startDate: DateTimeHelper.formatToIso8601Date(
            dateTime: selectedDate!,
          ),
          vacationPeriodId: _vacationPeriodSelected!,
          vacationsDays: int.tryParse(_qntDaysController.text)?.toString() ?? '',
          commentary: _notesController.text,
          attachments: attachments,
        ),
      ),
    );
  }

  void _sendRequestUpdate() {
    final attachments = _waapiManagementPanelUploaderBloc.state.attachments
        .map(
          (attachment) => SendVacationRequestAttachmentsUpdateInputModel(
            id: attachment.id,
            name: attachment.name,
            link: attachment.link,
            personId: attachment.personId,
            operation: 'INSERT',
          ),
        )
        .toList();

    _vacationRequestScreenBloc.vacationRequestBloc.add(
      SendVacationRequestUpdateEvent(
        sendVacationRequestUpdateInputModel: SendVacationRequestUpdateInputModel(
          id: widget.id!,
          employeeId: widget.employeeId,
          has13thSalaryAdvance: christmasBonus,
          vacationBonusDays: vacationBonus ? int.parse(_qntDaysVacationBonusController.text).toString() : null,
          startDate: DateTimeHelper.formatToIso8601Date(
            dateTime: selectedDate!,
          ),
          vacationPeriodId: _vacationPeriodSelected!,
          vacationsDays: int.parse(_qntDaysController.text).toString(),
          commentary: _notesController.text,
          attachments: attachments,
        ),
      ),
    );
  }

  bool _isRequestVacationUpdate() {
    return widget.isRequestVacationUpdate;
  }

  void _validateAndInitializeParams() {
    if (_isRequestVacationUpdate()) {
      if (widget.vacationPeriodId != null) {
        _vacationPeriodSelected = widget.vacationPeriodId;
      }

      if (widget.vacationDetailEntity!.approverCommentary != null) {
        approverCommentary = widget.vacationDetailEntity!.approverCommentary!;
      }
      if (widget.vacationDetailEntity!.startDate != null) {
        selectedDate = widget.vacationDetailEntity!.startDate!;
      }
      if (widget.vacationDetailEntity!.integrationErrorMessage != null) {
        integrationErrorMessage = widget.vacationDetailEntity!.integrationErrorMessage!;
      }
      currentStep = 0;
      _qntDaysController.text = StringHelper.doubleToStringFormatter(
        value: widget.vacationDetailEntity!.vacationDays!,
      );
      _dateController.text = DateTimeHelper.formatWithDefaultDatePattern(
        locale: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
        dateTime: widget.vacationDetailEntity!.startDate!,
      );
      final qntDaysBonus = StringHelper.doubleToStringFormatter(
        value: widget.vacationDetailEntity!.vacationBonusDays!,
      );
      _qntDaysVacationBonusController.text = widget.vacationDetailEntity!.vacationBonusDays! > 0 ? qntDaysBonus : '';
      _notesController.text =
          widget.vacationDetailEntity!.commentary != null ? widget.vacationDetailEntity!.commentary! : '';
      christmasBonus = widget.vacationDetailEntity!.has13thSalaryAdvance!;
      vacationBonus = widget.vacationDetailEntity!.vacationBonusDays! > 0;
      widget.vacationDetailEntity!.attachments
          ?.map(
            (attachment) => {
              _attachments.add(
                AttachmentEntity(
                  id: attachment.id,
                  name: attachment.name,
                  link: attachment.link,
                  personId: attachment.personId,
                ),
              ),
            },
          )
          .toList();
    }
  }
}
