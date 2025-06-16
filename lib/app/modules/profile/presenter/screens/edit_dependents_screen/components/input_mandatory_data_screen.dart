import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../enums/gender_type_enum.dart';
import '../../../../enums/marital_status_enum.dart';
import '../../../../enums/personal_relationship_enum.dart';
import '../../../../helper/cpf_validator_help.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/options_select_bottom_sheet.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../blocs/education_degree_bloc/education_degree_event.dart';
import '../../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../string_formatters/enum_marital_status_string_formatter.dart';
import '../../../string_formatters/enum_personal_relationship_string_formatter.dart';
import '../bloc/edit_dependents_screen_bloc.dart';
import '../bloc/edit_dependents_screen_state.dart';
import '../edit_dependents_controller.dart';

class InputMandatoryDataScreen extends StatefulWidget {
  final EditDependentsController editDependentsController;
  final VoidCallback onValueChanged;
  final bool enableDependentIncomeTax;
  final String cpfHolder;
  final String nameHolder;

  const InputMandatoryDataScreen({
    Key? key,
    required this.editDependentsController,
    required this.onValueChanged,
    required this.enableDependentIncomeTax,
    required this.cpfHolder,
    required this.nameHolder,
  }) : super(key: key);

  @override
  State<InputMandatoryDataScreen> createState() => _InputMandatoryDataScreenState();
}

class _InputMandatoryDataScreenState extends State<InputMandatoryDataScreen> {
  late EditDependentsScreenBloc _editDependentsDataScreenBloc;
  List<SeniorDropdownButtonItem> educationLevelItems = [];
  bool validateOnChange = false;
  var numberCpfFocus = FocusNode();
  var dateOfBirthFocus = FocusNode();
  var fullnameFocus = FocusNode();
  var liveBirthDeclarationNode = FocusNode();
  var mothersNameFocus = FocusNode();
  var cityOfBirthFocus = FocusNode();

