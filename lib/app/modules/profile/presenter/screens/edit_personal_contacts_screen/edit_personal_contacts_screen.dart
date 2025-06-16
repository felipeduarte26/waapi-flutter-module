import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/input_attachments_widget.dart';
import '../../../../../core/widgets/input_notes_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../../../attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/email_entity.dart';
import '../../../domain/entities/phone_contact_entity.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/entities/social_network_entity.dart';
import '../../../domain/input_models/attachments_input_model.dart';
import '../../../domain/input_models/edit_personal_contact_dto_input_model.dart';
import '../../../domain/input_models/edit_personal_contact_email_input_model.dart';
import '../../../domain/input_models/edit_personal_contact_input_model.dart';
import '../../../domain/input_models/edit_personal_contact_phone_input_model.dart';
import '../../../domain/input_models/edit_personal_contact_social_network_input_model.dart';
import '../../../enums/email_type_enum.dart';
import '../../../enums/phone_contact_type_enum.dart';
import '../../../infra/models/phone_contact_model.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_event.dart';
import '../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../blocs/person_bloc/person_state.dart';
import '../../blocs/profile_bloc/profile_event.dart';
import '../../blocs/update_personal_contact_bloc/update_personal_contact_bloc.dart';
import '../../blocs/update_personal_contact_bloc/update_personal_contact_event.dart';
import '../../blocs/update_personal_contact_bloc/update_personal_contact_state.dart';
import '../../string_formatters/enum_social_network_provider_string_formatter.dart';
import 'bloc/edit_personal_contact_screen_bloc.dart';
import 'bloc/edit_personal_contact_screen_state.dart';
import 'components/input_personal_contacts_emails_screen.dart';
import 'components/input_personal_contacts_phones_screen.dart';
import 'components/input_personal_contacts_social_networks_screen.dart';

class EditPersonalContactsScreen extends StatefulWidget {
  const EditPersonalContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPersonalContactsScreen> createState() {
    return _EditPersonalContactsScreenState();
  }
}

class _EditPersonalContactsScreenState extends State<EditPersonalContactsScreen> {
  var currentStep = 1;
  late final PageController _pageController;
  late final EditPersonalContactScreenBloc _editPersonalContactScreenBloc;
  late final WaapiManagementPanelUploaderBloc _waapiManagementPanelUploaderBloc;

  late ProfileEntity profileEntity;
  late final String personId;
  late final String employeeId;

  final TextEditingController _notesController = TextEditingController();

  bool trueInformation = false;
  bool needAttachment = false;
  bool allowToUpdateContactEmployeeEmail = false;

  List<ContactEntity<SocialNetworkEntity>> socialNetworksContacts = [];
  List<ContactEntity<EmailEntity>> emailsContacts = [];
  List<ContactEntity<PhoneContactEntity>> phoneContacts = [];

  final List<EditPersonalContactPhoneInputModel> personalPhonesInputModels = [];
  final List<EditPersonalContactPhoneInputModel> professionalPhonesInputModels = [];
  final List<EditPersonalContactEmailInputModel> personalEmailsInputModels = [];
  final List<EditPersonalContactEmailInputModel> professionalEmailsInputModels = [];
  final List<EditPersonalContactSocialNetworkInputModel> socialNetworksInputModels = [];

