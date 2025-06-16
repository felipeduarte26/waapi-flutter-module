import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/components/components.dart';

import '../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/input_attachments_widget.dart';
import '../../../../../core/widgets/input_notes_widget.dart';
import '../../../../../core/widgets/waapi_page_view_widget.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/city_entity.dart';
import '../../../domain/entities/civil_certificate_entity.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/input_models/attachments_input_model.dart';
import '../../../domain/input_models/edit_personal_documents_civil_certificates_input_model.dart';
import '../../../domain/input_models/edit_personal_documents_dto_input_model.dart';
import '../../../domain/input_models/edit_personal_documents_input_model.dart';
import '../../../enums/document_type_enum.dart';
import '../../../enums/gender_type_enum.dart';
import '../../../helper/cpf_validator_help.dart';
import '../../../helper/nis_validator_helper.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_event.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../blocs/person_bloc/person_state.dart';
import '../../blocs/profile_bloc/profile_event.dart';
import '../../blocs/search_country_bloc/search_country_bloc.dart';
import '../../blocs/search_country_bloc/search_country_state.dart';
import '../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../blocs/search_naturality/search_naturality_state.dart';
import '../../blocs/update_personal_documents_bloc/update_personal_documents_bloc.dart';
import '../../blocs/update_personal_documents_bloc/update_personal_documents_event.dart';
import '../../blocs/update_personal_documents_bloc/update_personal_documents_state.dart';
import 'bloc/edit_personal_documents_screen_bloc.dart';
import 'bloc/edit_personal_documents_screen_state.dart';
import 'components/edit_personal_documents_civil_certificates_screen.dart';
import 'components/edit_personal_documents_cnh_screen.dart';
import 'components/edit_personal_documents_cns_screen.dart';
import 'components/edit_personal_documents_cpf_screen.dart';
import 'components/edit_personal_documents_ctps_screen.dart';
import 'components/edit_personal_documents_nis_screen.dart';
import 'components/edit_personal_documents_passport_screen.dart';
import 'components/edit_personal_documents_reservist_certificate_screen.dart';
import 'components/edit_personal_documents_rg_screen.dart';
import 'components/edit_personal_documents_ric_screen.dart';
import 'components/edit_personal_documents_voter_registration_screen.dart';
import 'edit_personal_documents_controllers.dart';

class EditPersonalDocumentsScreen extends StatefulWidget {
  final Map<DocumentTypeEnum, bool> documents;

