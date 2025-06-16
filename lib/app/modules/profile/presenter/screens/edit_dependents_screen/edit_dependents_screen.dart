import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/input_attachments_widget.dart';
import '../../../../../core/widgets/input_notes_widget.dart';
import '../../../../../core/widgets/waapi_page_view_widget.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_event.dart';
import '../../../domain/entities/dependent_entity.dart';
import '../../../domain/input_models/attachments_input_model.dart';
import '../../blocs/dependent_bloc/dependent_event.dart';
import '../../blocs/edit_dependents_bloc/edit_dependents_bloc.dart';
import '../../blocs/education_degree_bloc/education_degree_event.dart';
import '../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_event.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import 'bloc/edit_dependents_screen_bloc.dart';
import 'bloc/edit_dependents_screen_state.dart';
import 'components/input_documents_screen.dart';
import 'components/input_mandatory_data_screen.dart';
import 'edit_dependents_controller.dart';

class EditDependentsScreen extends StatefulWidget {
  final DependentEntity? dependentEntity;
  final String cpfHolder;
  final String nameHolder;

  const EditDependentsScreen({
    Key? key,
    this.dependentEntity,
    required this.cpfHolder,
    required this.nameHolder,
  }) : super(key: key);

  @override
  State<EditDependentsScreen> createState() => _EditDependentsScreenState();
}

class _EditDependentsScreenState extends State<EditDependentsScreen> {
  late EditDependentsController editDependentsController;
  late EditDependentsScreenBloc _editDependentsScreenBloc;

  bool firstState = true;
  String employeeID = '';

