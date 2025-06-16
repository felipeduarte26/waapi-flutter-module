import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../domain/entities/city_entity.dart';
import '../../../../domain/entities/civil_certificate_entity.dart';
import '../../../../enums/civil_certificate_type_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../blocs/civil_certificate_bloc/civil_certificate_event.dart';
import '../../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../../blocs/search_naturality/search_naturality_event.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../string_formatters/enum_civil_certificate_type_string_formatter.dart';
import '../../../widgets/select_naturality_bottom_sheet_content_widget.dart';
import '../bloc/edit_personal_documents_screen_bloc.dart';

class CivilCertificateBottomSheetWidget extends StatefulWidget {
  final CivilCertificateEntity? civilCertificate;

  const CivilCertificateBottomSheetWidget({
    Key? key,
    this.civilCertificate,
  }) : super(key: key);

  @override
  State<CivilCertificateBottomSheetWidget> createState() {
    return _CivilCertificateBottomSheetWidgetState();
  }
}

class _CivilCertificateBottomSheetWidgetState extends State<CivilCertificateBottomSheetWidget> {
  late final EditPersonalDocumentsScreenBloc _editPersonalDocumentsScreenBloc;
  bool validDate = false;

  CityEntity addressCity = const CityEntity();

  FocusNode civilIssuanceDateFocus = FocusNode();
  FocusNode civilRegistrationNumberFocus = FocusNode();
  FocusNode civilTermNumberFocus = FocusNode();
  FocusNode civilBookNumberFocus = FocusNode();
  FocusNode civilSheetNumberFocus = FocusNode();
  FocusNode civilNotaryOfficeNameFocus = FocusNode();
  FocusNode civilIssuingCityFocus = FocusNode();

