import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../domain/entities/contact_entity.dart';
import '../../../../domain/entities/phone_contact_entity.dart';
import '../../../../enums/phone_contact_type_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../string_formatters/enum_phone_contact_type_string_formatter.dart';
import '../../../widgets/list_phones_widget.dart';
import 'input_phone_contacts_bottom_sheet_content_widget.dart';

class InputPersonalContactsPhonesScreen extends StatefulWidget {
  final List<ContactEntity<PhoneContactEntity>> phones;
  final ValueChanged<ContactEntity<PhoneContactEntity>> onInsertPhone;
  final Function(
    ContactEntity<PhoneContactEntity> newValue,
    ContactEntity<PhoneContactEntity> oldValue,
  ) onEditPhone;
  final ValueChanged<ContactEntity<PhoneContactEntity>> onDeletePhone;

  const InputPersonalContactsPhonesScreen({
    super.key,
    required this.phones,
    required this.onInsertPhone,
    required this.onEditPhone,
    required this.onDeletePhone,
  });

  @override
  State<InputPersonalContactsPhonesScreen> createState() {
    return InputPersonalContactsPhonesScreenState();
  }
}

class InputPersonalContactsPhonesScreenState extends State<InputPersonalContactsPhonesScreen> {
  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDarkTheme = themeRepository.isDarkTheme();
    final isCustomTheme = themeRepository.isCustomTheme();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: SeniorSpacing.normal,
          left: SeniorSpacing.normal,
          right: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeniorText.h4(
              context.translate.phones,
            ),
            const SizedBox(
              height: SeniorSpacing.medium,
            ),
            if (widget.phones.isEmpty)
              SeniorCard(
                withElevation: isCustomTheme,
                style: SeniorCardStyle(
                  backgroundColor: isDarkTheme
                      ? themeRepository.theme.cardTheme!.style!.backgroundColor
                      : isCustomTheme
                          ? SeniorColors.pureWhite
                          : SeniorColors.secondaryColor100,
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SeniorSpacing.normal,
                        vertical: SeniorSpacing.xsmall,
                      ),
                      child: SeniorIcon(
                        icon: FontAwesomeIcons.solidFileLines,
                        size: SeniorSpacing.big,
                      ),
                    ),
                    SeniorText.body(
                      context.translate.noPhoneRegistered,
                      color: SeniorColors.neutralColor900,
                    ),
                  ],
                ),
              ),
            if (widget.phones.isNotEmpty)
              ListPhonesWidget(
                phones: widget.phones,
                onDeletePhone: widget.onDeletePhone,
                onEditPhone: widget.onEditPhone,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: Center(
                child: SeniorButton(
                  icon: FontAwesomeIcons.solidPlus,
                  label: context.translate.addPhone,
                  disabled: widget.phones.length > 2,
                  outlined: true,
                  fullWidth: true,
                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                  onPressed: () {
                    addPhone(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPhone(BuildContext context) {
    final dropdownItemList = DropdownItemListEnum<PhoneContactTypeEnum>().dropdownItemList(
      values: PhoneContactTypeEnum.values,
      title: (phoneContactTypeEnum) => EnumPhoneContactTypeStringFormatter.phoneContactTypeEnumToValue(
        phoneContactTypeEnum: phoneContactTypeEnum,
        appLocalizations: context.translate,
      ),
    );

    for (var phone in widget.phones) {
      dropdownItemList.retainWhere(
        (e) =>
            e.value.toString() !=
            EnumHelper()
                .enumToString(
                  enumToParse: phone.content.type,
                )
                .toUpperCase(),
      );
    }

    SeniorBottomSheet.showBottomSheet(
      title: context.translate.addPhone,
      height: context.bottomSheetSize,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: InputPhoneContactsBottomSheetContentWidget(
            dropdownItemList: dropdownItemList,
            typeEdit: 'CREATE',
            dropdownItemDescription: context.translate.type,
            primaryButtonPressed: (newValue) {
              widget.onInsertPhone(newValue);

              Modular.to.pop();
            },
            secondaryButtonPressed: () {
              Modular.to.pop();
            },
          ),
        ),
      ],
    );
  }
}
