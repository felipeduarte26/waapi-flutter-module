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
import '../../domain/entities/email_entity.dart';
import '../../enums/email_type_enum.dart';
import '../screens/edit_personal_contacts_screen/components/input_email_bottom_sheet_content_widget.dart';
import '../string_formatters/enum_email_type_string_formatter.dart';

class ShowEmailWidget extends StatefulWidget {
  final ContactEntity<EmailEntity> emailContact;
  final Function(
    ContactEntity<EmailEntity> newValue,
    ContactEntity<EmailEntity> oldValue,
  ) onEditEmail;
  final ValueChanged<ContactEntity<EmailEntity>> onDeleteEmail;
  final bool allowToUpdateContactEmployeeEmail;

  const ShowEmailWidget({
    super.key,
    required this.emailContact,
    required this.onEditEmail,
    required this.onDeleteEmail,
    required this.allowToUpdateContactEmployeeEmail,
  });

  @override
  State<ShowEmailWidget> createState() {
    return _ShowEmailWidgetState();
  }
}

class _ShowEmailWidgetState extends State<ShowEmailWidget> {
  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return WaapiCardWidget(
      showActionIcon: false,
      child: Column(
        children: [
          Row(
            children: [
              const SeniorIcon(
                icon: FontAwesomeIcons.solidEnvelope,
                size: SeniorSpacing.normal,
              ),
              const SizedBox(
                width: SeniorSpacing.normal,
              ),
              SizedBox(
                width: 200,
                child: SeniorText.body(
                  widget.emailContact.content.email ?? '',
                  color: SeniorColors.neutralColor800,
                  textProperties: const TextProperties(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox.shrink(),
              ),
              SeniorIconButton(
                disabled: !widget.allowToUpdateContactEmployeeEmail &&
                    widget.emailContact.content.type != EmailTypeEnum.personal,
                icon: FontAwesomeIcons.solidPen,
                size: SeniorIconButtonSize.small,
                style: SeniorIconButtonStyle(
                  iconColor: themeRepository.isDarkTheme() ? SeniorColors.pureWhite : SeniorColors.secondaryColor600,
                  borderColor: Colors.transparent,
                  disabledBorderColor: Colors.transparent,
                  buttonColor: Colors.transparent,
                  disabledIconColor: getDisabledColor(themeRepository),
                ),
                onTap: () {
                  editEmail(
                    contactEntity: widget.emailContact,
                    context: context,
                  );
                },
                type: SeniorIconButtonType.ghost,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                ),
                child: SeniorIconButton(
                  disabled: !widget.allowToUpdateContactEmployeeEmail &&
                      widget.emailContact.content.type != EmailTypeEnum.personal,
                  icon: FontAwesomeIcons.solidTrash,
                  size: SeniorIconButtonSize.small,
                  style: SeniorIconButtonStyle(
                    iconColor: themeRepository.isDarkTheme() ? SeniorColors.pureWhite : SeniorColors.secondaryColor600,
                    borderColor: Colors.transparent,
                    disabledBorderColor: Colors.transparent,
                    buttonColor: Colors.transparent,
                    disabledIconColor: getDisabledColor(themeRepository),
                  ),
                  onTap: () {
                    _deleteEmail(context);
                  },
                  type: SeniorIconButtonType.ghost,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: SeniorSpacing.big,
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
                    EnumEmailTypeStringFormatter.getEmailTypeString(
                      emailTypeEnum: widget.emailContact.content.type ?? EmailTypeEnum.professional,
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

  void editEmail({
    required BuildContext context,
    required ContactEntity<EmailEntity> contactEntity,
  }) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.addEmail,
      height: context.bottomSheetSizeContacts,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: InputEmailBottomSheetContentWidget(
            primaryButtonPressed: (newContactEntity) {
              widget.onEditEmail(newContactEntity, contactEntity);
              Modular.to.pop();
            },
            secondaryButtonPressed: () {
              Modular.to.pop();
            },
            contactEntity: contactEntity,
            typeEdit: contactEntity.typeEdit == null ? 'UPDATE' : 'CREATE',
          ),
        ),
      ],
    );
  }

  Color? getDisabledColor(ThemeRepository themeRepository) {
    const opacity = 0.3;
    return themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor!.withOpacity(opacity) : null;
  }

  void _deleteEmail(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteEmail,
          content: context.translate.alertCancelFormDescription,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () => Modular.to.pop(),
          ),
          otherAction: SeniorModalAction(
            label: context.translate.delete,
            action: () {
              widget.onDeleteEmail(widget.emailContact);
              Modular.to.pop();
            },
            danger: true,
          ),
        );
      },
    );
  }
}
