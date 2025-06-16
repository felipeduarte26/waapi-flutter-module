import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/icons_helper.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/entities/social_network_entity.dart';
import '../../enums/social_network_provider_enum.dart';
import '../screens/edit_personal_contacts_screen/components/input_social_network_bottom_sheet_content_widget.dart';
import '../string_formatters/enum_social_network_provider_string_formatter.dart';

class ShowSocialNetworkWidget extends StatefulWidget {
  final ContactEntity<SocialNetworkEntity> socialNetworkContact;
  final Function(
    ContactEntity<SocialNetworkEntity> newValue,
    ContactEntity<SocialNetworkEntity> oldValue,
  ) onEditSocialNetwork;
  final ValueChanged<ContactEntity<SocialNetworkEntity>> onDeleteSocialNetwork;

  const ShowSocialNetworkWidget({
    super.key,
    required this.socialNetworkContact,
    required this.onEditSocialNetwork,
    required this.onDeleteSocialNetwork,
  });

  @override
  State<ShowSocialNetworkWidget> createState() {
    return _ShowSocialNetworkWidgetState();
  }
}

class _ShowSocialNetworkWidgetState extends State<ShowSocialNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      showActionIcon: false,
      child: Column(
        children: [
          Row(
            children: [
              SeniorIcon(
                icon: IconsHelper.socialNetworkIcon(
                  socialNetwork: widget.socialNetworkContact.content.socialNetwork!,
                )!,
                size: SeniorIconSize.medium,
              ),
              const SizedBox(
                width: SeniorSpacing.normal,
              ),
              Expanded(
                child: SeniorText.body(
                  widget.socialNetworkContact.content.profile ?? '',
                  textProperties: const TextProperties(
                    overflow: TextOverflow.ellipsis,
                  ),
                  color: SeniorColors.neutralColor800,
                ),
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
                  editSocialNetwork(
                    contactEntity: widget.socialNetworkContact,
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
                    _deleteSocialNetwork(context);
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
                    context.translate.socialNetwork,
                    color: SeniorColors.neutralColor500,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xxsmall,
                  ),
                  SeniorText.small(
                    EnumSocialNetworkProviderStringFormatter.getStringSocialNetwork(
                      socialNetworkProviderEnum:
                          widget.socialNetworkContact.content.socialNetwork ?? SocialNetworkProviderEnum.other,
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

  void editSocialNetwork({
    required BuildContext context,
    required ContactEntity<SocialNetworkEntity> contactEntity,
  }) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.addSocialNetwork,
      height: context.bottomSheetSizeContacts,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: InputSocialNetworkBottomSheetContentWidget(
            primaryButtonPressed: (newContactEntity) {
              widget.onEditSocialNetwork(newContactEntity, contactEntity);
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

  void _deleteSocialNetwork(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteSocialNetwork,
          content: context.translate.alertCancelFormDescription,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () => Modular.to.pop(),
          ),
          otherAction: SeniorModalAction(
            label: context.translate.delete,
            action: () {
              widget.onDeleteSocialNetwork(widget.socialNetworkContact);
              Modular.to.pop();
            },
            danger: true,
          ),
        );
      },
    );
  }
}