  @override
  void initState() {
    super.initState();
    _waapiManagementPanelUploaderBloc = Modular.get<WaapiManagementPanelUploaderBloc>();
    _editPersonalContactScreenBloc = Modular.get<EditPersonalContactScreenBloc>();
    _pageController = PageController();

    if (_editPersonalContactScreenBloc.getNeedAttachmentEditBloc.state is! LoadedNeedAttachmentEditState) {
      _editPersonalContactScreenBloc.getNeedAttachmentEditBloc.add(
        const GetNeedAttachmentEditEvent(
          role: 'CONTACT',
        ),
      );
    }

    profileEntity = _editPersonalContactScreenBloc.getProfileBloc.state.profileEntity!;

    employeeId = profileEntity.contract!.employeeId!;

    personId = (_editPersonalContactScreenBloc.state.getPersonState as LoadedPersonState).personId;

    allowToUpdateContactEmployeeEmail =
        (_editPersonalContactScreenBloc.state.getAuthorizationState as LoadedAuthorizationState)
            .authorizationEntity
            .allowToUpdateContactProfessionalEmail;

    final socialNetworks = profileEntity.socialNetworks ?? [];

    socialNetworksContacts = socialNetworks
        .map(
          (e) => ContactEntity<SocialNetworkEntity>(
            content: e,
          ),
        )
        .toList();

    final emails = [
      ...profileEntity.emails ?? [],
      ...profileEntity.contract?.emails ?? [],
    ];

    emailsContacts = emails
        .map(
          (e) => ContactEntity<EmailEntity>(
            content: e,
          ),
        )
        .toList();

    final phones = profileEntity.contacts ?? [];

    phoneContacts = phones
        .map(
          (e) => ContactEntity<PhoneContactEntity>(
            content: e,
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<WaapiManagementPanelUploaderBloc>();
    _notesController.dispose();
  }

  bool openModal = false;

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);

    bool isNextEnabled() {
      if (currentStep < 4) {
        return true;
      }
      if (currentStep == 4) {
        return needAttachment ? _waapiManagementPanelUploaderBloc.state.attachments.isNotEmpty : true;
      }
      return currentStep == 5 && trueInformation;
    }

    void onWillPop() {
      if (openModal) return;
      if (currentStep != 1) {
        openModal = true;
        showDialog(
          barrierDismissible: false,
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return SeniorModal(
              title: context.translate.alertCancelForm,
              content: context.translate.alertCancelFormDescription,
              defaultAction: SeniorModalAction(
                label: context.translate.close,
                action: () {
                  openModal = false;
                  Modular.to.pop();
                },
              ),
              otherAction: SeniorModalAction(
                label: context.translate.confirm,
                action: () {
                  Modular.to.pop();
                  Modular.to.pop();
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
          titleLabel: context.translate.editContacts,
          body: BlocBuilder<EditPersonalContactScreenBloc, EditPersonalContactScreenState>(
            bloc: _editPersonalContactScreenBloc,
            builder: (context, state) {
              final loaded = state.getNeedAttachmentEditState is LoadedNeedAttachmentEditState;

              if (loaded) {
                needAttachment = (state.getNeedAttachmentEditState as LoadedNeedAttachmentEditState).needAttachmentEdit;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                      child: SeniorStepper(
                        steps: 5,
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
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        children: [
                          InputPersonalContactsPhonesScreen(
                            phones: phoneContacts,
                            onInsertPhone: (value) {
                              phoneContacts.add(value);
                              setState(() {});
                            },
                            onDeletePhone: (oldContact) {
                              phoneContacts.remove(oldContact);

                              if (oldContact.content.type == PhoneContactTypeEnum.professional) {
                                professionalPhonesInputModels.add(
                                  EditPersonalContactPhoneInputModel(
                                    phoneContact: PhoneContactModel(
                                      id: oldContact.content.id,
                                      countryCode: oldContact.content.countryCode,
                                      localCode: oldContact.content.localCode,
                                      number: oldContact.content.number,
                                      branch: oldContact.content.branch,
                                      provider: oldContact.content.provider,
                                      type: oldContact.content.type,
                                      personRequestUpdateType: 'DELETE',
                                    ),
                                  ),
                                );
                              } else {
                                personalPhonesInputModels.add(
                                  EditPersonalContactPhoneInputModel(
                                    phoneContact: PhoneContactModel(
                                      id: oldContact.content.id,
                                      countryCode: oldContact.content.countryCode,
                                      localCode: oldContact.content.localCode,
                                      number: oldContact.content.number,
                                      branch: oldContact.content.branch,
                                      provider: oldContact.content.provider,
                                      type: oldContact.content.type,
                                      personRequestUpdateType: 'DELETE',
                                    ),
                                  ),
                                );
                              }

                              setState(() {});
                            },
                            onEditPhone: (newContact, oldContact) {
                              final index = phoneContacts.indexWhere((contact) => contact == oldContact);
                              phoneContacts[index] = newContact;

                              setState(() {});
                            },
                          ),
                          InputPersonalContactsEmailsScreen(
                            allowToUpdateContactEmployeeEmail: allowToUpdateContactEmployeeEmail,
                            emails: emailsContacts,
                            onInsertEmail: (value) {
                              emailsContacts.add(value);
                              setState(() {});
                            },
                            onDeleteEmail: (oldContact) {
                              emailsContacts.remove(oldContact);

                              if (oldContact.content.type != EmailTypeEnum.personal) {
                                professionalEmailsInputModels.add(
                                  EditPersonalContactEmailInputModel(
                                    email: oldContact.content.email!,
                                    id: oldContact.content.id,
                                    originalType: 'PROFESSIONAL',
                                    type: 'PROFESSIONAL',
                                    personRequestUpdateType: 'DELETE',
                                  ),
                                );
                              } else {
                                personalEmailsInputModels.add(
                                  EditPersonalContactEmailInputModel(
                                    email: oldContact.content.email!,
                                    id: oldContact.content.id,
                                    originalType: 'PERSONAL',
                                    type: 'PERSONAL',
                                    personRequestUpdateType: 'DELETE',
                                  ),
                                );
                              }

                              setState(() {});
                            },
                            onEditEmail: (newContact, oldContact) {
                              final index = emailsContacts.indexWhere((contact) => contact == oldContact);

                              if (oldContact.content.type != newContact.content.type) {
                                if (newContact.content.type != EmailTypeEnum.personal) {
                                  personalEmailsInputModels.add(
                                    EditPersonalContactEmailInputModel(
                                      email: oldContact.content.email!,
                                      id: oldContact.content.id,
                                      originalType: 'PERSONAL',
                                      type: 'PROFESSIONAL',
                                      personRequestUpdateType: 'DELETE',
                                    ),
                                  );

                                  final ContactEntity<EmailEntity> contact = ContactEntity(
                                    typeEdit: 'CREATE',
                                    content: EmailEntity(
                                      email: newContact.content.email,
                                      type: EmailTypeEnum.professional,
                                    ),
                                  );

                                  emailsContacts[index] = contact;
                                } else {
                                  professionalEmailsInputModels.add(
                                    EditPersonalContactEmailInputModel(
                                      email: oldContact.content.email!,
                                      id: oldContact.content.id,
                                      originalType: 'PROFESSIONAL',
                                      type: 'PERSONAL',
                                      personRequestUpdateType: 'DELETE',
                                    ),
                                  );

                                  final ContactEntity<EmailEntity> contact = ContactEntity(
                                    typeEdit: 'CREATE',
                                    content: EmailEntity(
                                      email: newContact.content.email,
                                      type: EmailTypeEnum.personal,
                                    ),
                                  );

                                  emailsContacts[index] = contact;
                                }
                              } else {
                                emailsContacts[index] = newContact;
                              }
                              setState(() {});
                            },
                          ),
                          InputPersonalContactsSocialNetworksScreen(
                            socialNetworksContacts: socialNetworksContacts,
                            onInsertSocialNetwork: (value) {
                              socialNetworksContacts.add(value);
                              setState(() {});
                            },
                            onDeleteSocialNetwork: (oldContact) {
                              socialNetworksContacts.remove(oldContact);

                              socialNetworksInputModels.add(
                                EditPersonalContactSocialNetworkInputModel(
                                  id: oldContact.content.id,
                                  personId: personId,
                                  profile: oldContact.content.profile!,
                                  socialNetwork: EnumHelper().enumToString(
                                    enumToParse: oldContact.content.socialNetwork,
                                  ),
                                  socialNetworkName: EnumHelper().enumToString(
                                    enumToParse: oldContact.content.socialNetwork,
                                  ),
                                  personRequestUpdateType: 'DELETE',
                                ),
                              );

                              setState(() {});
                            },
                            onEditSocialNetwork: (newContact, oldContact) {
                              final index = socialNetworksContacts.indexWhere((contact) => contact == oldContact);
                              socialNetworksContacts[index] = newContact;

                              setState(() {});
                            },
                          ),
                          InputAttachmentsWidget(
                            header: context.translate.receipts,
                            panelUploaderBloc: _waapiManagementPanelUploaderBloc,
                            isRequiredAttachments: needAttachment,
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
                      ),
                    ),
                    MultiBlocListener(
                      listeners: [
                        BlocListener<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
                          bloc: _waapiManagementPanelUploaderBloc,
                          listener: (context, state) {
                            if (state is InitialPanelUploaderState) {
                              setState(() {
                                isNextEnabled();
                              });
                            }
                          },
                        ),
                        BlocListener<UpdatePersonalContactBloc, UpdatePersonalContactState>(
                          bloc: _editPersonalContactScreenBloc.updatePersonalContactBloc,
                          listener: ((context, state) {
                            if (state is SentUpdatePersonalContactState &&
                                _editPersonalContactScreenBloc.state.getPersonState is LoadedPersonState) {
                              _editPersonalContactScreenBloc.getProfileBloc.add(
                                GetProfileEvent(
                                  employeeId: _editPersonalContactScreenBloc
                                      .state.getProfileState.profileEntity!.contract!.employeeId!,
                                  personId: personId,
                                ),
                              );

                              Modular.to.pop(true);
                              Modular.to.pop(true);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SeniorSnackBar.success(
                                  message: context.translate.personalContactsSubmitted,
                                ),
                              );
                            }

                            if (state is ErrorUpdatePersonalContactState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SeniorSnackBar.error(
                                  message: context.translate.alertErrorSubmit,
                                  action: SeniorSnackBarAction(
                                    label: context.translate.repeat,
                                    onPressed: () => sendUpdatePersonalContact(
                                      isRepeat: true,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ],
                      child: EmployeeBottomSheetWidget(
                        horizontalPadding: true,
                        seniorButtons: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: SeniorSpacing.normal,
                            ),
                            child: SeniorButton(
                              disabled: !isNextEnabled() ||
                                  state.updatePersonalContactState is LoadingUpdatePersonalContactState,
                              busy: state.updatePersonalContactState is LoadingUpdatePersonalContactState,
                              fullWidth: true,
                              label: currentStep == 5 ? context.translate.saveAndSubmit : context.translate.next,
                              onPressed: () {
                                if (currentStep == 5 && trueInformation) {
                                  sendUpdatePersonalContact();
                                }
                                FocusScope.of(context).unfocus();

                                if (currentStep < 5) {
                                  _pageController.nextPage(
                                    duration: kTabScrollDuration,
                                    curve: Curves.easeIn,
                                  );
                                  currentStep++;
                                  setState(() {});
                                  return;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: SeniorSpacing.normal,
                            ),
                            child: SeniorButton.ghost(
                              disabled: state.updatePersonalContactState is LoadingUpdatePersonalContactState,
                              fullWidth: true,
                              label: currentStep > 1 ? context.translate.back : context.translate.optionCancel,
                              onPressed: () {
                                if (currentStep > 1) {
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
                      ),
                    ),
                  ],
                );
              }

              return const Center(
                child: WaapiLoadingWidget(
                  key: Key('edit_persona_data_screen-loading_state'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void sendUpdatePersonalContact({bool isRepeat = false}) {
    List<AttachmentsInputModel>? attachments;

    if (!isRepeat) {
      attachments = _waapiManagementPanelUploaderBloc.state.attachments
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

      for (var phones in phoneContacts) {
        if (phones.content.type == PhoneContactTypeEnum.professional) {
          professionalPhonesInputModels.add(
            EditPersonalContactPhoneInputModel(
              phoneContact: PhoneContactModel(
                id: phones.content.id,
                countryCode: phones.content.countryCode,
                localCode: phones.content.localCode,
                number: phones.content.number,
                branch: phones.content.branch,
                provider: phones.content.provider,
                type: phones.content.type,
                personRequestUpdateType: phones.typeEdit,
              ),
              originalType: 'PROFESSIONAL',
              type: 'PROFESSIONAL',
            ),
          );
        } else {
          personalPhonesInputModels.add(
            EditPersonalContactPhoneInputModel(
              phoneContact: PhoneContactModel(
                id: phones.content.id,
                countryCode: phones.content.countryCode,
                localCode: phones.content.localCode,
                number: phones.content.number,
                branch: phones.content.branch,
                provider: phones.content.provider,
                type: phones.content.type,
                personRequestUpdateType: phones.typeEdit,
              ),
              originalType: 'PERSONAL',
              type: 'PERSONAL',
            ),
          );
        }
      }

      for (var emails in emailsContacts) {
        if (emails.content.type != EmailTypeEnum.personal) {
          professionalEmailsInputModels.add(
            EditPersonalContactEmailInputModel(
              email: emails.content.email!,
              id: emails.content.id,
              originalType: EnumHelper().enumToString(
                enumToParse: emails.content.type ?? EmailTypeEnum.professional,
              ),
              type: 'PROFESSIONAL',
              personRequestUpdateType: emails.typeEdit,
            ),
          );
        } else {
          personalEmailsInputModels.add(
            EditPersonalContactEmailInputModel(
              email: emails.content.email!,
              id: emails.content.id,
              originalType: EnumHelper().enumToString(
                enumToParse: emails.content.type ?? EmailTypeEnum.personal,
              ),
              type: 'PERSONAL',
              personRequestUpdateType: emails.typeEdit,
            ),
          );
        }
      }

      for (var socialNetwork in socialNetworksContacts) {
        socialNetworksInputModels.add(
          EditPersonalContactSocialNetworkInputModel(
            id: socialNetwork.content.id,
            personId: personId,
            profile: socialNetwork.content.profile!,
            socialNetwork: EnumHelper().enumToString(
              enumToParse: socialNetwork.content.socialNetwork,
            ),
            socialNetworkName: EnumSocialNetworkProviderStringFormatter.getStringSocialNetwork(
              socialNetworkProviderEnum: socialNetwork.content.socialNetwork!,
              appLocalizations: context.translate,
            ),
            personRequestUpdateType: socialNetwork.typeEdit,
          ),
        );
      }
    }

    _editPersonalContactScreenBloc.updatePersonalContactBloc.add(
      SendUpdatePersonalContactEvent(
        editPersonalContactInputModel: EditPersonalContactInputModel(
          type: 'CONTACT',
          contactDTO: EditPersonalContactDtoInputModel(
            employeeId: employeeId,
            commentary: _notesController.text,
            isRealData: trueInformation,
            personPhone: personalPhonesInputModels,
            employeePhone: professionalPhonesInputModels,
            employeeEmail: professionalEmailsInputModels,
            personEmail: personalEmailsInputModels,
            socialNetworks: socialNetworksInputModels,
          ),
          commentary: _notesController.text,
          attachments: attachments,
        ),
      ),
    );
  }
}
