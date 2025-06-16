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
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../enums/address_type_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/postal_code_input_formatter_helper.dart';
import '../../../blocs/address_by_postal_code_bloc/address_by_postal_code_bloc.dart';
import '../../../blocs/address_by_postal_code_bloc/address_by_postal_code_event.dart';
import '../../../blocs/address_by_postal_code_bloc/address_by_postal_code_state.dart';
import '../../../blocs/administrative_region_bloc/administrative_region_bloc.dart';
import '../../../blocs/administrative_region_bloc/administrative_region_event.dart';
import '../../../blocs/administrative_region_bloc/administrative_region_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/search_naturality/search_naturality_event.dart';
import '../../../string_formatters/enum_address_string_formatter.dart';
import '../../../widgets/select_naturality_bottom_sheet_content_widget.dart';
import '../bloc/edit_personal_address_screen_bloc.dart';
import '../bloc/edit_personal_address_screen_state.dart';

class InputPersonalAddressScreen extends StatefulWidget {
  final TextEditingController addressZipCode;
  final TextEditingController addressPatioType;
  final TextEditingController addressPatio;
  final TextEditingController addressNumber;
  final TextEditingController addressComplement;
  final TextEditingController addressNeighborhood;
  final TextEditingController addressCity;
  final TextEditingController administrativeRegion;
  final List<SeniorDropdownButtonItem> administrativeRegionItems;

  const InputPersonalAddressScreen({
    Key? key,
    required this.addressZipCode,
    required this.addressPatioType,
    required this.addressPatio,
    required this.addressNumber,
    required this.addressComplement,
    required this.addressNeighborhood,
    required this.addressCity,
    required this.administrativeRegion,
    required this.administrativeRegionItems,
  }) : super(key: key);

  @override
  State<InputPersonalAddressScreen> createState() {
    return _InputPersonalDataScreenState();
  }
}

class _InputPersonalDataScreenState extends State<InputPersonalAddressScreen> {
  late final EditPersonalAddressScreenBloc _editPersonalAddressScreenBloc;
  late final AuthorizationBloc _authorizationBloc;
  late final AuthorizationEntity? authEntity;
  AddressByPostalCodeState addressState = const InitialAddressByPostalCodeState(
    addressByPostalCodeEntity: null,
  );
  AdministrativeRegionState admState = const InitialAdministrativeRegionState();
  String currentPostalCode = '';