  @override
  void initState() {
    super.initState();

    _editDependentsScreenBloc = Modular.get<EditDependentsScreenBloc>();

    if (_editDependentsScreenBloc.educationDegreeBloc.state is! LoadedEducationDegreeState) {
      _editDependentsScreenBloc.educationDegreeBloc.add(GetEducationDegreeProfileEvent());
    }

    if (_editDependentsScreenBloc.activeContractBloc.state is LoadedActiveContractState && employeeID.isEmpty) {
      employeeID = (_editDependentsScreenBloc.activeContractBloc.state as LoadedActiveContractState)
          .activeContractEntity
          .employeeId;
    }

    if (_editDependentsScreenBloc.needAttachmentEditBloc.state is! LoadedNeedAttachmentEditState) {
      _editDependentsScreenBloc.needAttachmentEditBloc.add(
        const GetNeedAttachmentEditEvent(
          role: 'DEPENDENT',
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstState) {
      firstState = false;
      editDependentsController = EditDependentsController(
        dependentEntity: widget.dependentEntity,
        appLocalizations: context.translate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditDependentsScreenBloc, EditDependentsScreenState>(
      bloc: _editDependentsScreenBloc,
      listener: (context, state) {
        if (state.editDependentsState is ErrorEditDependents) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.anErrorOccurredWhenSubmittingTheFormTapRetryToTryAgain,
              action: SeniorSnackBarAction(
                onPressed: () => _sendUpdateDependent(),
                label: context.translate.repeat,
              ),
            ),
          );
        }

        if (state.editDependentsState is SentEditDependents) {
          _editDependentsScreenBloc.dependentBloc.add(
            GetDependentsEvent(employeeId: employeeID),
          );
          Modular.to.pop(true);

          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: context.translate.dependentSubmitted,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.getNeedAttachmentEditState is LoadedNeedAttachmentEditState) {
          editDependentsController.needAttachment =
              (state.getNeedAttachmentEditState as LoadedNeedAttachmentEditState).needAttachmentEdit;
        }

        _editDependentsScreenBloc.waapiManagementPanelUploaderBloc.add(
          HasAttachmentToUploadPanelUploaderEvent(
            attachments: editDependentsController.attachmentsController ?? [],
          ),
        );

        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: WaapiPageViewWidget(
                  pageController: editDependentsController.pageController,
                  validationExitIncompleteAction: true,
                  listPagesViews: [
                    InputMandatoryDataScreen(
                      enableDependentIncomeTax: editDependentsController.enableDependentIncomeTax,
                      editDependentsController: editDependentsController,
                      cpfHolder: widget.cpfHolder,
                      nameHolder: widget.nameHolder,
                      onValueChanged: () {
                        setState(() {});
                      },
                    ),
                    InputDocumentsScreen(
                      editDependentsController: editDependentsController,
                      onValueChanged: () {
                        setState(() {});
                      },
                    ),
                    InputAttachmentsWidget(
                      panelUploaderBloc: _editDependentsScreenBloc.waapiManagementPanelUploaderBloc,
                      isRequiredAttachments: editDependentsController.needAttachment,
                      header: context.translate.receipts,
                    ),
                    InputNotesWidget(
                      disableCheckBox: _editDependentsScreenBloc.editDependentsBloc.state is LoadingEditDependents,
                      notesController: editDependentsController.notesController,
                      trueInformation: editDependentsController.trueInformation,
                      onChangedTrueInformation: (status) {
                        setState(() {
                          editDependentsController.trueInformation = status ?? false;
                        });
                      },
                    ),
                  ],
                  loadedPages: _editDependentsScreenBloc.educationDegreeBloc.state.educationDegreeList.isNotEmpty,
                  disableTopButton: disableTopButton() || busyTopButton(),
                  busyTopButton: busyTopButton(),
                  currentStep: editDependentsController.currentStep,
                  onPressedTopButton: () {
                    FocusScope.of(context).unfocus();
                    if (editDependentsController.currentStep <= 3) {
                      editDependentsController.pageController.nextPage(
                        duration: kTabScrollDuration,
                        curve: Curves.easeIn,
                      );
                      editDependentsController.currentStep++;
                      setState(() {});
                    } else {
                      _saveAndSendConfirmation(context);
                    }
                  },
                  labelTopButton: labelTopButton(
                    context: context,
                  ),
                  disableBottomButton: disableBottomButton() || busyTopButton(),
                  busyBottomButton: busyTopButton(),
                  onPressedBottomButton: onPressedBottomButton,
                  onPressedGhostButtonDialog: () {
                    Modular.to.pop();
                  },
                  onPressedActionButtonDialog: () {
                    Modular.to.pop();
                    Modular.to.pop();
                  },
                  labelBottomButton: labelBottomButton(
                    context: context,
                  ),
                  labelTitleDialog: context.translate.doYouWantToCancelFillingInThisForm,
                  labelContentDialog: context.translate.ifYouConfirmYouWillLoseTheInformationEnteredInThisForm,
                  labelActionButtonDialog: context.translate.confirm,
                  labelGhostButtonDialog: context.translate.close,
                  titleScreen: context.translate.myDependents,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String labelTopButton({required BuildContext context}) {
    return editDependentsController.currentStep == 4 ? context.translate.saveAndSubmit : context.translate.next;
  }

  String labelBottomButton({required BuildContext context}) {
    return editDependentsController.currentStep > 1 ? context.translate.back : context.translate.optionCancel;
  }

  bool goNextPage() {
    if (editDependentsController.currentStep == 1) {
      return editDependentsController.mandatoryTextIsValid();
    }
    if (editDependentsController.currentStep == 2) {
      return true;
    }
    if (editDependentsController.currentStep == 3) {
      return editDependentsController.needAttachment
          ? _editDependentsScreenBloc.waapiManagementPanelUploaderBloc.state.attachments.isNotEmpty
          : true;
    }
    return editDependentsController.currentStep == 4 && editDependentsController.trueInformation;
  }

  bool busyTopButton() {
    return _editDependentsScreenBloc.editDependentsBloc.state is LoadingEditDependents;
  }

  void onPressedBottomButton() {
    setState(() {
      editDependentsController.pageController.previousPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      editDependentsController.currentStep--;
    });
    return;
  }

  bool disableTopButton() {
    return !goNextPage();
  }

  bool disableBottomButton() {
    return busyTopButton();
  }

  void _sendUpdateDependent() {
    List<AttachmentsInputModel>? attachments =
        _editDependentsScreenBloc.waapiManagementPanelUploaderBloc.state.attachments
            .map(
              (attachment) => AttachmentsInputModel(
                id: attachment.id,
                name: attachment.name,
                link: attachment.link,
                personId: attachment.personId,
                operation:
                    editDependentsController.attachmentsController?.contains(attachment) ?? false ? 'EMPTY' : 'INSERT',
              ),
            )
            .toList();

    _editDependentsScreenBloc.editDependentsBloc.add(
      SendEditDependentsEvent(
        employeeId: employeeID,
        dependentDtoInputModel: editDependentsController.sendDependent(
          attachmentsInputModel: attachments,
          employeeId: employeeID,
        ),
      ),
    );
  }

  void _saveAndSendConfirmation(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.saveForm,
          content: context.translate.noShowAgainMessage,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () {
              Modular.to.pop();
            },
          ),
          otherAction: SeniorModalAction(
            label: context.translate.save,
            action: () {
              _sendUpdateDependent();
              Modular.to.pop(true);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Modular.dispose<EditDependentsScreenBloc>();
    editDependentsController.fullNameController.dispose();
    editDependentsController.genderController.dispose();
    editDependentsController.birthDateController.dispose();
    editDependentsController.maritalStatusController.dispose();
    editDependentsController.degreeOfKinshipController.dispose();
    editDependentsController.educationDegreeController.dispose();
    editDependentsController.naturalityController.dispose();
    editDependentsController.cpfNumberController.dispose();
    editDependentsController.mothersNameController.dispose();
    editDependentsController.liveBirthDeclarationController.dispose();
    editDependentsController.notesController.dispose();
    editDependentsController.pageController.dispose();
    editDependentsController.cityController.dispose();
    editDependentsController.cityIdController.dispose();
    editDependentsController.birthEnrollmentController.dispose();
    editDependentsController.birthTermNumberController.dispose();
    editDependentsController.birthBookNumberController.dispose();
    editDependentsController.birthSheetNumberController.dispose();
    editDependentsController.birthIssuanceDateController.dispose();
    editDependentsController.birthNotaryOfficeNameController.dispose();
    editDependentsController.birthNotaryOfficeCityController.dispose();
    editDependentsController.birthNotaryOfficeCityIdController.dispose();
    editDependentsController.deathEnrollmentController.dispose();
    editDependentsController.deathTermNumberController.dispose();
    editDependentsController.deathBookNumberController.dispose();
    editDependentsController.deathSheetNumberController.dispose();
    editDependentsController.deathIssuanceDateController.dispose();
    editDependentsController.deathNotaryOfficeNameController.dispose();
    editDependentsController.deathNotaryOfficeCityController.dispose();
    editDependentsController.deathNotaryOfficeCityIdController.dispose();
    editDependentsController.rgNumberController.dispose();
    editDependentsController.rgIssuanceDateController.dispose();
    editDependentsController.rgIssuerController.dispose();
    editDependentsController.rgIssuingStateController.dispose();
    super.dispose();
  }
}
