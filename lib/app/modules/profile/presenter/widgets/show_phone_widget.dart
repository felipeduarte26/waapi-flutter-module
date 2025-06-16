import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/phone_contact_entity.dart';
import '../../enums/phone_contact_type_enum.dart';
import '../../helper/phone_contact_helper.dart';
import '../screens/edit_personal_contacts_screen/components/input_phone_contacts_bottom_sheet_content_widget.dart';
import '../string_formatters/enum_phone_contact_type_string_formatter.dart';

class ShowPhoneWidget extends StatefulWidget {
  final ContactEntity<PhoneContactEntity> phone;
  final Function(
    ContactEntity<PhoneContactEntity> newValue,
    ContactEntity<PhoneContactEntity> oldValue,
  ) onEditPhone;
  final ValueChanged<ContactEntity<PhoneContactEntity>> onDeletePhone;

  const ShowPhoneWidget({
    super.key,
    required this.phone,
    required this.onEditPhone,
    required this.onDeletePhone,
  });

  @override
  State<ShowPhoneWidget> createState() {
    return _ShowPhoneWidgetState();
  }
}

class _ShowPhoneWidgetState extends State<ShowPhoneWidget> {
  @override
  Widget build(BuildContext context) {
    final fullPhone = PhoneContactHelper.getFullPhone(
      phoneContact: widget.phone.content,
    );

    return WaapiCardWidget(
      showActionIcon: false,
      child: Column(
        children: [
          Row(
            children: [
              SeniorIcon(
                icon: getIconPhoneContactTypeEnum(),
                size: SeniorSpacing.medium,
              ),
              const SizedBox(
                width: SeniorSpacing.small,
              ),
              SeniorText.body(
                fullPhone!,
                color: SeniorColors.neutralColor800,
              ),
              const Expanded(
                child: SizedBox.shrink(),
              ),
              SeniorIconButton(
                disabled: false,
                icon: FontAwesomeIcons.solidPen,
                size: SeniorIconButtonSize.small,
                style: SeniorIconButtonStyle(
                  iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                      ? SeniorColors.pureWhite
                      : SeniorColors.secondaryColor600,
                  borderColor: Colors.transparent,
                  disabledBorderColor: Colors.transparent,
                  buttonColor: Colors.transparent,
                ),
                onTap: () {
                  editPhone(
                    context: context,
                    phone: widget.phone,
                  );
                },
                type: SeniorIconButtonType.ghost,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                ),
                child: SeniorIconButton(
                  icon: FontAwesomeIcons.solidTrash,
                  size: SeniorIconButtonSize.small,
                  style: SeniorIconButtonStyle(
                    iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                        ? SeniorColors.pureWhite
                        : SeniorColors.secondaryColor600,
                    borderColor: Colors.transparent,
                    buttonColor: Colors.transparent,
                  ),
                  onTap: () {
                    _deletePhone(context);
                  },
                  type: SeniorIconButtonType.ghost,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: SeniorSpacing.xbig,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.small(
                    context.translate.type,
                    color: SeniorColors.neutralColor500,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xxsmall,
                  ),
                  SeniorText.small(
                    EnumPhoneContactTypeStringFormatter.phoneContactTypeEnumToValue(
                      phoneContactTypeEnum: widget.phone.content.type!,
                      appLocalizations: context.translate,
                    ),
                    color: SeniorColors.neutralColor800,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void editPhone({required BuildContext context, required ContactEntity<PhoneContactEntity> phone}) {
    List<SeniorDropdownButtonItem> selectedType = [];
    selectedType.add(
      SeniorDropdownButtonItem(
        value: widget.phone.content.type!,
        title: EnumPhoneContactTypeStringFormatter.phoneContactTypeEnumToValue(
          phoneContactTypeEnum: PhoneContactTypeEnum.values.where((e) => e == widget.phone.content.type!).first,
          appLocalizations: context.translate,
        ),
      ),
    );

    SeniorBottomSheet.showBottomSheet(
      title: context.translate.addPhone,
      height: context.bottomSheetSizeContacts,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: InputPhoneContactsBottomSheetContentWidget(
            dropdownItemList: selectedType,
            phone: phone,
            typeEdit: phone.typeEdit == null ? 'UPDATE' : 'CREATE',
            dropdownItemDescription: context.translate.type,
            primaryButtonPressed: (newValue) {
              widget.onEditPhone(newValue, phone);

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

  IconData getIconPhoneContactTypeEnum() {
    switch (widget.phone.content.type) {
      case PhoneContactTypeEnum.professional:
        return FontAwesomeIcons.solidHeadset;
      case PhoneContactTypeEnum.mobile:
        return FontAwesomeIcons.solidMobileScreenButton;
      default:
        return FontAwesomeIcons.solidSquarePhoneFlip;
    }
  }

  void _deletePhone(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deletePhone,
          content: context.translate.alertCancelFormDescription,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () => Modular.to.pop(),
          ),
          otherAction: SeniorModalAction(
            label: context.translate.delete,
            action: () {
              widget.onDeletePhone(widget.phone);
              Modular.to.pop();
            },
            danger: true,
          ),
        );
      },
    );
  }
}
