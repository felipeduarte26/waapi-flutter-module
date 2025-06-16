import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/education_degree_entity.dart';
import '../../../../enums/gender_type_enum.dart';
import '../../../../enums/marital_status_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../blocs/education_degree_bloc/education_degree_event.dart';
import '../../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../../blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';
import '../../../blocs/search_nationality/search_nationality_event.dart';
import '../../../blocs/search_naturality/search_naturality_event.dart';
import '../../../blocs/update_personal_data_bloc/update_personal_data_state.dart';
import '../../../string_formatters/enum_gender_string_formatter.dart';
import '../../../string_formatters/enum_marital_status_string_formatter.dart';
import '../../../widgets/select_ethnicity_bottom_sheet_content_widget.dart';
import '../../../widgets/select_nationality_bottom_sheet_content_widget.dart';
import '../../../widgets/select_naturality_bottom_sheet_content_widget.dart';
import '../bloc/edit_personal_data_screen_bloc.dart';
import '../bloc/edit_personal_data_screen_state.dart';

class InputPersonalDataScreen extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController dateOfBirthController;
  final TextEditingController nationalityController;
  final TextEditingController naturalityController;
  final TextEditingController genderController;
  final TextEditingController maritalStatusController;
  final TextEditingController ethnicityController;
  final TextEditingController educationDegreeController;
  final EducationDegreeEntity? educationDegreeEntity;

  const InputPersonalDataScreen({
    Key? key,
    required this.fullNameController,
    required this.dateOfBirthController,
    required this.nationalityController,
    required this.naturalityController,
    required this.genderController,
    required this.maritalStatusController,
    required this.ethnicityController,
    required this.educationDegreeController,
    required this.educationDegreeEntity,
  }) : super(key: key);

  @override
  State<InputPersonalDataScreen> createState() {
    return _InputPersonalDataScreenState();
  }
}

class _InputPersonalDataScreenState extends State<InputPersonalDataScreen> {
  late final EditPersonalDataScreenBloc _editPersonalDataScreenBloc;
  late final AuthorizationBloc _authorizationBloc;
  late final AuthorizationEntity? authEntity;

  List<SeniorDropdownButtonItem> educationLevelItems = [];