  const EditPersonalDocumentsScreen({
    Key? key,
    required this.documents,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsScreen> createState() {
    return _EditPersonalDocumentsScreenState();
  }
}

class _EditPersonalDocumentsScreenState extends State<EditPersonalDocumentsScreen> {
  late final EditPersonalDocumentsScreenBloc _editPersonalDocumentsScreenBloc;
  late final WaapiManagementPanelUploaderBloc _waapiManagementPanelUploaderBloc;
  late final AuthorizationBloc _authorizationBloc;
  late final AuthorizationEntity? _authEntity;
  late final String gender;
  late final ProfileEntity _profileEntity;

  EditPersonalDocumentsControllers? editPersonalDocumentsControllers;

  final PageController _pageController = PageController();
  final Map<int, DocumentTypeEnum> _mapPages = {};
  final List<Widget> _listPagesViews = [];
  final List<CivilCertificateEntity> loadedProfileCivilCertificates = [];

  ValueNotifier<BrazilianStateEnum?> rgIssuingStateEnum = ValueNotifier(null);
  CountryEntity country = const CountryEntity();
  CityEntity addressCity = const CityEntity();
  int currentStep = 1;
  int inputAttachmentsWidgetIndex = 0;
  int inputNotesWidgetIndex = 0;
  bool trueInformation = false;
  bool needAttachment = false;
  @override
  void initState() {
    super.initState();

    _waapiManagementPanelUploaderBloc = Modular.get<WaapiManagementPanelUploaderBloc>();
    _editPersonalDocumentsScreenBloc = Modular.get<EditPersonalDocumentsScreenBloc>();
    _authorizationBloc = Modular.get<AuthorizationBloc>();
    _authEntity = (_authorizationBloc.state is LoadedAuthorizationState)
        ? (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity
        : null;

    _profileEntity = _editPersonalDocumentsScreenBloc.getProfileBloc.state.profileEntity!;

    if (_editPersonalDocumentsScreenBloc.getNeedAttachmentEditBloc.state is! LoadedNeedAttachmentEditState) {
      _editPersonalDocumentsScreenBloc.getNeedAttachmentEditBloc.add(
        const GetNeedAttachmentEditEvent(
          role: 'DOCUMENT',
        ),
      );
    }

    gender = EnumHelper<GenderTypeEnum>().enumToString(
      enumToParse: _profileEntity.gender!,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    editPersonalDocumentsControllers ??= EditPersonalDocumentsControllers(
      profileEntity: _profileEntity,
      localeName: context.translate.localeName,
    );

    editPersonalDocumentsControllers?.cpfController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.rgIssuanceDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.ctpsIssuanceDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.cnhIssuedDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.cnhFirstIssuedDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.cnhExpiryDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.passportIssuedDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.passportExpiryDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.ricIssuanceDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.nisRegisterDateController.addListener(() {
      setState(() {});
    });

    editPersonalDocumentsControllers?.nisNumberController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_listPagesViews.isEmpty) {
      confirmedDocuments(
        checks: widget.documents,
      );
    }

    if (_listPagesViews.isNotEmpty) {
      return MultiBlocListener(
        listeners: [
          BlocListener<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
            bloc: _waapiManagementPanelUploaderBloc,
            listener: (context, state) {
              if (state is InitialPanelUploaderState) {
                setState(() {});
              }
            },
          ),
          BlocListener<SearchCountryBloc, SearchCountryState>(
            bloc: _editPersonalDocumentsScreenBloc.searchCountryBloc,
            listener: (context, state) {
              if (state is LoadedSelectCountryState && state.selectedCountryEntity != null) {
                country = state.selectedCountryEntity!;
                editPersonalDocumentsControllers?.passportCountryController.text = country.name!;
                editPersonalDocumentsControllers?.passportCountryIdController.text = country.id!;
              }
            },
          ),
          BlocListener<SearchNaturalityBloc, SearchNaturalityState>(
            bloc: _editPersonalDocumentsScreenBloc.searchRicCityBloc,
            listener: ((context, state) {
              if (state is LoadedSelectNaturalityState && state.selectedNaturalityEntity != null) {
                addressCity = state.selectedNaturalityEntity!;
                editPersonalDocumentsControllers?.ricIssuingCityController.text = addressCity.name!;
                editPersonalDocumentsControllers?.ricIssuingCityIdController.text = addressCity.id!;
              }
            }),
          ),
          BlocListener<UpdatePersonalDocumentsBloc, UpdatePersonalDocumentsState>(
            bloc: _editPersonalDocumentsScreenBloc.updatePersonalDocumentsBloc,
            listener: ((context, state) {
              if (state is SentUpdatePersonalDocumentsState &&
                  _editPersonalDocumentsScreenBloc.state.getPersonState is LoadedPersonState) {
                _editPersonalDocumentsScreenBloc.getProfileBloc.add(
                  GetProfileEvent(
                    employeeId:
                        _editPersonalDocumentsScreenBloc.state.getProfileState.profileEntity!.contract!.employeeId!,
                    personId: (_editPersonalDocumentsScreenBloc.state.getPersonState as LoadedPersonState).personId,
                  ),
                );

                Modular.to.pop(true);
                Modular.to.pop(true);

                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.success(
                    message: context.translate.personalDocumentsSubmitted,
                  ),
                );
              }

              if (state is ErrorUpdatePersonalDocumentsState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.alertErrorSubmit,
                    action: SeniorSnackBarAction(
                      label: context.translate.repeat,
                      onPressed: () => _sendUpdatePersonalDocuments(),
                    ),
                  ),
                );
              }
            }),
          ),
        ],
        child: BlocBuilder<EditPersonalDocumentsScreenBloc, EditPersonalDocumentsScreenState>(
          bloc: _editPersonalDocumentsScreenBloc,
          builder: (context, state) {
            if (state.getNeedAttachmentEditState is LoadedNeedAttachmentEditState) {
              needAttachment = (state.getNeedAttachmentEditState as LoadedNeedAttachmentEditState).needAttachmentEdit;
            }
            return WaapiPageViewWidget(
              pageController: _pageController,
              validationExitIncompleteAction: true,
              listPagesViews: [
                ..._listPagesViews,
                InputAttachmentsWidget(
                  panelUploaderBloc: _waapiManagementPanelUploaderBloc,
                  isRequiredAttachments: needAttachment,
                  header: context.translate.receipts,
                ),
                InputNotesWidget(
                  notesController: editPersonalDocumentsControllers!.notesController,
                  trueInformation: trueInformation,
                  onChangedTrueInformation: (status) {
                    setState(
                      () {
                        trueInformation = status ?? false;
                      },
                    );
                  },
                ),
              ],
              loadedPages: true,
              disableTopButton: disableTopButton(state),
              busyTopButton: busyTopButton(state),
              currentStep: currentStep,
              onPressedGhostButtonDialog: () {
                Modular.to.pop();
              },
              onPressedActionButtonDialog: () {
                Modular.to.pop();
                Modular.to.pop();
              },
              onPressedTopButton: onPressedTopButton,
              labelTopButton: labelTopButton(context),
              disableBottomButton: false,
              busyBottomButton: false,
              onPressedBottomButton: onPressedBottomButton,
              labelBottomButton: labelBottomButton(context),
              labelTitleDialog: context.translate.doYouWantToCancelFillingInThisForm,
              labelContentDialog: context.translate.ifYouConfirmYouWillLoseTheInformationEnteredInThisForm,
              labelActionButtonDialog: context.translate.confirm,
              labelGhostButtonDialog: context.translate.close,
              titleScreen: context.translate.editDocuments,
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  String labelTopButton(BuildContext context) {
    return currentStep == _listPagesViews.length + 2 ? context.translate.saveAndSubmit : context.translate.next;
  }

  String labelBottomButton(BuildContext context) {
    return currentStep > 1 ? context.translate.back : context.translate.optionCancel;
  }

  void onPressedBottomButton() {
    setState(() {
      _pageController.previousPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep--;
    });
    return;
  }

  void onPressedTopButton() {
    FocusScope.of(context).unfocus();
    if (currentStep < _listPagesViews.length + 2) {
      _pageController.nextPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep++;
      setState(() {});
      return;
    }

    _sendUpdatePersonalDocuments();
  }

  bool disableTopButton(EditPersonalDocumentsScreenState state) {
    return goNextPage() || state.updatePersonalDocumentsState is LoadingUpdatePersonalDocumentsState;
  }

  bool busyTopButton(EditPersonalDocumentsScreenState state) {
    return state.updatePersonalDocumentsState is LoadingUpdatePersonalDocumentsState;
  }

  void confirmedDocuments({required Map<DocumentTypeEnum, bool> checks}) {
    final cpfStatus = checks[DocumentTypeEnum.cpf]!;
    int index = 0;

    if (cpfStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.cpf});
      _listPagesViews.add(
        EditPersonalDocumentsCpfScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final rgStatus = checks[DocumentTypeEnum.rg]!;

    if (rgStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.rg});
      _listPagesViews.add(
        EditPersonalDocumentsRgScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final voterStatus = checks[DocumentTypeEnum.voterRegistrationCard]!;

    if (voterStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.voterRegistrationCard});
      _listPagesViews.add(
        EditPersonalDocumentsVoterRegistrationScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final ctpsStatus = checks[DocumentTypeEnum.ctps]!;

    if (ctpsStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.ctps});
      _listPagesViews.add(
        EditPersonalDocumentsCtpsScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final cnhStatus = checks[DocumentTypeEnum.cnh]!;

    if (cnhStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.cnh});
      _listPagesViews.add(
        EditPersonalDocumentsCnhScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final passportStatus = checks[DocumentTypeEnum.passport]!;

    if (passportStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.passport});
      _listPagesViews.add(
        EditPersonalDocumentsPassportScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final ricStatus = checks[DocumentTypeEnum.ric]!;

    if (ricStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.ric});
      _listPagesViews.add(
        EditPersonalDocumentsRicScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final nisStatus = checks[DocumentTypeEnum.nis]!;

    if (nisStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.nis});
      _listPagesViews.add(
        EditPersonalDocumentsNisScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    if (gender != EnumHelper().enumToString(enumToParse: GenderTypeEnum.female)) {
      final cdiStatus = checks[DocumentTypeEnum.cdi]!;

      if (cdiStatus) {
        index++;
        _mapPages.addAll({index: DocumentTypeEnum.cdi});
        _listPagesViews.add(
          EditPersonalDocumentsReservistCertificateScreen(
            editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
            authEntity: _authEntity,
          ),
        );
      }
    }

    final cnsStatus = checks[DocumentTypeEnum.cns]!;

    if (cnsStatus) {
      index++;
      _mapPages.addAll({index: DocumentTypeEnum.cns});
      _listPagesViews.add(
        EditPersonalDocumentsCnsScreen(
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
          authEntity: _authEntity,
        ),
      );
    }

    final civilCertificateStatus = checks[DocumentTypeEnum.civilCertificate] ?? false;

    if (civilCertificateStatus) {
      if (_profileEntity.civilCertificates != null) {
        for (var civilCertificate in _profileEntity.civilCertificates!) {
          if (civilCertificate.certificateType != null) {
            loadedProfileCivilCertificates.add(civilCertificate);
          }
        }
      }

      index++;
      _mapPages.addAll({index: DocumentTypeEnum.civilCertificate});
      _listPagesViews.add(
        EditPersonalDocumentsCivilCertificatesScreen(
          listingCivilCertificates: loadedProfileCivilCertificates,
          editPersonalDocumentsControllers: editPersonalDocumentsControllers!,
        ),
      );
    }

    index++;
    inputAttachmentsWidgetIndex = index;

    index++;
    inputNotesWidgetIndex = index;
  }

  bool goNextPage() {
    if (_mapPages[currentStep] == DocumentTypeEnum.cpf) {
      return !(editPersonalDocumentsControllers!.cpfController.text.isNotEmpty &&
          CpfValidatorHelp.isValid(editPersonalDocumentsControllers!.cpfController.text));
    }
    if (_mapPages[currentStep] == DocumentTypeEnum.nis) {
      return !(editPersonalDocumentsControllers!.nisNumberController.text.isNotEmpty &&
              NisValidatorHelper.isValid(editPersonalDocumentsControllers!.nisNumberController.text)) ||
          !validIssuanceDate(
            date: editPersonalDocumentsControllers!.nisRegisterDateController.text,
          );
    }
    if (currentStep == inputAttachmentsWidgetIndex) {
      return needAttachment ? _waapiManagementPanelUploaderBloc.state.attachments.isEmpty : false;
    }
    if (currentStep == inputNotesWidgetIndex) {
      return !trueInformation;
    }
    if (_mapPages[currentStep] == DocumentTypeEnum.rg) {
      return !validIssuanceDate(
        date: editPersonalDocumentsControllers!.rgIssuanceDateController.text,
      );
    }
    if (_mapPages[currentStep] == DocumentTypeEnum.ctps) {
      return !validIssuanceDate(
        date: editPersonalDocumentsControllers!.ctpsIssuanceDateController.text,
      );
    }
    if (_mapPages[currentStep] == DocumentTypeEnum.cnh) {
      final issuedDate = !validIssuanceDate(
        date: editPersonalDocumentsControllers!.cnhIssuedDateController.text,
      );

      final firstDate = !validIssuanceDate(
        date: editPersonalDocumentsControllers!.cnhFirstIssuedDateController.text,
      );

      bool expiryDate = false;
      var date = editPersonalDocumentsControllers!.cnhExpiryDateController.text;
      if (date.isNotEmpty) {
        expiryDate = !DateTimeHelper.validateDate(
          date: date,
          locale: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        );
      }

      return issuedDate || firstDate || expiryDate;
    }
    if (_mapPages[currentStep] == DocumentTypeEnum.passport) {
      final issuedDate = !validIssuanceDate(
        date: editPersonalDocumentsControllers!.passportIssuedDateController.text,
      );

      bool expiryDate = false;
      var date = editPersonalDocumentsControllers!.passportExpiryDateController.text;
      if (date.isNotEmpty) {
        expiryDate = !DateTimeHelper.validateDate(
          date: date,
          locale: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        );
      }

      return issuedDate || expiryDate;
    }
    if (_mapPages[currentStep] == DocumentTypeEnum.ric) {
      return !validIssuanceDate(
        date: editPersonalDocumentsControllers!.ricIssuanceDateController.text,
      );
    }
    return false;
  }

  bool validIssuanceDate({required String date}) {
    if (date.isNotEmpty) {
      if (!DateTimeHelper.validateDate(
        date: date,
        locale: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
      )) {
        return false;
      }
      if (!DateTimeHelper.validateDate(
        date: date,
        locale: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
        validateCurrentMajorYear: true,
      )) {
        return false;
      }
    }
    return true;
  }

  void _sendUpdatePersonalDocuments() {
    final attachments = _waapiManagementPanelUploaderBloc.state.attachments
        .map(
          (attachment) => AttachmentsInputModel(
            id: attachment.id,
            name: attachment.name,
            link: attachment.link,
            personId: attachment.personId,
            operation: 'INSERT',
          ),
        )
        .toList();

    final List<EditPersonalDocumentsCivilCertificatesInputModel> civilCertificatesInputModel = [];

    for (var certificate in loadedProfileCivilCertificates) {
      //desconsiderar pois já existia
      final exist = _profileEntity.civilCertificates?.contains(certificate);
      if (exist != null && exist) {
        continue;
      } else if (certificate.id == null) {
        civilCertificatesInputModel.add(
          EditPersonalDocumentsCivilCertificatesInputModel(
            certificateType: certificate.certificateType!,
            issuedDate: DateTimeHelper.formatToIso8601Date(
              dateTime: certificate.issuedDate!,
            ),
            bookNumber: certificate.bookNumber,
            enrollment: certificate.enrollment,
            paperNumber: certificate.paperNumber,
            termNumber: certificate.termNumber,
            registryName: certificate.registryName,
            cityId: certificate.city?.id,
            requestType: 'INSERT',
            updateDate: DateTimeHelper.formatToIso8601Date(
              dateTime: DateTime.now(),
            ),
            isLast: false,
          ),
        );
      } else if (certificate.id != null) {
        civilCertificatesInputModel.add(
          EditPersonalDocumentsCivilCertificatesInputModel(
            certificateType: certificate.certificateType!,
            issuedDate: DateTimeHelper.formatToIso8601Date(
              dateTime: certificate.issuedDate!,
            ),
            requestType: 'UPDATE',
            id: certificate.id,
            bookNumber: certificate.bookNumber,
            enrollment: certificate.enrollment,
            paperNumber: certificate.paperNumber,
            termNumber: certificate.termNumber,
            registryName: certificate.registryName,
            cityId: certificate.city?.id,
            isLast: false,
          ),
        );
      }
    }

    if (widget.documents[DocumentTypeEnum.civilCertificate] == true && _profileEntity.civilCertificates != null) {
      for (var certificate in _profileEntity.civilCertificates!.where((e) => e.certificateType != null).toList()) {
        final thereAreCertificates = loadedProfileCivilCertificates.where((e) => certificate.id == e.id).length;
        if (thereAreCertificates == 0) {
          civilCertificatesInputModel.add(
            EditPersonalDocumentsCivilCertificatesInputModel(
              certificateType: certificate.certificateType!,
              issuedDate: certificate.issuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: certificate.issuedDate!,
                    )
                  : '',
              requestType: 'DELETE',
              id: certificate.id,
              isLast: false,
            ),
          );
        }
      }
    }

    if (loadedProfileCivilCertificates.isEmpty && civilCertificatesInputModel.isNotEmpty) {
      final certificate = civilCertificatesInputModel.last;
      final isLast = EditPersonalDocumentsCivilCertificatesInputModel(
        certificateType: certificate.certificateType,
        issuedDate: certificate.issuedDate,
        requestType: 'DELETE',
        id: certificate.id,
        isLast: true,
      );

      civilCertificatesInputModel.remove(certificate);
      civilCertificatesInputModel.add(isLast);
    }

    _editPersonalDocumentsScreenBloc.updatePersonalDocumentsBloc.add(
      SendUpdatePersonalDocumentsEvent(
        editPersonalDocumentsInputModel: EditPersonalDocumentsInputModel(
          type: 'DOCUMENT',
          documents: EditPersonalDocumentsDtoInputModel(
            cpf: editPersonalDocumentsControllers!.cpfController.text,
            isForeigner: false,
            gender: gender,
            isRealData: trueInformation,
            nationalHealthCard: validateState(
              newValue: editPersonalDocumentsControllers!.cnsNumberController.text,
              oldValue: _profileEntity.nationalHealthCard ?? '',
            ),
            commentary: editPersonalDocumentsControllers!.notesController.text,
            rgNumber: validateState(
              newValue: editPersonalDocumentsControllers!.rgNumberController.text,
              oldValue: _profileEntity.rg?.number ?? '',
            ),
            rgIssuer: validateState(
              newValue: editPersonalDocumentsControllers!.rgIssuerController.text,
              oldValue: _profileEntity.rg?.issuer ?? '',
            ),
            rgIssuingState: editPersonalDocumentsControllers!.rgIssuingStateController.text.isEmpty
                ? 'EMPTY'
                : editPersonalDocumentsControllers!.rgIssuingStateController.text,
            rgIssuedDate: validateState(
              newValue: editPersonalDocumentsControllers!.rgIssuanceDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.rgIssuanceDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.rg?.issuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.rg!.issuedDate!,
                    )
                  : '',
            ),
            nisNumber:
                editPersonalDocumentsControllers!.nisNumberController.text.replaceAll('.', '').replaceAll('-', ''),
            nisRegistrationDate: editPersonalDocumentsControllers!.nisRegisterDateController.text.isNotEmpty
                ? DateTimeHelper.formatToIso8601Date(
                    dateTime: DateFormat.yMd(
                      LocaleHelper.languageAndCountryCode(
                        locale: Localizations.localeOf(context),
                      ),
                    ).parse(editPersonalDocumentsControllers!.nisRegisterDateController.text),
                  )
                : '',
            ctpsNumber: editPersonalDocumentsControllers!.ctpsNumberController.text,
            ctpsSerie: editPersonalDocumentsControllers!.ctpsSerieController.text,
            ctpsSerieDigit: editPersonalDocumentsControllers!.ctpsSerieDigitController.text,
            ctpsIssuedDate: validateState(
              newValue: editPersonalDocumentsControllers!.ctpsIssuanceDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.ctpsIssuanceDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.ctps?.issuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.ctps!.issuedDate!,
                    )
                  : '',
            ),
            ctpsState: editPersonalDocumentsControllers!.ctpsIssuingStateController.text.isEmpty
                ? 'EMPTY'
                : editPersonalDocumentsControllers!.ctpsIssuingStateController.text,
            cnhNumber: validateState(
              newValue: editPersonalDocumentsControllers!.cnhNumberController.text,
              oldValue: _profileEntity.cnh?.number ?? '',
            ),
            cnhCategory: editPersonalDocumentsControllers!.cnhCategoryController.text.isEmpty
                ? 'EMPTY'
                : editPersonalDocumentsControllers!.cnhCategoryController.text,
            cnhIssuer: validateState(
              newValue: editPersonalDocumentsControllers!.cnhIssuerController.text,
              oldValue: _profileEntity.cnh?.issuer ?? '',
            ),
            cnhIssuerState: editPersonalDocumentsControllers!.cnhIssuerStateController.text.isEmpty
                ? 'EMPTY'
                : editPersonalDocumentsControllers!.cnhIssuerStateController.text,
            cnhFirstIssuedDate: validateState(
              newValue: editPersonalDocumentsControllers!.cnhFirstIssuedDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.cnhFirstIssuedDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.cnh?.firstIssuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.cnh!.firstIssuedDate!,
                    )
                  : '',
            ),
            cnhIssuedDate: validateState(
              newValue: editPersonalDocumentsControllers!.cnhIssuedDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.cnhIssuedDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.cnh?.issuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.cnh!.issuedDate!,
                    )
                  : '',
            ),
            cnhExpiryDate: validateState(
              newValue: editPersonalDocumentsControllers!.cnhExpiryDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.cnhExpiryDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.cnh?.expiryDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.cnh!.expiryDate!,
                    )
                  : '',
            ),
            passportNumber: validateState(
              newValue: editPersonalDocumentsControllers!.passportNumberController.text,
              oldValue: _profileEntity.passport?.number ?? '',
            ),
            passportIssuer: validateState(
              newValue: editPersonalDocumentsControllers!.passportIssuerController.text,
              oldValue: _profileEntity.passport?.issuer ?? '',
            ),
            passportIssuedDate: validateState(
              newValue: editPersonalDocumentsControllers!.passportIssuedDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.passportIssuedDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.passport?.issuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.passport!.issuedDate!,
                    )
                  : '',
            ),
            passportExpiryDate: validateState(
              newValue: editPersonalDocumentsControllers!.passportExpiryDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.passportExpiryDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.passport?.expiryDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.passport!.expiryDate!,
                    )
                  : '',
            ),
            passportIssuingCountryId: validateState(
              newValue: editPersonalDocumentsControllers!.passportCountryIdController.text,
              oldValue: _profileEntity.passport?.issuingCountryId ?? '',
            ),
            passportIssuingState: editPersonalDocumentsControllers!.passportIssuerStateController.text.isEmpty
                ? 'EMPTY'
                : editPersonalDocumentsControllers!.passportIssuerStateController.text,
            ricNumber: validateState(
              newValue: editPersonalDocumentsControllers!.ricNumberController.text,
              oldValue: _profileEntity.ric?.number ?? '',
            ),
            ricIssuer: validateState(
              newValue: editPersonalDocumentsControllers!.ricIssuerController.text,
              oldValue: _profileEntity.ric?.issuer ?? '',
            ),
            ricIssuedDate: validateState(
              newValue: editPersonalDocumentsControllers!.ricIssuanceDateController.text.isNotEmpty
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: DateFormat.yMd(
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).parse(editPersonalDocumentsControllers!.ricIssuanceDateController.text),
                    )
                  : '',
              oldValue: _profileEntity.ric?.issuedDate != null
                  ? DateTimeHelper.formatToIso8601Date(
                      dateTime: _profileEntity.ric!.issuedDate!,
                    )
                  : '',
            ),
            ricIssuingCityId: validateState(
              newValue: editPersonalDocumentsControllers!.ricIssuingCityIdController.text,
              oldValue: _profileEntity.ric?.issuingCityId ?? '',
            ),
            voterRegistrationNumber: validateState(
              newValue: editPersonalDocumentsControllers!.voterNumberController.text,
              oldValue: _profileEntity.voterRegistration?.number ?? '',
            ),
            voterRegistrationZone: validateState(
              newValue: editPersonalDocumentsControllers!.voterZoneController.text,
              oldValue: _profileEntity.voterRegistration?.zone != null
                  ? _profileEntity.voterRegistration!.zone!.toString()
                  : '',
            ),
            voterRegistrationSection: validateState(
              newValue: editPersonalDocumentsControllers!.voterSectionController.text,
              oldValue: _profileEntity.voterRegistration?.section != null
                  ? _profileEntity.voterRegistration!.section!.toString()
                  : '',
            ),
            reservistCertificateNumber: validateState(
              newValue: editPersonalDocumentsControllers!.cdiNumberController.text,
              oldValue: _profileEntity.reservistCertificate?.number ?? '',
            ),
            reservistCertificateCategory: validateState(
              newValue: editPersonalDocumentsControllers!.cdiCategoryController.text,
              oldValue: _profileEntity.reservistCertificate?.category ?? '',
            ),
            foreignerBrazilianChildren: false,
            foreignerMarriedWithBrazilian: false,
            civilCertificates: civilCertificatesInputModel,
          ),
          attachments: attachments,
        ),
      ),
    );
  }

  String? validateState({
    required String newValue,
    required String oldValue,
  }) {
    if (newValue == oldValue) {
      return null;
    }

    return newValue;
  }
}