  @override
  void initState() {
    super.initState();
    _editPersonalAddressScreenBloc = Modular.get<EditPersonalAddressScreenBloc>();
    _authorizationBloc = Modular.get<AuthorizationBloc>();
    authEntity = (_authorizationBloc.state is LoadedAuthorizationState)
        ? (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity
        : null;
    currentPostalCode = widget.addressZipCode.text;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return MultiBlocListener(
      listeners: [
        BlocListener<AddressByPostalCodeBloc, AddressByPostalCodeState>(
          bloc: _editPersonalAddressScreenBloc.getAddressByPostalCodeBloc,
          listener: (context, state) {
            addressState = state;
          },
        ),
        BlocListener<AdministrativeRegionBloc, AdministrativeRegionState>(
          bloc: _editPersonalAddressScreenBloc.getAdministrativeRegionBloc,
          listener: ((context, state) {
            admState = state;
          }),
        ),
      ],
      child: BlocBuilder<EditPersonalAddressScreenBloc, EditPersonalAddressScreenState>(
        bloc: _editPersonalAddressScreenBloc,
        builder: (context, state) {
          final searchAdmRegion = (admState is LoadingAdministrativeRegionState);
          final getAddress = (addressState is LoadingAddressByPostalCodeState);
          final isLoading = (state.getProfileState is! LoadedProfileState);

          if (isLoading) {
            return Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                alignment: Alignment.topCenter,
                child: const WaapiLoadingWidget(
                  key: Key('profile-edit_personal_address-loading'),
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
                  context.translate.defineData,
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
                disabled: getAddress || !(authEntity?.allowToUpdateAddressZipCode ?? true),
                controller: widget.addressZipCode,
                label: '${context.translate.addressZipCode} *',
                style: SeniorTextFieldStyle(
                  hintTextColor: theme.textTheme!.labelStyle!.color!,
                  textColor: theme.textTheme!.labelStyle!.color!,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                onChanged: (newValue) {
                  currentPostalCode = newValue;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                  PostalCodeInputFormatterHelper(),
                ],
                validator: (postalCode) {
                  if (postalCode != null && postalCode.trim().length == 9) {
                    if (currentPostalCode != postalCode.trim()) {
                      _editPersonalAddressScreenBloc.getAddressByPostalCodeBloc.add(
                        GetAddressByPostalCodeEvent(
                          postalCode: postalCode.replaceAll('-', '').trim(),
                        ),
                      );
                    }
                    return null;
                  }
                  return context.translate.wrongAlert;
                },
              ),
              const SizedBox(height: SeniorSpacing.xsmall),
              if (!getAddress)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorDropdownButton(
                    key: const Key('profile-edit_personal_address-patioType-loading-false'),
                    value: EnumHelper<AddressTypeEnum>().stringToEnum(
                      stringToParse: widget.addressPatioType.text,
                      values: AddressTypeEnum.values,
                    ),
                    disabled: searchAdmRegion || getAddress || !(authEntity?.allowToUpdateAddressPatioType ?? true),
                    items: DropdownItemListEnum<AddressTypeEnum>().dropdownItemList(
                      values: AddressTypeEnum.values,
                      title: (addressTypeEnum) => EnumAddressStringFormatter().getEnumAddressString(
                        addressTypeEnum: addressTypeEnum,
                        appLocalizations: context.translate,
                      ),
                    ),
                    onSelected: (addressTypeEnum) {
                      setState(() {});
                      widget.addressPatioType.text = EnumHelper<AddressTypeEnum>().enumToString(
                        enumToParse: addressTypeEnum,
                      );
                    },
                    label: context.translate.addressPatioType,
                    style: SeniorDropdownButtonStyle(
                      itemListTextColor: theme.textTheme!.labelStyle!.color!,
                    ),
                  ),
                ),
              if (getAddress)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorDropdownButton(
                    key: const Key('profile-edit_personal_address-patioType-loading-true'),
                    value: EnumHelper<AddressTypeEnum>().stringToEnum(
                      stringToParse: widget.addressPatioType.text,
                      values: AddressTypeEnum.values,
                    ),
                    disabled: true,
                    items: DropdownItemListEnum<AddressTypeEnum>().dropdownItemList(
                      values: AddressTypeEnum.values,
                      title: (addressTypeEnum) => EnumAddressStringFormatter().getEnumAddressString(
                        addressTypeEnum: addressTypeEnum,
                        appLocalizations: context.translate,
                      ),
                    ),
                    onSelected: (value) {},
                    label: context.translate.addressPatioType,
                    style: SeniorDropdownButtonStyle(
                      itemListTextColor: theme.textTheme!.labelStyle!.color!,
                    ),
                  ),
                ),
              SeniorTextField(
                disabled: searchAdmRegion || getAddress || !(authEntity?.allowToUpdateAddressPatio ?? true),
                controller: widget.addressPatio,
                label: '${context.translate.addressPatio} *',
                style: SeniorTextFieldStyle(
                  hintTextColor: theme.textTheme!.labelStyle!.color!,
                  textColor: theme.textTheme!.labelStyle!.color!,
                ),
              ),
              SeniorTextField(
                disabled: searchAdmRegion || getAddress || !(authEntity?.allowToUpdateAddressNumber ?? true),
                controller: widget.addressNumber,
                label: context.translate.number,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: SeniorTextFieldStyle(
                  hintTextColor: theme.textTheme!.labelStyle!.color!,
                  textColor: theme.textTheme!.labelStyle!.color!,
                ),
              ),
              SeniorTextField(
                disabled: searchAdmRegion || getAddress || !(authEntity?.allowToUpdateAddressAdditional ?? true),
                controller: widget.addressComplement,
                label: context.translate.addressComplement,
                style: SeniorTextFieldStyle(
                  hintTextColor: theme.textTheme!.labelStyle!.color!,
                  textColor: theme.textTheme!.labelStyle!.color!,
                ),
              ),
              SeniorTextField(
                disabled: searchAdmRegion || getAddress || !(authEntity?.allowToUpdateAddressNeighborhood ?? true),
                controller: widget.addressNeighborhood,
                label: context.translate.addressNeighborhood,
                style: SeniorTextFieldStyle(
                  hintTextColor: theme.textTheme!.labelStyle!.color!,
                  textColor: theme.textTheme!.labelStyle!.color!,
                ),
              ),
              SeniorTextField(
                readOnly: true,
                onTap: () {
                  _selectCity(context);
                },
                disabled: searchAdmRegion || getAddress || !(authEntity?.allowToUpdateAddressCity ?? true),
                suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
                controller: widget.addressCity,
                label: context.translate.addressCity,
                style: SeniorTextFieldStyle(
                  hintTextColor: theme.textTheme!.labelStyle!.color!,
                  textColor: theme.textTheme!.labelStyle!.color!,
                ),
              ),
              const SizedBox(height: SeniorSpacing.xsmall),
              if (admState is ErrorAdministrativeRegionState)
                SeniorTextField(
                  suffixIcon: FontAwesomeIcons.arrowRotateRight,
                  helper: context.translate.administrativeRegionError,
                  hintText: context.translate.administrativeRegion,
                  style: const SeniorTextFieldStyle(
                    hintTextColor: SeniorColors.manchesterColorRed500,
                    borderColor: Colors.transparent,
                    focusColor: SeniorColors.manchesterColorRed500,
                  ),
                  readOnly: true,
                  onTap: () {
                    if (_editPersonalAddressScreenBloc.searchCityBloc.state.selectedNaturalityEntity?.id! != null) {
                      _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.add(
                        GetAdministrativeRegionProfileEvent(
                          cityId: _editPersonalAddressScreenBloc.searchCityBloc.state.selectedNaturalityEntity!.id!,
                        ),
                      );
                    }
                  },
                ),
              if (widget.administrativeRegionItems.isNotEmpty &&
                  admState is! ErrorAdministrativeRegionState &&
                  widget.addressCity.text.isNotEmpty)
                SeniorDropdownButton(
                  value: widget.administrativeRegion.text,
                  disabled: widget.addressCity.text.isEmpty || !(authEntity?.allowToUpdateAddressAdmRegion ?? true),
                  items: widget.administrativeRegionItems,
                  onSelected: (value) {
                    final admList =
                        _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.state.administrativeRegionList;
                    final getAdministrativeRegion =
                        admList.isNotEmpty ? admList.where((e) => e.id == value).first : null;
                    if (getAdministrativeRegion != null) {
                      _editPersonalAddressScreenBloc.getAdministrativeRegionBloc.add(
                        SelectAdministrativeRegionFromEntityToProfileEvent(
                          administrativeRegionEntity: getAdministrativeRegion,
                        ),
                      );
                    }
                    widget.administrativeRegion.text = value;
                  },
                  label: context.translate.administrativeRegion,
                  style: SeniorDropdownButtonStyle(
                    itemListTextColor: theme.textTheme!.labelStyle!.color!,
                  ),
                ),
              if ((widget.administrativeRegionItems.isEmpty && admState is! ErrorAdministrativeRegionState) ||
                  widget.addressCity.text.isEmpty)
                SeniorDropdownButton(
                  value: widget.administrativeRegion.text,
                  disabled: true,
                  items: [
                    SeniorDropdownButtonItem(
                      value: widget.administrativeRegion.text,
                      title: context.translate.administrativeRegion,
                    ),
                  ],
                  onSelected: (value) {},
                  label: context.translate.administrativeRegion,
                  style: SeniorDropdownButtonStyle(
                    itemListTextColor: theme.textTheme!.labelStyle!.color!,
                  ),
                ),
            ],
          );
        },
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
            searchNaturalityBloc: _editPersonalAddressScreenBloc.searchCityBloc,
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
        _editPersonalAddressScreenBloc.searchCityBloc.add(ClearSearchNaturalityProfileEvent());
        Modular.to.pop();
      },
    );
  }
}