  @override
  void initState() {
    super.initState();
    _editPersonalDataScreenBloc = Modular.get<EditPersonalDataScreenBloc>();
    _authorizationBloc = Modular.get<AuthorizationBloc>();
    authEntity = (_authorizationBloc.state is LoadedAuthorizationState)
        ? (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity
        : null;

    if (_editPersonalDataScreenBloc.getEducationDegreeBloc.state is LoadedEducationDegreeState) {
      for (var educationDegree in _editPersonalDataScreenBloc.getEducationDegreeBloc.state.educationDegreeList) {
        educationLevelItems.add(
          SeniorDropdownButtonItem(
            value: educationDegree.id,
            title: educationDegree.name!,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);
    final isDarkMode = themeRepository.isDarkTheme();
    final textFieldStyle = themeRepository.isCustomTheme() ? null : WaapiStyleTheme.waapiSeniorTextFieldStyle();

    return BlocBuilder<EditPersonalDataScreenBloc, EditPersonalDataScreenState>(
      bloc: _editPersonalDataScreenBloc,
      builder: (context, state) {
        final isLoading = (state.updatePersonalDataState is LoadingUpdatePersonalDataState);

        if (isLoading) {
          return Center(
            child: Container(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              alignment: Alignment.topCenter,
              child: const WaapiLoadingWidget(
                key: Key('profile-edit_personal_data-loading'),
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.h4(
                context.translate.personalData,
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
              maxLength: 40,
              counterText: context.translate.characters,
              showCounterText: true,
              disabled: !(authEntity?.allowToUpdatePersonalDataName ?? true),
              controller: widget.fullNameController,
              label: '${context.translate.fullName} *',
              style: textFieldStyle,
            ),
            SeniorTextField(
              disabled: !(authEntity?.allowToUpdatePersonalDataBirthday ?? true),
              controller: widget.dateOfBirthController,
              label: '${context.translate.dateOfBirth} *',
              style: textFieldStyle,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.dateOfBirthController.text,
                  mask: '##/##/####',
                ),
              ],
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (value.trim().length < 10) {
                    return context.translate.wrongAlert;
                  }

                  if (!DateTimeHelper.validateDate(
                    date: value,
                    locale: LocaleHelper.languageAndCountryCode(
                      locale: Localizations.localeOf(context),
                    ),
                  )) {
                    return context.translate.invalidDate;
                  }

                  if (!DateTimeHelper.validateDate(
                    date: value,
                    locale: LocaleHelper.languageAndCountryCode(
                      locale: Localizations.localeOf(context),
                    ),
                    validateCurrentMajorYear: true,
                  )) {
                    return context.translate.theDateReportedMustBeEarlierthanToday;
                  }
                }

                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: SeniorDropdownButton(
                helper: context.translate.asShownInYourCivilRegistry,
                value: EnumHelper<GenderTypeEnum>().stringToEnum(
                  stringToParse: widget.genderController.text,
                  values: GenderTypeEnum.values,
                ),
                disabled: !(authEntity?.allowToUpdatePersonalDataGender ?? true),
                items: DropdownItemListEnum<GenderTypeEnum>().dropdownItemList(
                  values: GenderTypeEnum.values,
                  title: (genderTypeEnum) => EnumGenderStringFormatter.getEnumGenderTypeString(
                    appLocalizations: context.translate,
                    genderTypeEnum: genderTypeEnum,
                  ),
                ),
                onSelected: (genderTypeEnum) {
                  setState(() {});
                  widget.genderController.text = EnumHelper<GenderTypeEnum>().enumToString(
                    enumToParse: genderTypeEnum,
                  );
                },
                label: '${context.translate.gender} *',
                style: SeniorDropdownButtonStyle(
                  itemListTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                  labelColorEmpty: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorDropdownButton(
                value: EnumHelper<MaritalStatusEnum>().stringToEnum(
                  stringToParse: widget.maritalStatusController.text,
                  values: MaritalStatusEnum.values,
                ),
                disabled: !(authEntity?.allowToUpdatePersonalDataMaritalStatus ?? true),
                items: DropdownItemListEnum<MaritalStatusEnum>().dropdownItemList(
                  values: MaritalStatusEnum.values,
                  title: (maritalStatusEnum) => EnumMaritalStatusStringFormatter.getEnumMaritalStatusTypeString(
                    appLocalizations: context.translate,
                    maritalStatusEnum: maritalStatusEnum,
                  ),
                ),
                onSelected: (value) {
                  setState(() {});

                  widget.maritalStatusController.text = EnumHelper<MaritalStatusEnum>().enumToString(
                    enumToParse: value,
                  );
                },
                label: '${context.translate.maritalStatus} *',
                style: SeniorDropdownButtonStyle(
                  itemListTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                  labelColorEmpty: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                ),
              ),
            ),
            SeniorTextField(
              readOnly: true,
              onTap: () {
                _selectNationality(context, themeRepository);
              },
              disabled: !(authEntity?.allowToUpdatePersonalDataNationality ?? true),
              suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
              controller: widget.nationalityController,
              label: '${context.translate.nationality} *',
              style: textFieldStyle,
            ),
            const SizedBox(height: SeniorSpacing.xsmall),
            SeniorTextField(
              readOnly: true,
              onTap: () {
                _selectNaturality(context, themeRepository);
              },
              disabled: !(authEntity?.allowToUpdatePersonalDataBirthplace ?? true),
              suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
              controller: widget.naturalityController,
              label: '${context.translate.naturality} *',
              style: textFieldStyle,
            ),
            const SizedBox(height: SeniorSpacing.xsmall),
            SeniorTextField(
              helper: context.translate.asShownInYourCivilRegistry,
              readOnly: true,
              onTap: () {
                _selectEthnicity(context, themeRepository);
              },
              disabled: !(authEntity?.allowToUpdatePersonalDataRace ?? true),
              suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
              controller: widget.ethnicityController,
              label: '${context.translate.raceEthnicity} *',
              style: textFieldStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: SeniorDropdownButton(
                value: widget.educationDegreeController.text,
                disabled: !(authEntity?.allowToUpdatePersonalDataEducationLevel ?? true),
                items: educationLevelItems,
                onSelected: (value) {
                  final education = _editPersonalDataScreenBloc.getEducationDegreeBloc.state.educationDegreeList
                      .firstWhere((e) => e.id == value);
                  _editPersonalDataScreenBloc.getEducationDegreeBloc.add(
                    SelectEducationDegreeFromEntityToProfileEvent(
                      educationDegreeEntity: education,
                    ),
                  );
                },
                label: context.translate.educationLevel,
                style: SeniorDropdownButtonStyle(
                  itemListTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _selectNationality(BuildContext context, ThemeRepository themeRepository) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.nationalityTitle,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectNationalityBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_nationality_bottom_sheet_content_widget'),
            searchNationalityBloc: _editPersonalDataScreenBloc.searchNationalityBloc,
            initialTitle: context.translate.nationalitySearchHelp,
            initialSubtitle: context.translate.nationalitySearchHelpDescription,
            noFoundTitle: context.translate.nationalityNoDataFound,
            noFoundSubtitle: context.translate.nationalityNoDataFoundDescription,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _editPersonalDataScreenBloc.searchNationalityBloc.add(ClearSearchNationalityProfileEvent());
        Modular.to.pop();
      },
    );
  }

  void _selectEthnicity(BuildContext context, ThemeRepository themeRepository) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.informYourRaceEthnicity,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectEthnicityBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_Ethnicity_bottom_sheet_content_widget'),
            searchEthnicityBloc: _editPersonalDataScreenBloc.searchEthnicityBloc,
            initialTitle: context.translate.searchYourRaceEthnicity,
            initialSubtitle: context.translate.raceColorSearchHelpDescription,
            noFoundTitle: context.translate.searchYourRaceEthnicity,
            noFoundSubtitle: context.translate.makeSureWordsCorrectly,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _editPersonalDataScreenBloc.searchEthnicityBloc.add(ClearSearchEthnicityProfileEvent());
        Modular.to.pop();
      },
    );
  }

  void _selectNaturality(BuildContext context, ThemeRepository themeRepository) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.naturalityTitle,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectNaturalityBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_naturality_bottom_sheet_content_widget'),
            searchNaturalityBloc: _editPersonalDataScreenBloc.searchNaturalityBloc,
            initialTitle: context.translate.naturalitySearchHelp,
            initialSubtitle: context.translate.naturalitySearchHelpDescription,
            noFoundTitle: context.translate.naturalityNoDataFound,
            noFoundSubtitle: context.translate.naturalityNoDataFoundDescription,
            textFieldLabel: context.translate.naturality,
            isNaturality: true,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _editPersonalDataScreenBloc.searchNaturalityBloc.add(ClearSearchNaturalityProfileEvent());
        Modular.to.pop();
      },
    );
  }

  bool isValidDate(String date, {String format = 'yyyy-MM-dd'}) {
    try {
      final DateFormat dateFormatter = DateFormat(format);

      dateFormatter.parseStrict(date);
      return true;
    } on FormatException catch (_) {
      return false;
    }
  }
}
