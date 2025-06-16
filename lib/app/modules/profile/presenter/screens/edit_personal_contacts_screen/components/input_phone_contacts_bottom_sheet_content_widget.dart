import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../domain/entities/contact_entity.dart';
import '../../../../domain/entities/phone_contact_entity.dart';
import '../../../../enums/phone_contact_type_enum.dart';

class InputPhoneContactsBottomSheetContentWidget extends StatefulWidget {
  final String dropdownItemDescription;
  final List<SeniorDropdownButtonItem> dropdownItemList;
  final ValueChanged<ContactEntity<PhoneContactEntity>> primaryButtonPressed;
  final VoidCallback secondaryButtonPressed;
  final String typeEdit;
  final ContactEntity<PhoneContactEntity>? phone;

  const InputPhoneContactsBottomSheetContentWidget({
    Key? key,
    required this.dropdownItemDescription,
    required this.dropdownItemList,
    required this.primaryButtonPressed,
    required this.secondaryButtonPressed,
    required this.typeEdit,
    this.phone,
  }) : super(key: key);

  @override
  State<InputPhoneContactsBottomSheetContentWidget> createState() {
    return _InputPhoneContactsBottomSheetContentWidgetState();
  }
}

class _InputPhoneContactsBottomSheetContentWidgetState extends State<InputPhoneContactsBottomSheetContentWidget> {
  @override
  void initState() {
    super.initState();

    _typeController.addListener(() {
      setState(() {});
    });

    _ddiController.addListener(() {
      setState(() {});
    });

    _dddController.addListener(() {
      setState(() {});
    });

    _phoneController.addListener(() {
      setState(() {});
    });

    _branchController.addListener(() {
      setState(() {});
    });

    _providerController.addListener(() {
      setState(() {});
    });

    if (widget.phone != null) {
      _ddiController.text =
          widget.phone!.content.countryCode != null ? widget.phone!.content.countryCode.toString() : '';
      _dddController.text = widget.phone!.content.localCode != null ? widget.phone!.content.localCode.toString() : '';
      _phoneController.text = widget.phone!.content.number.toString();
      _branchController.text = widget.phone!.content.branch != null ? widget.phone!.content.branch.toString() : '';
      _providerController.text =
          widget.phone!.content.provider != null ? widget.phone!.content.provider.toString() : '';
      _typeController.text = widget.phone!.content.type!.name.toUpperCase();
    } else if (widget.dropdownItemList.length == 1) {
      _typeController.text = widget.dropdownItemList.first.value;
    }
  }

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ddiController = TextEditingController();
  final TextEditingController _dddController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Scaffold(
      backgroundColor: isDarkMode
          ? Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor
          : SeniorColors.pureWhite,
      body: Padding(
        padding: const EdgeInsets.only(
          top: SeniorSpacing.normal,
        ),
        child: Scrollbar(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverToBoxAdapter(
                child: SeniorText.body(
                  '* ${context.translate.mandatoryItem}',
                  color: SeniorColors.neutralColor600,
                  darkColor: SeniorColors.pureWhite,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.xmedium,
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorDropdownButton(
                  value: EnumHelper<PhoneContactTypeEnum>().stringToEnum(
                    stringToParse: _typeController.text,
                    values: PhoneContactTypeEnum.values,
                  ),
                  disabled: widget.dropdownItemList.length == 1,
                  items: widget.dropdownItemList,
                  onSelected: (phoneContactTypeEnum) {
                    _typeController.text = EnumHelper<PhoneContactTypeEnum>().enumToString(
                      enumToParse: phoneContactTypeEnum,
                    );
                  },
                  label: '${widget.dropdownItemDescription} *',
                  style: SeniorDropdownButtonStyle(
                    itemListTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.normal,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SeniorTextField(
                        controller: _ddiController,
                        disabled: false,
                        label: context.translate.ddi,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: seniorTextFieldStyle(),
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.small,
                    ),
                    Expanded(
                      flex: 1,
                      child: SeniorTextField(
                        controller: _dddController,
                        disabled: false,
                        label: context.translate.ddd,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: seniorTextFieldStyle(),
                      ),
                    ),
                    const SizedBox(
                      width: SeniorSpacing.small,
                    ),
                    Expanded(
                      flex: 3,
                      child: SeniorTextField(
                        controller: _phoneController,
                        disabled: false,
                        label: '${context.translate.phone} *',
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: seniorTextFieldStyle(),
                        validator: (value) {
                          if (value != null) {
                            if (value.length < 7) {
                              return context.translate.wrongAlert;
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorTextField(
                  controller: _branchController,
                  disabled: false,
                  label: context.translate.extension,
                  maxLength: 15,
                  style: seniorTextFieldStyle(),
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorTextField(
                  controller: _providerController,
                  disabled: false,
                  label: context.translate.operator,
                  style: seniorTextFieldStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EmployeeBottomSheetWidget(
        horizontalPadding: false,
        seniorButtons: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorButton(
              disabled: _typeController.text.isEmpty || _phoneController.text.isEmpty,
              busy: false,
              fullWidth: true,
              label: context.translate.save,
              onPressed: () {
                final contactEntity = ContactEntity(
                  content: PhoneContactEntity(
                    id: widget.phone?.content.id,
                    branch: _branchController.text,
                    countryCode: (_ddiController.text.isNotEmpty) ? int.parse(_ddiController.text) : null,
                    localCode: (_dddController.text.isNotEmpty) ? int.parse(_dddController.text) : null,
                    number: _phoneController.text,
                    provider: _providerController.text,
                    type: PhoneContactTypeEnum.values
                        .where((e) => e.name.toLowerCase() == _typeController.text.toLowerCase())
                        .first,
                  ),
                  typeEdit: widget.typeEdit,
                );

                widget.primaryButtonPressed(contactEntity);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorButton.ghost(
              disabled: false,
              fullWidth: true,
              label: context.translate.close,
              onPressed: () {
                widget.secondaryButtonPressed();
              },
            ),
          ),
        ],
      ),
    );
  }

  SeniorTextFieldStyle seniorTextFieldStyle() {
    return Provider.of<ThemeRepository>(context).isDarkTheme()
        ? const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.pureWhite,
            textColor: SeniorColors.pureWhite,
          )
        : const SeniorTextFieldStyle(
            hintTextColor: SeniorColors.neutralColor900,
            textColor: SeniorColors.neutralColor900,
          );
  }
}
