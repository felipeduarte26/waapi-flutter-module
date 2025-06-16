import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/components/senior_snackbar/senior_snackbar_widget.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/input_attachments_widget.dart';
import '../../../../../core/widgets/input_notes_widget.dart';
import '../../../../../core/widgets/waapi_page_view_widget.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import '../../../domain/entities/city_entity.dart';
import '../../../domain/entities/disability_entity.dart';
import '../../../domain/entities/education_degree_entity.dart';
import '../../../domain/entities/ethnicity_entity.dart';
import '../../../domain/entities/nationality_entity.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/input_models/attachments_input_model.dart';
import '../../../domain/input_models/edit_personal_data_input_model.dart';
import '../../../domain/input_models/edit_personal_data_personal_dto_input_model.dart';
import '../../../infra/models/city_model.dart';
import '../../../infra/models/country_model.dart';
import '../../../infra/models/disabilities_model.dart';
import '../../../infra/models/disability_model.dart';
import '../../../infra/models/education_degree_model.dart';
import '../../../infra/models/ethnicity_model.dart';
import '../../../infra/models/nationality_model.dart';
import '../../../infra/models/state_model.dart';
import '../../blocs/disability_bloc/disability_event.dart';
import '../../blocs/disability_bloc/disability_state.dart';
import '../../blocs/education_degree_bloc/education_degree_event.dart';
import '../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_event.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../blocs/person_bloc/person_state.dart';
import '../../blocs/profile_bloc/profile_event.dart';
import '../../blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';
import '../../blocs/search_nationality/search_nationality_bloc.dart';
import '../../blocs/search_nationality/search_nationality_state.dart';
import '../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../blocs/search_naturality/search_naturality_state.dart';
import '../../blocs/update_personal_data_bloc/update_personal_data_bloc.dart';
import '../../blocs/update_personal_data_bloc/update_personal_data_event.dart';
import '../../blocs/update_personal_data_bloc/update_personal_data_state.dart';
import 'bloc/edit_personal_data_screen_bloc.dart';
import 'bloc/edit_personal_data_screen_state.dart';
import 'components/input_personal_data_screen.dart';
import 'components/select_disabilities_screen.dart';

class EditPersonalDataScreen extends StatefulWidget {
  const EditPersonalDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPersonalDataScreen> createState() {
    return _EditPersonalDataScreenState();
  }
}

class _EditPersonalDataScreenState extends State<EditPersonalDataScreen> {
  final PageController _pageController = PageController();
  late ProfileEntity _profileEntity;
  var currentStep = 1;
  late final EditPersonalDataScreenBloc _editPersonalDataScreenBloc;
  bool needAttachment = false;
  late final WaapiManagementPanelUploaderBloc _waapiManagementPanelUploaderBloc;
  List<DisabilityEntity> loadedProfileDisabilities = [];
  bool rehabilited = false;
  bool trueInformation = false;
  NationalityEntity nationality = const NationalityEntity();
  CityEntity naturality = const CityEntity();
  EducationDegreeEntity? educationDegree = const EducationDegreeEntity();
  EthnicityEntity ethnicityEntity = const EthnicityEntity();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _naturalityController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _educationDegreeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _editPersonalDataScreenBloc = Modular.get<EditPersonalDataScreenBloc>();
    _waapiManagementPanelUploaderBloc = Modular.get<WaapiManagementPanelUploaderBloc>();

    _profileEntity = _editPersonalDataScreenBloc.getProfileBloc.state.profileEntity!;

    if (_editPersonalDataScreenBloc.getEducationDegreeBloc.state is! LoadedEducationDegreeState) {
      _editPersonalDataScreenBloc.getEducationDegreeBloc.add(GetEducationDegreeProfileEvent());
    }

    if (_editPersonalDataScreenBloc.getDisabilityBloc.state is! LoadedDisabilityState) {
      _editPersonalDataScreenBloc.getDisabilityBloc.add(DisabilityProfileEvent());
    }

    if (_editPersonalDataScreenBloc.getNeedAttachmentEditBloc.state is! LoadedNeedAttachmentEditState) {
      _editPersonalDataScreenBloc.getNeedAttachmentEditBloc.add(
        const GetNeedAttachmentEditEvent(
          role: 'PERSONAL_DATA',
        ),
      );
    }

    _dateOfBirthController.addListener(() {
      setState(() {});
    });

    _fullNameController.addListener(() {
      setState(() {});
    });