  @override
  void initState() {
    _editDependentsDataScreenBloc = Modular.get<EditDependentsScreenBloc>();
    if (_editDependentsDataScreenBloc.educationDegreeBloc.state.educationDegreeList.isNotEmpty) {
      for (var educationDegree in _editDependentsDataScreenBloc.educationDegreeBloc.state.educationDegreeList) {
        educationLevelItems.add(
          SeniorDropdownButtonItem(
            value: educationDegree.id,
            title: educationDegree.name!,
          ),
        );
      }
    }
    fullnameFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final textFieldStyle = themeRepository.isCustomTheme() ? null : WaapiStyleTheme.waapiSeniorTextFieldStyle();
    final dropdownStyle = themeRepository.isCustomTheme() ? null : WaapiStyleTheme.waapiSeniorDropdownButtonStyle();

    return BlocConsumer<EditDependentsScreenBloc, EditDependentsScreenState>(
      listener: (context, state) {
        if (state.searchNaturalityState is LoadedSelectNaturalityState &&
            state.searchNaturalityState.selectedNaturalityEntity != null) {
          widget.editDependentsController.cityController.text =
              state.searchNaturalityState.selectedNaturalityEntity!.name ?? '';
          widget.editDependentsController.cityIdController.text =
              state.searchNaturalityState.selectedNaturalityEntity!.id ?? '';
          widget.editDependentsController.naturalityController.text =
              widget.editDependentsController.cityController.text;
        }

        if (state.getEducationDegreeState is LoadedSelectEducationDegreeState &&
            state.getEducationDegreeState.selectedEducationDegreeEntity != null) {
          widget.editDependentsController.educationDegree =
              state.getEducationDegreeState.selectedEducationDegreeEntity!;
        }
      },
      bloc: _editDependentsDataScreenBloc,
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorText.h4(
                    context.translate.dependentsPersonalData,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorText.body(
                    '* ${context.translate.mandatoryItem}',
                    color: SeniorColors.neutralColor600,
                  ),
                ),
                SeniorTextField(
                  onFieldSubmitted: (p0) {
                    numberCpfFocus.requestFocus();
                  },
                  onChanged: (_) {
                    widget.onValueChanged();
                  },
                  focusNode: fullnameFocus,
                  maxLength: 40,
                  counterText: context.translate.characters,
                  showCounterText: true,
                  controller: widget.editDependentsController.fullNameController,
                  label: '${context.translate.fullName} *',
                  style: textFieldStyle,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return context.translate.enterFullName;
                  },
                ),
                SeniorTextField(
                  onChanged: (value) {
                    final cpf = value.replaceAll('.', '').replaceAll('-', '');
                    if (cpf.isNotEmpty && cpf.length == 11 && widget.cpfHolder.isNotEmpty) {
                      if (cpf == widget.cpfHolder.replaceAll('.', '').replaceAll('-', '')) {
                        _cpfHolderValidation(context);
                      }
                    }
                  },
                  focusNode: numberCpfFocus,
                  keyboardType: TextInputType.number,
                  counterText: context.translate.characters,
                  showCounterText: true,
                  maxLength: 14,
                  controller: widget.editDependentsController.cpfNumberController,
                  label: '${context.translate.cpfNumber} *',
                  style: textFieldStyle,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    SeniorMaskTextInputHelper(
                      initialText: widget.editDependentsController.cpfNumberController.text,
                      mask: '###.###.###-##',
                      filter: {'#': RegExp(r'[0-9]')},
                      type: SeniorMaskAutoCompletionType.lazy,
                    ),
                  ],
                  validator: (value) {
                    if (value != null) {
                      if (value.isNotEmpty && value.length == 14) {
                        if (CpfValidatorHelp.isValid(value)) {
                          return null;
                        }
                        return context.translate.invalidCpfNumber;
                      } else if (value.isEmpty) {
                        return context.translate.enterTheDependentCpf;
                      } else if (value.length < 14 && !numberCpfFocus.hasFocus) {
                        return context.translate.enterTheDependentCpf;
                      }
                      return null;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorDropdownButton(
                    value: widget.editDependentsController.selectedGenderController,
                    items: DropdownItemListEnum<GenderTypeEnum>().dropdownItemList(
                      values: GenderTypeEnum.values,
                      title: (genderTypeEnum) => genderTypeEnum.nameTranslate(
                        context.translate,
                      ),
                    ),
                    onSelected: (genderTypeEnum) {
                      setState(() {});
                      widget.editDependentsController.genderController.text =
                          genderTypeEnum.nameTranslate(context.translate);
                      widget.editDependentsController.selectedGenderController = genderTypeEnum;
                    },
                    label: '${context.translate.gender} *',
                    style: dropdownStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorDropdownButton(
                    items: DropdownItemListEnum<PersonalRelationshipEnum>().dropdownItemList(
                      values: PersonalRelationshipEnum.values,
                      title: (personalRelationshipEnum) =>
                          EnumPersonalRelationshipStringFormatter.personalRelationshipEnumToValue(
                        personalRelationshipEnum: personalRelationshipEnum,
                        appLocalizations: context.translate,
                      ),
                    ),
                    label: '${context.translate.degreeOfKinship} *',
                    value: widget.editDependentsController.selectedRelationshipController,
                    showUnderline: true,
                    onSelected: (personalRelationshipEnum) {
                      setState(() {});
                      widget.editDependentsController.selectedRelationshipController = personalRelationshipEnum;
                      widget.editDependentsController.degreeOfKinshipController.text = personalRelationshipEnum.name(
                        context.translate,
                      );
                    },
                    style: dropdownStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorDropdownButton(
                    value: widget.editDependentsController.onSelectedMaritalStatus,
                    items: DropdownItemListEnum<MaritalStatusEnum>().dropdownItemList(
                      values: MaritalStatusEnum.values,
                      title: (maritalStatusEnum) => EnumMaritalStatusStringFormatter.getEnumMaritalStatusTypeString(
                        appLocalizations: context.translate,
                        maritalStatusEnum: maritalStatusEnum,
                      ),
                    ),
                    onSelected: (value) {
                      setState(() {});
                      widget.editDependentsController.maritalStatusController.text =
                          EnumHelper<MaritalStatusEnum>().enumToString(
                        enumToParse: value,
                      );
                      widget.editDependentsController.onSelectedMaritalStatus = value;
                    },
                    label: context.translate.maritalStatus,
                    style: dropdownStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.small,
                  ),
                  child: SeniorDropdownButton(
                    value: widget.editDependentsController.educationDegreeController.text,
                    items: educationLevelItems,
                    onSelected: (value) {
                      final education = _editDependentsDataScreenBloc.educationDegreeBloc.state.educationDegreeList
                          .firstWhere((e) => e.id == value);
                      _editDependentsDataScreenBloc.educationDegreeBloc.add(
                        SelectEducationDegreeFromEntityToProfileEvent(
                          educationDegreeEntity: education,
                        ),
                      );
                      widget.editDependentsController.educationDegreeController.text = education.id!;
                    },
                    label: context.translate.educationLevel,
                    style: dropdownStyle,
                  ),
                ),
                SeniorTextField(
                  focusNode: liveBirthDeclarationNode,
                  onFieldSubmitted: (p0) {
                    dateOfBirthFocus.requestFocus();
                  },
                  onChanged: (_) {
                    widget.onValueChanged();
                  },
                  controller: widget.editDependentsController.liveBirthDeclarationController,
                  label: context.translate.liveBirthCertificate,
                  style: textFieldStyle,
                  textInputAction: TextInputAction.done,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.xsmall,
                  ),
                  child: SeniorTextField(
                    focusNode: dateOfBirthFocus,
                    onFieldSubmitted: (p0) {
                      mothersNameFocus.requestFocus();
                    },
                    onChanged: (_) {
                      widget.onValueChanged();
                    },
                    controller: widget.editDependentsController.birthDateController,
                    label: '${context.translate.dateOfBirth} *',
                    style: textFieldStyle,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      SeniorMaskTextInputHelper(
                        initialText: widget.editDependentsController.birthDateController.text,
                        mask: '##/##/####',
                      ),
                    ],
                    validator: (value) {
                      if (value != null) {
                        if (value.isNotEmpty) {
                          if (value.trim().length < 10 && !dateOfBirthFocus.hasFocus) {
                            return context.translate.wrongAlert;
                          }

                          if (!DateTimeHelper.validateDate(
                                date: value,
                                locale: LocaleHelper.languageAndCountryCode(
                                  locale: Localizations.localeOf(context),
                                ),
                              ) &&
                              value.trim().length == 10) {
                            return context.translate.invalidDate;
                          }

                          if (!DateTimeHelper.validateDate(
                                date: value,
                                locale: LocaleHelper.languageAndCountryCode(
                                  locale: Localizations.localeOf(context),
                                ),
                                validateCurrentMajorYear: true,
                              ) &&
                              value.trim().length == 10) {
                            return context.translate.theDateReportedMustBeEarlierthanToday;
                          }
                        } else if (value.isEmpty) {
                          return context.translate.defineDateBirth;
                        }
                      }

                      return null;
                    },
                  ),
                ),
                SeniorTextField(
                  onChanged: (_) {
                    widget.onValueChanged();
                  },
                  focusNode: mothersNameFocus,
                  onFieldSubmitted: (p0) {
                    cityOfBirthFocus.requestFocus();
                  },
                  counterText: context.translate.characters,
                  showCounterText: true,
                  maxLength: 70,
                  controller: widget.editDependentsController.mothersNameController,
                  label: context.translate.mothersName,
                  textInputAction: TextInputAction.done,
                  style: textFieldStyle,
                ),
                const SizedBox(
                  height: SeniorSpacing.xsmall,
                ),
                SeniorTextField(
                  focusNode: cityOfBirthFocus,
                  onChanged: (_) {
                    widget.onValueChanged();
                  },
                  readOnly: true,
                  onTap: () {
                    OptionsSelectBottomSheet.selectNaturality(
                      context: context,
                      searchNaturalityBloc: _editDependentsDataScreenBloc.searchNaturalityBloc,
                    );
                  },
                  suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
                  controller: widget.editDependentsController.naturalityController,
                  label: context.translate.cityOfBirth,
                  style: textFieldStyle,
                ),
                widget.enableDependentIncomeTax
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SeniorText.label(
                            '${context.translate.incomeTaxDependent}? *',
                          ),
                          SeniorRadioButton<bool>(
                            groupValue: widget.editDependentsController.isIncomeTaxDependent,
                            onChanged: (value) {
                              setState(() {});
                              widget.editDependentsController.isIncomeTaxDependent = true;
                            },
                            title: context.translate.yes,
                            value: true,
                            toggleable: false,
                          ),
                          SeniorRadioButton<bool>(
                            groupValue: widget.editDependentsController.isIncomeTaxDependent,
                            onChanged: (value) {
                              setState(() {});
                              widget.editDependentsController.isIncomeTaxDependent = false;
                            },
                            title: context.translate.no,
                            value: false,
                            toggleable: true,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _cpfHolderValidation(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.provideYourCPFtheDependent,
          content: context.translate.provideYourCPFtheDependentDescription(
            widget.nameHolder,
          ),
          defaultAction: SeniorModalAction(
            label: context.translate.no,
            action: () {
              widget.editDependentsController.cpfNumberController.clear();
              Modular.to.pop();
            },
          ),
          otherAction: SeniorModalAction(
            label: context.translate.yes,
            action: () {
              Modular.to.pop();
              numberCpfFocus.unfocus();
              FocusScope.of(context).unfocus();
            },
          ),
        );
      },
    );
  }
}
