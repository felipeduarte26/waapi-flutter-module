import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/emergencial_contact_entity.dart';
import '../../../../domain/input_models/emergencial_contact_input_model.dart';
import '../../../../domain/input_models/phone_contact_input_model.dart';
import '../../../../enums/gender_type_enum.dart';
import '../../../../enums/personal_relationship_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../string_formatters/enum_personal_relationship_string_formatter.dart';
import '../bloc/emergencial_contacts_bloc.dart';
import '../bloc/emergencial_contacts_event.dart';
import '../bloc/emergencial_contacts_state.dart';

class EmergencialContactDetailsScreen extends StatefulWidget {
  final EmergencialContactEntity? emergencialContactEntity;

  const EmergencialContactDetailsScreen({
    Key? key,
    this.emergencialContactEntity,
  }) : super(key: key);

  @override
  State<EmergencialContactDetailsScreen> createState() {
    return _EmergencialContactDetailsScreenState();
  }
}

class _EmergencialContactDetailsScreenState extends State<EmergencialContactDetailsScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _localCodeController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  GenderTypeEnum? onSelectedGender;
  PersonalRelationshipEnum? onSelectedRelationship;
  late final EmergencialContactsBloc emergencialContactsBloc;
  late final AuthorizationBloc _authorizationBloc;
  late final AuthorizationEntity? _authEntity;
  bool openModal = false;

  @override
  void initState() {
    super.initState();
    emergencialContactsBloc = Modular.get<EmergencialContactsBloc>();
    _authorizationBloc = Modular.get<AuthorizationBloc>();
    _authEntity = (_authorizationBloc.state is LoadedAuthorizationState)
        ? (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity
        : null;

    _fullNameController.addListener(() {
      setState(() {});
    });
    _branchController.addListener(() {
      setState(() {});
    });
    _localCodeController.addListener(() {
      setState(() {});
    });
    _countryCodeController.addListener(() {
      setState(() {});
    });
    _phoneNumberController.addListener(() {
      setState(() {});
    });
    _providerController.addListener(() {
      setState(() {});
    });
    if (widget.emergencialContactEntity != null) {
      startsEmergencialContact();
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _branchController.dispose();
    _localCodeController.dispose();
    _countryCodeController.dispose();
    _phoneNumberController.dispose();
    _providerController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDarkMode = themeRepository.isDarkTheme();
    final dropdownTheme = themeRepository.isCustomTheme() ? null : WaapiStyleTheme.waapiSeniorDropdownButtonStyle();
    bool isValidatedButton() {
      return _fullNameController.text.isNotEmpty;
    }

    void onWillPop() {
      if (openModal) return;
      openModal = true;
      showDialog(
        barrierDismissible: false,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return SeniorModal(
            title: context.translate.doYouWantToCancelFillingInThisForm,
            content: context.translate.ifYouConfirmYouWillLoseTheInformationFilledInThisForm,
            defaultAction: SeniorModalAction(
              label: context.translate.close,
              action: () {
                openModal = false;
                Modular.to.pop();
              },
            ),
            otherAction: SeniorModalAction(
              busy: isDisable(emergencialContactsBloc.state),
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
    }

    return BlocConsumer<EmergencialContactsBloc, EmergencialContactsState>(
      bloc: emergencialContactsBloc,
      listener: (context, state) {
        if (state is SendDeletionErrorEmergencialContactsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.couldNotDeleteContactTryAgainLater,
            ),
          );
          Modular.to.pop(true);
        }
        if (state is ErrorEmergencialContactsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.anErrorOccurredWhenSubmittingTheFormTapRetryToTryAgain,
              action: SeniorSnackBarAction(
                label: context.translate.repeat,
                onPressed: () async {
                  if (widget.emergencialContactEntity == null) {
                    await sendEmergencialContact();
                  } else {
                    await sendUpdateEmergencialContact();
                  }
                },
              ),
            ),
          );
        }
        if (state is LoadedEmergencialContactsState) {
          Modular.to.pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: context.translate.emergencyContactSuccessfullyAdded,
            ),
          );
        }
        if (state is DeletionEmergencialContactsState) {
          Modular.to.pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: context.translate.emergencyContactHasBeenDeleted,
            ),
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (_, __) async => onWillPop(),
          child: Scaffold(
            body: WaapiColorfulHeader(
              onTapBack: () {
                if (state is LoadedEmergencialContactsState ||
                    state is InitialEmergencialContactsState ||
                    state is ErrorEmergencialContactsState) {
                  onWillPop();
                }
              },
              hasTopPadding: true,
              titleLabel: context.translate.addEmergencyContact,
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SeniorSpacing.normal,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SeniorText.body(
                                  ' * ',
                                  color: SeniorColors.neutralColor600,
                                ),
                                SeniorText.body(
                                  context.translate.mandatoryItem,
                                  color: SeniorColors.neutralColor600,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SeniorSpacing.normal,
                            ),
                            SeniorTextField(
                              helper: context.translate.enterTheFullNameOfTheEmergencyContact,
                              label: '${context.translate.fullName} *',
                              hintText: context.translate.fullName,
                              controller: _fullNameController,
                              maxLength: 255,
                              disabled:
                                  !(_authEntity?.allowToUpdateEmergencyContactPhoneName ?? true) || isDisable(state),
                              style: SeniorTextFieldStyle(
                                hintTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                              ),
                            ),
                            const SizedBox(
                              height: SeniorSpacing.xsmall,
                            ),
                            SeniorDropdownButton(
                              disabled:
                                  !(_authEntity?.allowToUpdateEmergencyContactPhoneGender ?? true) || isDisable(state),
                              value: onSelectedGender,
                              items: DropdownItemListEnum<GenderTypeEnum>().dropdownItemList(
                                values: GenderTypeEnum.values,
                                title: (genderTypeEnum) => genderTypeEnum.nameTranslate(
                                  context.translate,
                                ),
                              ),
                              onSelected: (genderTypeEnum) {
                                setState(() {});
                                onSelectedGender = genderTypeEnum;
                              },
                              label: context.translate.gender,
                              showUnderline: true,
                              style: dropdownTheme,
                            ),
                            const SizedBox(
                              height: SeniorSpacing.normal,
                            ),
                            SeniorDropdownButton(
                              disabled:
                                  !(_authEntity?.allowToUpdateEmergencyContactPhoneKinship ?? true) || isDisable(state),
                              items: DropdownItemListEnum<PersonalRelationshipEnum>().dropdownItemList(
                                values: PersonalRelationshipEnum.values,
                                title: (personalRelationshipEnum) =>
                                    EnumPersonalRelationshipStringFormatter.personalRelationshipEnumToValue(
                                  personalRelationshipEnum: personalRelationshipEnum,
                                  appLocalizations: context.translate,
                                ),
                              ),
                              label: context.translate.degreeOfKinship,
                              value: onSelectedRelationship,
                              showUnderline: true,
                              onSelected: (value) {
                                setState(() {});
                                onSelectedRelationship = value;
                              },
                              style: dropdownTheme,
                            ),
                            const SizedBox(
                              height: SeniorSpacing.normal,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: SeniorTextField(
                                    disabled: !(_authEntity?.allowToUpdateEmergencyContactPhoneDDI ?? true) ||
                                        isDisable(state),
                                    controller: _countryCodeController,
                                    label: context.translate.ddi,
                                    keyboardType: const TextInputType.numberWithOptions(
                                      signed: true,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      SeniorMaskTextInputHelper(
                                        mask: '+##',
                                        filter: {'#': RegExp(r'[0-9]')},
                                        type: SeniorMaskAutoCompletionType.lazy,
                                      ),
                                    ],
                                    style: SeniorTextFieldStyle(
                                      hintTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: SeniorSpacing.normal,
                                  ),
                                  child: SizedBox(
                                    width: 70,
                                    child: SeniorTextField(
                                      style: SeniorTextFieldStyle(
                                        hintTextColor:
                                            isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                                      ),
                                      disabled: !(_authEntity?.allowToUpdateEmergencyContactPhoneDDD ?? true) ||
                                          isDisable(state),
                                      controller: _localCodeController,
                                      label: context.translate.ddd,
                                      keyboardType: const TextInputType.numberWithOptions(
                                        signed: true,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      maxLength: 3,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SeniorTextField(
                                    style: SeniorTextFieldStyle(
                                      hintTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                                    ),
                                    disabled: !(_authEntity?.allowToUpdateEmergencyContactPhoneNumber ?? true) ||
                                        isDisable(state),
                                    keyboardType: const TextInputType.numberWithOptions(
                                      signed: true,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      SeniorMaskTextInputHelper(
                                        mask: ' #####-####',
                                        filter: {'#': RegExp(r'[0-9]')},
                                        type: SeniorMaskAutoCompletionType.lazy,
                                      ),
                                    ],
                                    controller: _phoneNumberController,
                                    label: context.translate.phoneNumber,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: SeniorSpacing.xsmall,
                              ),
                              child: SeniorTextField(
                                style: SeniorTextFieldStyle(
                                  hintTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                                ),
                                disabled: !(_authEntity?.allowToUpdateEmergencyContactPhoneExtension ?? true) ||
                                    isDisable(state),
                                keyboardType: const TextInputType.numberWithOptions(
                                  signed: true,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: _branchController,
                                label: context.translate.extension,
                              ),
                            ),
                            SeniorTextField(
                              style: SeniorTextFieldStyle(
                                hintTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                              ),
                              disabled: !(_authEntity?.allowToUpdateEmergencyContactPhoneProvider ?? true) ||
                                  isDisable(state),
                              controller: _providerController,
                              label: context.translate.operator,
                              textInputAction: TextInputAction.done,
                            ),
                            Visibility(
                              visible: widget.emergencialContactEntity != null,
                              child: SeniorButton(
                                outlined: true,
                                style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                                disabled: isDisable(state),
                                busy: state is DeletingEmergencialContactsState,
                                fullWidth: true,
                                label: context.translate.deleteContact,
                                onPressed: () async {
                                  await sendDeletionEmergencialContact();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  EmployeeBottomSheetWidget(
                    horizontalPadding: true,
                    seniorButtons: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: SeniorSpacing.normal,
                        ),
                        child: SeniorButton(
                          disabled: !isValidatedButton() || isDisable(state),
                          busy: state is LoadingEmergencialContactsState,
                          fullWidth: true,
                          label: context.translate.save,
                          onPressed: () {
                            if (widget.emergencialContactEntity != null) {
                              sendUpdateEmergencialContact();
                            } else {
                              sendEmergencialContact();
                            }
                          },
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

  bool isDisable(EmergencialContactsState state) {
    return (state is LoadingEmergencialContactsState || state is DeletingEmergencialContactsState);
  }

  void startsEmergencialContact() {
    if (widget.emergencialContactEntity?.name != null && widget.emergencialContactEntity!.name!.isNotEmpty) {
      _fullNameController.text = widget.emergencialContactEntity!.name!;
    }
    if (widget.emergencialContactEntity?.relationship != null) {
      onSelectedRelationship = widget.emergencialContactEntity!.relationship!;
    }
    if (widget.emergencialContactEntity?.genderType != null) {
      onSelectedGender = widget.emergencialContactEntity!.genderType!;
    }
    if (widget.emergencialContactEntity?.phoneContact != null) {
      if (widget.emergencialContactEntity?.phoneContact!.countryCode != null) {
        String countryCode = widget.emergencialContactEntity!.phoneContact!.countryCode!.toString().trim();
        _countryCodeController.text = countryCode.replaceAll(
          countryCode,
          '+$countryCode',
        );
      }
      if (widget.emergencialContactEntity?.phoneContact?.localCode != null) {
        _localCodeController.text = widget.emergencialContactEntity!.phoneContact!.localCode!.toString().trim();
      }
      if (widget.emergencialContactEntity?.phoneContact?.number != null) {
        String phoneNumber = widget.emergencialContactEntity!.phoneContact!.number!.toString().trim();
        if (widget.emergencialContactEntity!.phoneContact!.number!.toString().length > 5) {
          _phoneNumberController.text =
              '${phoneNumber.substring(0, 5)}-${phoneNumber.substring(5, phoneNumber.length)}';
        }
      }
      if (widget.emergencialContactEntity?.phoneContact?.branch != null) {
        _branchController.text = widget.emergencialContactEntity!.phoneContact!.branch!;
      }
      if (widget.emergencialContactEntity?.phoneContact?.provider != null) {
        _providerController.text = widget.emergencialContactEntity!.phoneContact!.provider!;
      }
    }
  }

  Future<void> sendEmergencialContact() async {
    emergencialContactsBloc.add(
      SendEmergencialContactsEvent(
        emergencialContactInputModel: EmergencialContactInputModel(
          name: _fullNameController.text.trim(),
          emergencialContactRelationshipEnum: onSelectedRelationship,
          genderTypeEnum: onSelectedGender,
          phoneContactInputModel: PhoneContactInputModel(
            branch: _branchController.text.trim(),
            countryCode: _countryCodeController.text.replaceAll('+', '').trim(),
            localCode: _localCodeController.text.trim(),
            number: _phoneNumberController.text.replaceAll('-', '').trim(),
            provider: _providerController.text.trim(),
          ),
        ),
      ),
    );
  }

  Future<void> sendUpdateEmergencialContact() async {
    emergencialContactsBloc.add(
      SendUpdateEmergencialContactsEvent(
        emergencialContactId: widget.emergencialContactEntity!.id!,
        emergencialContactInputModel: EmergencialContactInputModel(
          name: _fullNameController.text.trim(),
          emergencialContactRelationshipEnum: onSelectedRelationship,
          genderTypeEnum: onSelectedGender,
          phoneContactInputModel: PhoneContactInputModel(
            branch: _branchController.text.trim(),
            countryCode: _countryCodeController.text.replaceAll('+', '').trim(),
            localCode: _localCodeController.text.trim(),
            number: _phoneNumberController.text.replaceAll('-', '').trim(),
            provider: _providerController.text.trim(),
          ),
        ),
      ),
    );
  }

  Future<void> sendDeletionEmergencialContact() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteEmergencyContact,
          content: context.translate.ifYouConfirmOuWillLoseTheInformationFilledInThisForm,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () {
              Modular.to.pop();
            },
          ),
          otherAction: SeniorModalAction(
            busy: emergencialContactsBloc.state is LoadingEmergencialContactsState,
            label: context.translate.delete,
            action: () {
              emergencialContactsBloc.add(
                SendDeletionEmergencialContactEvent(
                  idEmergencialContact: widget.emergencialContactEntity!.id!,
                ),
              );
              Modular.to.pop(true);
            },
            danger: true,
          ),
        );
      },
    );
  }
}