  TextEditingController civilTypeController = TextEditingController();
  TextEditingController civilRegistrationNumberController = TextEditingController();
  TextEditingController civilBookNumberController = TextEditingController();
  TextEditingController civilTermNumberController = TextEditingController();
  TextEditingController civilSheetNumberController = TextEditingController();
  TextEditingController civilNotaryOfficeNameController = TextEditingController();
  TextEditingController civilIssuingCityController = TextEditingController();
  TextEditingController civilIssuingCityIdController = TextEditingController();
  TextEditingController civilIssuanceDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editPersonalDocumentsScreenBloc = Modular.get<EditPersonalDocumentsScreenBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.civilCertificate != null) {
      civilTypeController.text = EnumHelper<CivilCertificateTypeEnum>().enumToString(
        enumToParse: widget.civilCertificate!.certificateType!,
      );

      if (widget.civilCertificate?.enrollment != null) {
        civilRegistrationNumberController.text = widget.civilCertificate!.enrollment!;
      }

      if (widget.civilCertificate?.bookNumber != null) {
        civilBookNumberController.text = widget.civilCertificate!.bookNumber!;
      }

      if (widget.civilCertificate?.termNumber != null) {
        civilTermNumberController.text = widget.civilCertificate!.termNumber!;
      }

      if (widget.civilCertificate?.paperNumber != null) {
        civilSheetNumberController.text = widget.civilCertificate!.paperNumber!;
      }

      if (widget.civilCertificate?.registryName != null) {
        civilNotaryOfficeNameController.text = widget.civilCertificate!.registryName!;
      }

      if (widget.civilCertificate?.city != null) {
        civilIssuingCityIdController.text = widget.civilCertificate!.city!.id!;
      }

      if (widget.civilCertificate?.city != null) {
        civilIssuingCityController.text = widget.civilCertificate!.city!.name!;
      }

      if (widget.civilCertificate?.issuedDate != null) {
        civilIssuanceDateController.text = DateTimeHelper.formatWithDefaultDatePattern(
          dateTime: widget.civilCertificate!.issuedDate!,
          locale: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        );
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return BlocListener<SearchNaturalityBloc, SearchNaturalityState>(
      bloc: _editPersonalDocumentsScreenBloc.searchCivilCityBloc,
      listener: (context, state) {
        if (state is LoadedSelectNaturalityState && state.selectedNaturalityEntity != null) {
          addressCity = state.selectedNaturalityEntity!;
          civilIssuingCityController.text = addressCity.name!;
          civilIssuingCityIdController.text = addressCity.id!;
        }
      },
      child: Expanded(
        child: Scaffold(
          backgroundColor: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
          body: Scrollbar(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: SeniorText.body(
                    '* ${context.translate.mandatoryItem}',
                    color: SeniorColors.neutralColor600,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.normal,
                    ),
                    child: SeniorDropdownButton(
                      key: const Key('civil_certificate_bottom_sheet_widget-civil_type'),
                      value: EnumHelper<CivilCertificateTypeEnum>().stringToEnum(
                        stringToParse: civilTypeController.text,
                        values: CivilCertificateTypeEnum.values,
                      ),
                      items: DropdownItemListEnum<CivilCertificateTypeEnum>().dropdownItemList(
                        values: CivilCertificateTypeEnum.values,
                        title: (civilCertificateTypeEnum) =>
                            EnumCivilCertificateTypeStringFormatter.getEnumCivilCertificateTypeString(
                          civilCertificateTypeEnum: civilCertificateTypeEnum,
                          appLocalizations: context.translate,
                        ),
                      ),
                      onSelected: (selected) {
                        civilTypeController.text = EnumHelper<CivilCertificateTypeEnum>().enumToString(
                          enumToParse: selected,
                        );
                        setState(() {});
                      },
                      label: '${context.translate.typeCivilCertificate}*',
                      style: SeniorDropdownButtonStyle(
                        itemListTextColor: theme.menuListItemTheme!.style!.titleColor,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SeniorTextField(
                    key: const Key('civil_certificate_bottom_sheet_widget-civil_issuance_date'),
                    onChanged: (value) {
                      setState(
                        () {},
                      );
                    },
                    focusNode: civilIssuanceDateFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(civilRegistrationNumberFocus);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      SeniorMaskTextInputHelper(
                        initialText: civilIssuanceDateController.text,
                        mask: '##/##/####',
                      ),
                    ],
                    validator: (value) {
                      validDate = false;
                      if (value != null && value.isNotEmpty) {
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
                      validDate = true;
                      return null;
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    controller: civilIssuanceDateController,
                    label: context.translate.issuanceDate,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.small,
                    ),
                    child: SeniorTextField(
                      key: const Key('civil_certificate_bottom_sheet_widget-civil_registration_number'),
                      onChanged: (value) {
                        setState(
                          () {},
                        );
                      },
                      focusNode: civilRegistrationNumberFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(civilTermNumberFocus);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      controller: civilRegistrationNumberController,
                      label: context.translate.registrationNumber,
                      maxLength: 32,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SeniorTextField(
                    key: const Key('civil_certificate_bottom_sheet_widget-civil_term_number'),
                    onChanged: (value) {
                      setState(
                        () {},
                      );
                    },
                    focusNode: civilTermNumberFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(civilBookNumberFocus);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    controller: civilTermNumberController,
                    label: context.translate.termNumber,
                    maxLength: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.small,
                    ),
                    child: SeniorTextField(
                      key: const Key('civil_certificate_bottom_sheet_widget-civil_book_number'),
                      maxLength: 6,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      controller: civilBookNumberController,
                      label: context.translate.bookNumber,
                      focusNode: civilBookNumberFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(civilSheetNumberFocus);
                      },
                      onChanged: (value) {
                        setState(
                          () {},
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SeniorTextField(
                    key: const Key('civil_certificate_bottom_sheet_widget-civil_sheet_number'),
                    maxLength: 6,
                    controller: civilSheetNumberController,
                    label: context.translate.sheetNumber,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    focusNode: civilSheetNumberFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(civilNotaryOfficeNameFocus);
                    },
                    onChanged: (value) {
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: SeniorSpacing.small,
                    ),
                    child: SeniorTextField(
                      key: const Key('civil_certificate_bottom_sheet_widget-civil_notary_office'),
                      maxLength: 20,
                      controller: civilNotaryOfficeNameController,
                      label: context.translate.notaryOfficeName,
                      focusNode: civilNotaryOfficeNameFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(civilIssuingCityFocus);
                      },
                      onChanged: (value) {
                        setState(
                          () {},
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SeniorTextField(
                    key: const Key('civil_certificate_bottom_sheet_widget-civil_issuing_city'),
                    readOnly: true,
                    onTap: () {
                      _selectCity(context);
                    },
                    focusNode: civilIssuingCityFocus,
                    suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
                    controller: civilIssuingCityController,
                    label: context.translate.cityCivilCertificate,
                    style: const SeniorTextFieldStyle(
                      hintTextColor: SeniorColors.neutralColor900,
                      textColor: SeniorColors.neutralColor900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: EmployeeBottomSheetWidget(
            horizontalPadding: false,
            key: const Key('profile-personal_documents_screen-bottom_sheet'),
            seniorButtons: [
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  key: const Key(
                    'profile-civil_certificate_bottom_sheet_widget-bottom_sheet-button-send_civil_certificate',
                  ),
                  fullWidth: true,
                  label: context.translate.save,
                  onPressed: () async {
                    if (widget.civilCertificate != null) {
                      _editPersonalDocumentsScreenBloc.getCivilCertificateBloc.add(
                        UnselectCivilCertificateFromEntityToProfileEvent(
                          civilCertificateEntity: widget.civilCertificate!,
                        ),
                      );
                    }

                    _editPersonalDocumentsScreenBloc.getCivilCertificateBloc.add(
                      SelectCivilCertificateFromEntityToProfileEvent(
                        civilCertificateEntity: CivilCertificateEntity(
                          id: (widget.civilCertificate != null) ? widget.civilCertificate!.id! : null,
                          certificateType: EnumHelper<CivilCertificateTypeEnum>().stringToEnum(
                            stringToParse: civilTypeController.text,
                            values: CivilCertificateTypeEnum.values,
                          ),
                          bookNumber:
                              (civilBookNumberController.text.isNotEmpty) ? civilBookNumberController.text : null,
                          enrollment: civilRegistrationNumberController.text,
                          issuedDate: DateTimeHelper.convertStringDdMmAaaaToDateTime(
                            locale: LocaleHelper.languageAndCountryCode(
                              locale: Localizations.localeOf(context),
                            ),
                            stringDdMmAaaa: civilIssuanceDateController.text,
                          ),
                          termNumber: civilTermNumberController.text,
                          paperNumber: civilSheetNumberController.text,
                          city: CityEntity(
                            id: civilIssuingCityIdController.text,
                            name: civilIssuingCityController.text,
                          ),
                          registryName: civilNotaryOfficeNameController.text,
                        ),
                      ),
                    );

                    clearCivilCertificate();

                    Modular.to.pop();
                  },
                  disabled: validateSaveButton(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                  top: SeniorSpacing.normal,
                ),
                child: SeniorButton.ghost(
                  key: const Key('profile-civil_certificate_bottom_sheet_widget-bottom_sheet-button-option_cancel'),
                  fullWidth: true,
                  label: context.translate.optionCancel,
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCity(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.defineCity,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectNaturalityBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_naturality_bottom_sheet_content_widget'),
            searchNaturalityBloc: _editPersonalDocumentsScreenBloc.searchCivilCityBloc,
            initialTitle: context.translate.findCity,
            initialSubtitle: context.translate.findCityHelper,
            noFoundTitle: context.translate.noCityFound,
            noFoundSubtitle: context.translate.checkTermTryAgain,
            textFieldLabel: context.translate.addressCity,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _editPersonalDocumentsScreenBloc.searchCivilCityBloc.add(ClearSearchNaturalityProfileEvent());
        Modular.to.pop();
      },
    );
  }

  Future<void> clearCivilCertificate() async {
    civilTypeController.clear();
    civilRegistrationNumberController.clear();
    civilBookNumberController.clear();
    civilTermNumberController.clear();
    civilSheetNumberController.clear();
    civilNotaryOfficeNameController.clear();
    civilIssuingCityController.clear();
    civilIssuingCityIdController.clear();
    civilIssuanceDateController.clear();
  }

  bool validateSaveButton() {
    return !(civilTypeController.text.isNotEmpty && validDate);
  }
}
