import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/environment/environment_variables.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/file_helper.dart';
import '../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../core/widgets/warning_widget.dart';
import '../../../../../routes/routes.dart';
import '../../../../attachment/domain/entities/attachment_entity.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../../attachment/presenter/widgets/waapi_management_panel_uploader_widget.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/vacation_detail_entity.dart';
import '../../../enums/vacation_detail_type_enum.dart';
import '../../../enums/vacation_document_status_enum.dart';
import '../../../enums/vacation_situation_type_enum.dart';
import '../../blocs/report_vacation_bloc/report_vacation_bloc.dart';
import '../../blocs/report_vacation_bloc/report_vacation_event.dart';
import '../../blocs/report_vacation_bloc/report_vacation_state.dart';
import '../../blocs/vacation_request/vacation_request_bloc.dart';
import '../../blocs/vacation_schedule_individual_bloc/vacation_schedule_individual_bloc.dart';
import '../../blocs/vacations_bloc/vacations_bloc.dart';
import '../../blocs/vacations_bloc/vacations_event.dart';
import '../../blocs/vacations_bloc/vacations_state.dart';
import '../../widgets/vacation_schedule_card_widget.dart';
import '../vacation_request_screen/bloc/vacation_request_screen_bloc.dart';
import '../vacation_request_screen/components/restrictions_bottom_sheet_widget.dart';

class VacationRequestDetailsScreen extends StatefulWidget {
  final VacationDetailEntity vacationDetail;
  final String? commentApproval;
  final String? employeeId;
  final String? vacationPeriodId;

  const VacationRequestDetailsScreen({
    Key? key,
    required this.vacationDetail,
    this.commentApproval,
    required this.employeeId,
    this.vacationPeriodId,
  }) : super(key: key);
  @override
  State<VacationRequestDetailsScreen> createState() => _VacationRequestDetailsScreenState();
}

class _VacationRequestDetailsScreenState extends State<VacationRequestDetailsScreen> {
  late final VacationRequestScreenBloc _vacationRequestScreenBloc;
  late final WaapiManagementPanelUploaderBloc _waapiManagementPanelUploaderBloc;
  late final VacationScheduleIndividualBloc _vacationScheduleIndividualBloc;
  late final ReportVacationBloc _reportVacationBloc;
  late final VacationsBloc _vacationsBloc;

  bool isRequestVacationUpdate = false;