    _nationalityController.addListener(() {
      setState(() {});
    });

    _ethnicityController.addListener(() {
      setState(() {});
    });

    _naturalityController.addListener(() {
      setState(() {});
    });

    _notesController.addListener(() {
      setState(() {});
    });

    _genderController.addListener(() {
      setState(() {});
    });

    _maritalStatusController.addListener(() {
      setState(() {});
    });

    _educationDegreeController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_profileEntity.personEntity?.birthDate != null) {
        _dateOfBirthController.text = DateTimeHelper.formatWithDefaultDatePattern(
          dateTime: _profileEntity.personEntity!.birthDate!,
          locale: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        );
      }
    });

    _educationDegreeController.text = _profileEntity.personEntity?.educationDegree?.id != null
        ? _profileEntity.personEntity!.educationDegree!.id!
        : '';

    _fullNameController.text = _profileEntity.name;

    _genderController.text = _profileEntity.gender != null ? _profileEntity.gender!.name.toUpperCase() : 'MALE';

    _maritalStatusController.text =
        _profileEntity.maritalStatus != null ? _profileEntity.maritalStatus!.name.toUpperCase() : 'SINGLE';

    educationDegree = _profileEntity.personEntity?.educationDegree;

    ethnicityEntity = _editPersonalDataScreenBloc.getProfileBloc.state.profileEntity!.personEntity!.ethnicity ??
        const EthnicityEntity();

    nationality = _profileEntity.nationality ?? const NationalityEntity();

    _nationalityController.text = _profileEntity.nationality != null ? _profileEntity.nationality!.name! : '';

    naturality = _profileEntity.placeOfBirth ?? const CityEntity();

    _naturalityController.text = naturality.name ?? '';

    _ethnicityController.text = _profileEntity.personEntity?.ethnicity?.name ?? '';

    rehabilited = _profileEntity.rehabilitation != null ? _profileEntity.rehabilitation! : false;

    if (_profileEntity.disabilities != null) {
      for (var disability in _profileEntity.disabilities!) {
        loadedProfileDisabilities.add(disability.disability);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<WaapiManagementPanelUploaderBloc>();
    _dateOfBirthController.dispose();
    _fullNameController.dispose();
    _nationalityController.dispose();
    _naturalityController.dispose();
    _notesController.dispose();
    _ethnicityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
          bloc: _waapiManagementPanelUploaderBloc,
          listener: (context, state) {
            if (state is InitialPanelUploaderState) {
              setState(() {
                goNextPage();
              });
            }
          },
        ),
        BlocListener<UpdatePersonalDataBloc, UpdatePersonalDataState>(
          bloc: _editPersonalDataScreenBloc.updatePersonalDataBloc,
          listener: ((context, state) {
            if (state is SentUpdatePersonalDataState &&
                _editPersonalDataScreenBloc.state.getPersonState is LoadedPersonState) {
              _editPersonalDataScreenBloc.getProfileBloc.add(
                GetProfileEvent(
                  employeeId: _editPersonalDataScreenBloc.state.getProfileState.profileEntity!.contract!.employeeId!,
                  personId: (_editPersonalDataScreenBloc.state.getPersonState as LoadedPersonState).personId,
                ),
              );

              Modular.to.pop(true);
              Modular.to.pop(true);

              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.success(
                  message: context.translate.personalDataSubmitted,
                ),
              );
            }

            if (state is ErrorUpdatePersonalDataState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  message: context.translate.alertErrorSubmit,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => _sendUpdatePersonalData(),
                  ),
                ),
              );
            }
          }),
        ),
        BlocListener<SearchNationalityBloc, SearchNationalityState>(
          bloc: _editPersonalDataScreenBloc.searchNationalityBloc,
          listener: ((context, state) {
            if (state is LoadedSelectNationalityState && state.selectedNationalityEntity != null) {
              nationality = state.selectedNationalityEntity!;
              _nationalityController.text = nationality.name!;
            }
          }),
        ),
        BlocListener<SearchNaturalityBloc, SearchNaturalityState>(
          bloc: _editPersonalDataScreenBloc.searchNaturalityBloc,
          listener: ((context, state) {
            if (state is LoadedSelectNaturalityState && state.selectedNaturalityEntity != null) {
              naturality = state.selectedNaturalityEntity!;
              _naturalityController.text = naturality.name!;
            }
          }),
        ),
        BlocListener(
          bloc: _editPersonalDataScreenBloc.getEducationDegreeBloc,
          listener: ((context, state) {
            if (state is LoadedSelectEducationDegreeState && state.selectedEducationDegreeEntity != null) {
              educationDegree = state.selectedEducationDegreeEntity!;
              _educationDegreeController.text = state.selectedEducationDegreeEntity!.id as String;
            }
          }),
        ),
        BlocListener<SearchEthnicityBloc, SearchEthnicityState>(
          bloc: _editPersonalDataScreenBloc.searchEthnicityBloc,
          listener: ((context, state) {
            if (state is LoadedSelectedEthnicityState && state.selectedEthnicityEntity != null) {
              ethnicityEntity = state.selectedEthnicityEntity!;
              _ethnicityController.text = ethnicityEntity.name ?? '';
            }
          }),
        ),
      ],
      child: BlocBuilder<EditPersonalDataScreenBloc, EditPersonalDataScreenState>(
        bloc: _editPersonalDataScreenBloc,
        builder: ((context, state) {
          final loadedPages = (state.getDisabilityState.disabilityList.isNotEmpty &&
              state.getNeedAttachmentEditState is LoadedNeedAttachmentEditState &&
              state.getEducationDegreeState.educationDegreeList.isNotEmpty);
          if (loadedPages) {
            needAttachment = (state.getNeedAttachmentEditState as LoadedNeedAttachmentEditState).needAttachmentEdit;
          }

          return WaapiPageViewWidget(
            titleScreen: context.translate.editPersonalData,
            labelTitleDialog: context.translate.alertCancelForm,
            labelGhostButtonDialog: context.translate.no,
            onPressedGhostButtonDialog: onPressedGhostButtonDialog,
            onPressedActionButtonDialog: onPressedActionButtonDialog,
            labelContentDialog: context.translate.alertCancelFormDescription,
            currentStep: currentStep,
            disableTopButton: disableTopButton(state),
            busyTopButton: busyTopButton(state),
            onPressedTopButton: onPressedTopButtom,
            labelTopButton: labelTopButom(context),
            labelActionButtonDialog: context.translate.yes,
            onPressedBottomButton: onPressedBottomButton,
            labelBottomButton: labelBottomButton(context),
            disableBottomButton: disableBottomButton(state),
            busyBottomButton: busyBottomButton(state),
            validationExitIncompleteAction: !(currentStep == 1 && _fullNameController.text.isNotEmpty),
            loadedPages: loadedPages,
            pageController: _pageController,
            listPagesViews: [
              InputPersonalDataScreen(
                dateOfBirthController: _dateOfBirthController,
                fullNameController: _fullNameController,
                nationalityController: _nationalityController,
                naturalityController: _naturalityController,
                genderController: _genderController,
                maritalStatusController: _maritalStatusController,
                educationDegreeController: _educationDegreeController,
                ethnicityController: _ethnicityController,
                educationDegreeEntity: educationDegree,
              ),
              SelectDisabilitiesScreen(
                currentDisabilities: loadedProfileDisabilities,
                rehabilited: rehabilited,
                onRehabilitedChanged: (status) {
                  setState(() {
                    rehabilited = status!;
                  });
                },
                onAddDisability: (disability) => loadedProfileDisabilities.add(disability),
                onRemoveDisability: (disability) => loadedProfileDisabilities.remove(disability),
              ),
              InputAttachmentsWidget(
                panelUploaderBloc: _waapiManagementPanelUploaderBloc,
                isRequiredAttachments: needAttachment,
                header: context.translate.receipts,
              ),
              InputNotesWidget(
                notesController: _notesController,
                trueInformation: trueInformation,
                onChangedTrueInformation: (status) {
                  setState(() {
                    trueInformation = status ?? false;
                  });
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  void onPressedGhostButtonDialog() {
    Modular.to.pop();
  }

  void onPressedActionButtonDialog() {
    Modular.to.pop();
    Modular.to.pop();
  }

  bool goNextPage() {
    if (currentStep == 1) {
      return validateInputs();
    }
    if (currentStep == 2) {
      return true;
    }
    if (currentStep == 3) {
      bool onlyEthnicityChanged = _ethnicityController.text != (_profileEntity.personEntity?.ethnicity?.name ?? '') &&
          _fullNameController.text == _profileEntity.name &&
          _dateOfBirthController.text ==
              DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: _profileEntity.personEntity!.birthDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Localizations.localeOf(context),
                ),
              ) &&
          _genderController.text == (_profileEntity.gender?.name.toUpperCase() ?? 'MALE') &&
          _maritalStatusController.text == (_profileEntity.maritalStatus?.name.toUpperCase() ?? 'SINGLE') &&
          _nationalityController.text == (_profileEntity.nationality?.name ?? '') &&
          _naturalityController.text == (_profileEntity.placeOfBirth?.name ?? '') &&
          _educationDegreeController.text == (_profileEntity.personEntity?.educationDegree?.id ?? '') &&
          _notesController.text.isEmpty;

      if (needAttachment) {
        if (onlyEthnicityChanged) {
          return true;
        }

        if (_waapiManagementPanelUploaderBloc.state.attachments.isNotEmpty) {
          return true;
        }

        return false;
      }

      return true;
    }
    return currentStep == 4 && trueInformation;
  }

  void onPressedTopButtom() {
    FocusScope.of(context).unfocus();
    if (currentStep < 4) {
      _pageController.nextPage(
        duration: kTabScrollDuration,
        curve: Curves.easeIn,
      );
      currentStep++;
      setState(() {});
      return;
    }

    _sendUpdatePersonalData();
  }

  String labelTopButom(BuildContext context) {
    return currentStep == 4 ? context.translate.saveAndSubmit : context.translate.next;
  }

  bool disableTopButton(EditPersonalDataScreenState state) {
    return !goNextPage() || state.updatePersonalDataState is LoadingUpdatePersonalDataState;
  }

  bool busyTopButton(EditPersonalDataScreenState state) {
    return state.updatePersonalDataState is LoadingUpdatePersonalDataState;
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

  String labelBottomButton(BuildContext context) {
    return currentStep > 1 ? context.translate.back : context.translate.optionCancel;
  }

  bool disableBottomButton(EditPersonalDataScreenState state) {
    return state.updatePersonalDataState is LoadingUpdatePersonalDataState;
  }

  bool busyBottomButton(EditPersonalDataScreenState state) {
    return state.updatePersonalDataState is LoadingUpdatePersonalDataState;
  }

  bool validateInputs() {
    return _fullNameController.text.isNotEmpty &&
        _dateOfBirthController.text.length == 10 &&
        _ethnicityController.text.isNotEmpty;
  }

  void _sendUpdatePersonalData() {
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

    final disabilities = loadedProfileDisabilities
        .map(
          (disability) => DisabilitiesModel(
            disability: DisabilityModel(
              id: disability.id,
              name: disability.name,
            ),
          ),
        )
        .toList();

    final finalDate = DateTimeHelper.formatToIso8601Date(
      dateTime: DateFormat.yMd(
        LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
      ).parse(_dateOfBirthController.text),
    );

    _editPersonalDataScreenBloc.updatePersonalDataBloc.add(
      SendUpdatePersonalDataEvent(
        editPersonalDataInputModel: EditPersonalDataInputModel(
          type: 'PERSONAL_DATA',
          personalDTO: EditPersonalDataPersonalDtoInputModel(
            birthday: finalDate,
            commentary: _notesController.text,
            gender: _genderController.text,
            maritalStatus: _maritalStatusController.text,
            name: _fullNameController.text,
            rehabilitation: rehabilited,
            isRealData: trueInformation,
            ethnicity: EthnicityModel(
              id: ethnicityEntity.id,
              name: ethnicityEntity.name,
              code: ethnicityEntity.code,
            ),
            nationality: NationalityModel(
              id: nationality.id,
              name: nationality.name,
              code: nationality.code,
            ),
            educationDegree: (educationDegree?.id != null)
                ? EducationDegreeModel(
                    id: educationDegree!.id,
                    name: educationDegree!.name,
                    type: educationDegree!.type,
                  )
                : null,
            placeOfBirth: CityModel(
              id: naturality.id,
              name: naturality.name,
              state: StateModel(
                id: naturality.state?.id,
                name: naturality.state?.name,
                abbreviation: naturality.state?.abbreviation,
                country: CountryModel(
                  id: naturality.state?.country?.id,
                  name: naturality.state?.country?.name,
                  abbreviation: naturality.state?.country?.abbreviation,
                ),
              ),
            ),
            disabilities: disabilities,
          ),
          commentary: _notesController.text,
          attachments: attachments,
        ),
      ),
    );
  }
}