  @override
  void initState() {
    super.initState();
    _reportVacationBloc = Modular.get<ReportVacationBloc>();
    _vacationsBloc = Modular.get<VacationsBloc>();
    _vacationRequestScreenBloc = Modular.get<VacationRequestScreenBloc>();
    _waapiManagementPanelUploaderBloc = Modular.get<WaapiManagementPanelUploaderBloc>();
    _vacationScheduleIndividualBloc = Modular.get<VacationScheduleIndividualBloc>();
    if (_vacationScheduleIndividualBloc.state is LoadedVacationScheduleIndividualState) {
      isRequestVacationUpdate =
          (_vacationScheduleIndividualBloc.state as LoadedVacationScheduleIndividualState).isVacationScheduleUpdating;
    }

    if (widget.vacationDetail.situationType == VacationSituationTypeEnum.approved &&
        _vacationScheduleIndividualBloc.state is! LoadedVacationScheduleIndividualState) {
      _vacationScheduleIndividualBloc.add(
        GetVacationScheduleIndividualEvent(
          idVacation: widget.vacationDetail.id!,
          employeeId: widget.employeeId!,
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  void _openPdfView({
    required List<int> bytesFile,
    required String reportName,
    required String screenTitle,
  }) async {
    final fileToShare = await FileHelper.bytesToFile(
      bytes: bytesFile,
      fileName: '$reportName.pdf',
    );

    Modular.to.pushNamed(
      VacationsRoutes.reportPdfViewScreenRouteInitialRoute,
      arguments: {
        'filePath': fileToShare.path,
        'title': screenTitle,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCustomTheme = Provider.of<ThemeRepository>(context).isCustomTheme();
    final hasSignature = (widget.vacationDetail.vacationNoticeSignatureData != null &&
            widget.vacationDetail.vacationNoticeSignatureData!.status == VacationDocumentStatusEnum.inSignature) ||
        (widget.vacationDetail.vacationReceiptSignatureData != null &&
            widget.vacationDetail.vacationReceiptSignatureData!.status == VacationDocumentStatusEnum.inSignature);
    final isExpired = widget.vacationDetail.situationType == VacationSituationTypeEnum.expired;

    NotificationMessage? getNotification() {
      if (isRequestVacationUpdate) {
        return NotificationMessage(
          message: context.translate.alreadyRequestChangeVacation,
          messageType: MessageTypes.messageWarning,
          icon: FontAwesomeIcons.solidTriangleExclamation,
          showCloseButton: false,
        );
      }
      if (hasSignature) {
        return NotificationMessage(
          message:
              '${context.translate.pedingDocumentsSignature}. ${context.translate.pedingDocumentsSignatureDescription}',
          messageType: MessageTypes.messageWarning,
          icon: FontAwesomeIcons.solidTriangleExclamation,
          showCloseButton: false,
        );
      }
      return null;
    }

    return Scaffold(
      body: WaapiColorfulHeader(
        notification: getNotification(),
        hasTopPadding: false,
        titleLabel: context.translate.vacationDetails,
        body: MultiBlocListener(
          listeners: [
            BlocListener<ReportVacationBloc, ReportVacationState>(
              bloc: _reportVacationBloc,
              listener: (context, state) {
                if (state is LoadedReportVacationState) {
                  _openPdfView(
                    bytesFile: state.reportVacation,
                    reportName: state.reportName,
                    screenTitle: state.screenTitle,
                  );
                }

                if (state is ErrorReportVacationState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.error(
                      message: context.translate.errorDownloadAttachment,
                    ),
                  );
                }
              },
            ),
            BlocListener<VacationScheduleIndividualBloc, VacationScheduleIndividualState>(
              bloc: _vacationScheduleIndividualBloc,
              listener: (context, state) {
                if (state is LoadedVacationScheduleIndividualState) {
                  setState(() {
                    isRequestVacationUpdate = state.isVacationScheduleUpdating;
                  });
                }
              },
            ),
            BlocListener<VacationRequestBloc, VacationRequestState>(
              bloc: _vacationRequestScreenBloc.vacationRequestBloc,
              listener: (context, state) {
                if (state is ErrorVacationRequestState) {
                  if (state.vacationRequestResult != null) {
                    RestrictionsBottomSheetWidget.showBottomSheet(
                      context: context,
                      messages: state.vacationRequestResult!,
                      isReview: true,
                    );
                  }
                }

                if (state is CanceledVacationRequestState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SeniorSnackBar.success(
                      message: context.translate.successCancelRequest,
                    ),
                  );

                  Modular.to.pop(true);
                  Modular.to.pop(true);
                }
              },
            ),
          ],
          child: BlocBuilder<VacationsBloc, VacationsState>(
            bloc: _vacationsBloc,
            builder: (context, state) {
              if (state is LoadingVacationsState) {
                return const WaapiLoadingWidget();
              }
              return (_vacationRequestScreenBloc.authorizationBloc.state is LoadedAuthorizationState &&
                      (_vacationScheduleIndividualBloc.state is LoadedVacationScheduleIndividualState ||
                          widget.vacationDetail.situationType != VacationSituationTypeEnum.approved))
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              if (isExpired)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: SeniorSpacing.normal,
                                    bottom: SeniorSpacing.normal,
                                    left: SeniorSpacing.small,
                                    right: SeniorSpacing.small,
                                  ),
                                  child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
                                    bloc: _vacationRequestScreenBloc.authorizationBloc,
                                    builder: (context, state) {
                                      final String? vacationPolicy = state is LoadedAuthorizationState
                                          ? state.authorizationEntity.vacationHelpDescription
                                          : null;

                                      if (vacationPolicy == null || vacationPolicy.isEmpty) {
                                        return const SizedBox.shrink();
                                      }

                                      return WarningWidget(
                                        message: vacationPolicy,
                                      );
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: SeniorSpacing.normal,
                                  left: SeniorSpacing.small,
                                  right: SeniorSpacing.small,
                                ),
                                child: widget.vacationDetail.approverCommentary != null || isExpired
                                    ? SeniorCard(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: SeniorSpacing.small,
                                          horizontal: SeniorSpacing.medium,
                                        ),
                                        style: isCustomTheme
                                            ? const SeniorCardStyle(
                                                outlinedColor: SeniorColors.grayscale50,
                                                backgroundColor: SeniorColors.pureWhite,
                                              )
                                            : null,
                                        withElevation: isCustomTheme,
                                        child: Row(
                                          children: [
                                            const SeniorIcon(
                                              icon: FontAwesomeIcons.solidTriangleExclamation,
                                              size: SeniorSpacing.big,
                                            ),
                                            const SizedBox(
                                              width: SeniorSpacing.medium,
                                            ),
                                            Expanded(
                                              child: SeniorText.body(
                                                isExpired
                                                    ? context.translate.vacationRequestExpiredInfoMessage
                                                    : '${context.translate.approverMessage}:\n${widget.vacationDetail.approverCommentary!}',
                                                color: SeniorColors.pureBlack,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              VacationScheduleCardWidget(
                                vacationScheduleEntity: widget.vacationDetail,
                                showNote: true,
                                isRequestVacationUpdate: isRequestVacationUpdate,
                                canShowSignatureAlert: false,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: SeniorSpacing.normal,
                                      left: SeniorSpacing.normal,
                                      right: SeniorSpacing.normal,
                                    ),
                                    child: SeniorText.label(
                                      context.translate.receipts,
                                      color: SeniorColors.pureBlack,
                                    ),
                                  ),
                                ],
                              ),
                              WaapiManagementPanelUploaderWidget(
                                panelUploaderBloc: _waapiManagementPanelUploaderBloc,
                                isRequestVacationUpdate: true,
                                attachmentShareable: true,
                                attachments: widget.vacationDetail.attachments != null
                                    ? widget.vacationDetail.attachments
                                        ?.map(
                                          (attachments) => AttachmentEntity(
                                            id: attachments.id,
                                            name: attachments.name,
                                            link: attachments.link,
                                            personId: attachments.personId,
                                          ),
                                        )
                                        .toList()
                                    : [],
                                reading: true,
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<VacationRequestBloc, VacationRequestState>(
                          bloc: _vacationRequestScreenBloc.vacationRequestBloc,
                          builder: (context, state) {
                            return _bottomSheetWidget(state, isExpired);
                          },
                        ),
                      ],
                    )
                  : const WaapiLoadingWidget();
            },
          ),
        ),
      ),
    );
  }

  void _openSignatureWebview({
    required String url,
    required String label,
    required VacationDocumentStatusEnum status,
  }) async {
    if (status == VacationDocumentStatusEnum.signed) {
      User? user = await GetStoredUserUsecase().call(const UserName());

      final urlRedirect = EnvironmentVariables().getPlatformUrlBase(user!.tenantName);

      final uri = Uri.parse(urlRedirect + Uri.encodeComponent(url));

      await launchUrl(uri);
      return;
    }
    await Modular.to.pushNamed(
      AppRoutes.webViewRoute,
      arguments: {
        'label': label,
        'url': url,
      },
    );

    if (status == VacationDocumentStatusEnum.inSignature) {
      _vacationsBloc.add(
        GetVacationsEvent(
          employeeId: widget.employeeId!,
        ),
      );
      Modular.to.pop();
    }
  }

  Widget _bottomSheetWidget(VacationRequestState? vacationRequestState, bool isExpired) {
    if (widget.vacationDetail.detailType == VacationDetailTypeEnum.returnedToAdjustments) {
      return EmployeeBottomSheetWidget(
        horizontalPadding: true,
        seniorButtons: [
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.normal,
              bottom: SeniorSpacing.normal,
            ),
            child: makeAdjustmentsButton(vacationRequestState),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorButton(
              disabled: (vacationRequestState is LoadingVacationRequestState),
              busy: (vacationRequestState is LoadingVacationRequestState),
              label: context.translate.cancelRequest,
              outlined: true,
              onPressed: () {
                _cancelRequestButton(context);
              },
              fullWidth: true,
              style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedDangerStyle(context),
            ),
          ),
        ],
      );
    }

    return BlocBuilder<ReportVacationBloc, ReportVacationState>(
      bloc: _reportVacationBloc,
      builder: (context, reportVacationState) {
        final allowToViewVacationSignature =
            (_vacationRequestScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
                .authorizationEntity
                .allowToViewVacationSignature;

        final showSignatureReceiptButton =
            allowToViewVacationSignature && widget.vacationDetail.vacationReceiptSignatureData != null;

        final showSignatureNoticeButton =
            allowToViewVacationSignature && widget.vacationDetail.vacationNoticeSignatureData != null;

        final signatureButtons = [];

        if (showSignatureReceiptButton &&
            widget.vacationDetail.vacationReceiptSignatureData != null &&
            widget.vacationDetail.vacationNoticeSignatureData != null &&
            widget.vacationDetail.vacationReceiptSignatureData!.gedSignatureLink ==
                widget.vacationDetail.vacationNoticeSignatureData!.gedSignatureLink &&
            widget.vacationDetail.vacationReceiptSignatureData!.status == VacationDocumentStatusEnum.inSignature) {
          signatureButtons.add(
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorButton(
                disabled: vacationRequestState is LoadingVacationRequestState ||
                    reportVacationState is LoadingReportVacationState ||
                    reportVacationState is LoadingReportNoticeVacationState,
                label: context.translate.viewDocuments,
                onPressed: () {
                  _openSignatureWebview(
                    label: context.translate.document,
                    url: widget.vacationDetail.vacationReceiptSignatureData!.status ==
                            VacationDocumentStatusEnum.inSignature
                        ? widget.vacationDetail.vacationReceiptSignatureData!.gedSignatureLink
                        : widget.vacationDetail.vacationReceiptSignatureData!.signedDocumentUrl,
                    status: widget.vacationDetail.vacationReceiptSignatureData!.status,
                  );
                },
                fullWidth: true,
              ),
            ),
          );
        } else {
          if (widget.vacationDetail.vacationReceiptSignatureData != null) {
            signatureButtons.add(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  disabled: vacationRequestState is LoadingVacationRequestState,
                  label: context.translate.viewReceipt,
                  onPressed: () {
                    _openSignatureWebview(
                      label: context.translate.receipts,
                      url: widget.vacationDetail.vacationReceiptSignatureData!.status ==
                              VacationDocumentStatusEnum.inSignature
                          ? widget.vacationDetail.vacationReceiptSignatureData!.gedSignatureLink
                          : widget.vacationDetail.vacationReceiptSignatureData!.signedDocumentUrl,
                      status: widget.vacationDetail.vacationReceiptSignatureData!.status,
                    );
                  },
                  fullWidth: true,
                ),
              ),
            );
            if (widget.vacationDetail.vacationNoticeSignatureData != null) {
              signatureButtons.add(
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorButton.ghost(
                    disabled: vacationRequestState is LoadingVacationRequestState,
                    label: context.translate.viewVacationNotice,
                    onPressed: () {
                      _openSignatureWebview(
                        label: context.translate.vacationNotice,
                        url: widget.vacationDetail.vacationNoticeSignatureData!.status ==
                                VacationDocumentStatusEnum.inSignature
                            ? widget.vacationDetail.vacationNoticeSignatureData!.gedSignatureLink
                            : widget.vacationDetail.vacationNoticeSignatureData!.signedDocumentUrl,
                        status: widget.vacationDetail.vacationNoticeSignatureData!.status,
                      );
                    },
                    fullWidth: true,
                  ),
                ),
              );
            }
          } else if (widget.vacationDetail.vacationNoticeSignatureData != null) {
            signatureButtons.add(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  disabled: vacationRequestState is LoadingVacationRequestState,
                  label: context.translate.viewVacationNotice,
                  onPressed: () {
                    _openSignatureWebview(
                      label: context.translate.vacationNotice,
                      url: widget.vacationDetail.vacationNoticeSignatureData!.status ==
                              VacationDocumentStatusEnum.inSignature
                          ? widget.vacationDetail.vacationNoticeSignatureData!.gedSignatureLink
                          : widget.vacationDetail.vacationNoticeSignatureData!.signedDocumentUrl,
                      status: widget.vacationDetail.vacationNoticeSignatureData!.status,
                    );
                  },
                  fullWidth: true,
                ),
              ),
            );
          }
          if (isExpired) {
            signatureButtons.add(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: makeAdjustmentsButton(vacationRequestState),
              ),
            );
          }
        }

        return EmployeeBottomSheetWidget(
          horizontalPadding: true,
          seniorButtons: [
            if (showSignatureReceiptButton || showSignatureNoticeButton || isExpired) ...signatureButtons,
            if ((widget.vacationDetail.reportLink != null && !showSignatureReceiptButton) ||
                (widget.vacationDetail.reportVacationNoticeLink != null && !showSignatureNoticeButton))
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  disabled: vacationRequestState is LoadingVacationRequestState ||
                      reportVacationState is LoadingReportVacationState ||
                      reportVacationState is LoadingReportNoticeVacationState,
                  busy: vacationRequestState is LoadingVacationRequestState ||
                      (widget.vacationDetail.reportLink != null && reportVacationState is LoadingReportVacationState) ||
                      (widget.vacationDetail.reportLink == null &&
                          reportVacationState is LoadingReportNoticeVacationState),
                  label: widget.vacationDetail.reportLink != null
                      ? context.translate.viewReceipt
                      : context.translate.viewVacationNotice,
                  onPressed: () {
                    if (widget.vacationDetail.reportLink != null) {
                      _reportVacationBloc.add(
                        GetReportVacationEvent(
                          reportLink: widget.vacationDetail.reportLink!,
                          reportName: _reportVacationName(),
                          screenTitle: context.translate.receipt,
                        ),
                      );
                      return;
                    }
                    _reportVacationBloc.add(
                      GetReportNoticeVacationEvent(
                        reportNoticeLink: widget.vacationDetail.reportVacationNoticeLink!,
                        reportName: _reportVacationName(),
                        screenTitle: context.translate.vacationNotice,
                      ),
                    );
                  },
                  fullWidth: true,
                ),
              ),
            if ((widget.vacationDetail.reportLink != null && widget.vacationDetail.reportVacationNoticeLink != null) &&
                !showSignatureNoticeButton)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton.ghost(
                  disabled: vacationRequestState is LoadingVacationRequestState ||
                      reportVacationState is LoadingReportVacationState ||
                      reportVacationState is LoadingReportNoticeVacationState,
                  busy: vacationRequestState is LoadingVacationRequestState ||
                      reportVacationState is LoadingReportNoticeVacationState,
                  label: context.translate.viewVacationNotice,
                  onPressed: () {
                    _reportVacationBloc.add(
                      GetReportNoticeVacationEvent(
                        reportNoticeLink: widget.vacationDetail.reportVacationNoticeLink!,
                        reportName: '${context.translate.viewVacationNotice}_${_reportDate()}',
                        screenTitle: context.translate.vacationNotice,
                      ),
                    );
                  },
                  fullWidth: true,
                ),
              ),
            if (widget.vacationDetail.detailType != VacationDetailTypeEnum.receipt)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  disabled: !canCancelVacationRequest() || isRequestVacationUpdate,
                  busy: (vacationRequestState is LoadingVacationRequestState),
                  label: context.translate.cancelRequest,
                  outlined: true,
                  onPressed: () {
                    _cancelRequestButton(context);
                  },
                  fullWidth: true,
                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedDangerStyle(context),
                ),
              ),
          ],
        );
      },
    );
  }

  String _reportVacationName() {
    final reportType =
        widget.vacationDetail.reportLink != null ? context.translate.viewReceipt : context.translate.viewVacationNotice;

    return '${reportType}_${_reportDate()}';
  }

  String _reportDate() {
    return widget.vacationDetail.startDate != null
        ? DateTimeHelper.formatToIso8601Date(
            dateTime: widget.vacationDetail.startDate!,
          )
        : '';
  }

  bool canCancelVacationRequest() {
    return widget.vacationDetail.situationType == VacationSituationTypeEnum.approved
        ? (_vacationRequestScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
            .authorizationEntity
            .allowCancellationScheduledVacation
        : (widget.vacationDetail.detailType != VacationDetailTypeEnum.underAnalysis);
  }

  Future _cancelRequestButton(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.wishToCancelThisRequest,
          content: context.translate.cancelingTheRequestThisActionCannotBeUndone,
          defaultAction: SeniorModalAction(
            label: context.translate.no,
            action: Modular.to.pop,
          ),
          otherAction: SeniorModalAction(
            label: context.translate.yes,
            action: () {
              Modular.to.pop();
              _vacationRequestScreenBloc.vacationRequestBloc.add(
                CancelVacationRequestEvent(
                  idVacation: widget.vacationDetail.id!,
                  isApproved: widget.vacationDetail.situationType == VacationSituationTypeEnum.approved,
                  employeeId: widget.employeeId!,
                ),
              );
            },
            danger: true,
          ),
        );
      },
    );
  }

  Widget makeAdjustmentsButton(VacationRequestState? vacationRequestState) {
    return SeniorButton(
      disabled: (vacationRequestState is LoadingVacationRequestState),
      label: context.translate.makeAdjustments,
      onPressed: () async {
        await Modular.to.pushNamed(
          VacationsRoutes.requestVacationScreenInitialRoute,
          arguments: {
            'employeeId': widget.employeeId,
            'vacationDetailEntity': widget.vacationDetail,
            'isRequestVacationUpdate': true,
            'vacationPeriodId': widget.vacationPeriodId,
            'id': widget.vacationDetail.id,
          },
        );
      },
      fullWidth: true,
    );
  }
}
