import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/clipboard_helper.dart';
import '../../../../../../core/helper/icons_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/email_entity.dart';
import '../../../../domain/entities/phone_contact_entity.dart';
import '../../../../domain/entities/social_network_entity.dart';
import '../../../../enums/email_type_enum.dart';
import '../../../../enums/phone_contact_type_enum.dart';
import '../../../../enums/social_network_provider_enum.dart';
import '../../../../helper/phone_contact_helper.dart';
import '../../../string_formatters/enum_email_type_string_formatter.dart';
import '../../../string_formatters/enum_phone_contact_type_string_formatter.dart';
import '../../../string_formatters/enum_social_network_provider_string_formatter.dart';

class PersonalContactCardWidget extends StatefulWidget {
  final PhoneContactEntity? phoneContactEntity;
  final EmailEntity? emailEntity;
  final SocialNetworkEntity? socialNetworkEntity;
  final int entityIndex;
  final int entityQuantity;

  const PersonalContactCardWidget({
    Key? key,
    this.emailEntity,
    this.phoneContactEntity,
    this.socialNetworkEntity,
    required this.entityIndex,
    required this.entityQuantity,
  }) : super(key: key);

  @override
  State<PersonalContactCardWidget> createState() {
    return _PersonalContactCardWidgetState();
  }
}

class _PersonalContactCardWidgetState extends State<PersonalContactCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.normal,
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
      ),
      child: WaapiCardWidget(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        showActionIcon: false,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.xsmall,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SeniorIcon(
                    icon: iconCard() ?? Icons.person,
                    size: SeniorSpacing.medium,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  Expanded(
                    child: SeniorText.body(
                      getPhoneOrEmailOrSocialNetwork(),
                      color: SeniorColors.neutralColor800,
                      textProperties: const TextProperties(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SeniorIconButton(
                    disabled: false,
                    icon: FontAwesomeIcons.solidCopy,
                    onTap: () async {
                      final phoneOrEmailOrsocialNetwork = getPhoneOrEmailOrSocialNetwork();
                      if (phoneOrEmailOrsocialNetwork.isNotEmpty) {
                        ClipboardHelper.copy(value: phoneOrEmailOrsocialNetwork);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.message(
                            message: successCopyMessage(context: context),
                          ),
                        );
                      }
                    },
                    size: SeniorIconButtonSize.big,
                    type: SeniorIconButtonType.ghost,
                    outlined: false,
                    style: SeniorIconButtonStyle(
                      borderColor: Colors.transparent,
                      iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                          ? SeniorColors.pureWhite
                          : SeniorColors.secondaryColor600,
                      disabledBorderColor: Colors.transparent,
                      disabledIconColor: SeniorColors.neutralColor300,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              DocumentItemWidget(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.big,
                  bottom: SeniorSpacing.xsmall,
                ),
                crossAxisAlignment: CrossAxisAlignment.start,
                title: context.translate.type,
                items: [
                  typeFromString(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPhoneOrEmailOrSocialNetwork() {
    if (widget.phoneContactEntity != null) {
      final fullPhone = PhoneContactHelper.getFullPhone(
        phoneContact: widget.phoneContactEntity!,
      );
      return fullPhone ?? '';
    } else if (widget.emailEntity != null) {
      return widget.emailEntity!.email!;
    } else if (widget.socialNetworkEntity != null) {
      return widget.socialNetworkEntity!.profile!;
    } else {
      return '';
    }
  }

  String typeFromString(BuildContext context) {
    if (widget.phoneContactEntity != null && widget.phoneContactEntity?.type != null) {
      return EnumPhoneContactTypeStringFormatter.phoneContactTypeEnumToValue(
        phoneContactTypeEnum:
            widget.phoneContactEntity?.type == null ? PhoneContactTypeEnum.mobile : widget.phoneContactEntity!.type!,
        appLocalizations: context.translate,
      );
    } else if (widget.emailEntity != null) {
      return EnumEmailTypeStringFormatter.getEmailTypeString(
        emailTypeEnum: widget.emailEntity?.type == null ? EmailTypeEnum.professional : widget.emailEntity!.type!,
        appLocalizations: context.translate,
      );
    } else if (widget.socialNetworkEntity != null && widget.socialNetworkEntity?.socialNetwork != null) {
      return EnumSocialNetworkProviderStringFormatter.getStringSocialNetwork(
        socialNetworkProviderEnum: widget.socialNetworkEntity?.socialNetwork == null
            ? SocialNetworkProviderEnum.other
            : widget.socialNetworkEntity!.socialNetwork!,
        appLocalizations: context.translate,
      );
    } else {
      return '';
    }
  }

  String successCopyMessage({required BuildContext context}) {
    if (widget.phoneContactEntity != null) {
      return context.translate.phoneNumberCopiedSuccessfully;
    } else if (widget.emailEntity != null) {
      return context.translate.emailAddressCopiedSuccessfully;
    } else if (widget.socialNetworkEntity != null) {
      return context.translate.userCopiedSuccessfully;
    } else {
      return '';
    }
  }

  IconData? iconCard() {
    if (widget.phoneContactEntity != null) {
      return iconPhoneContact();
    } else if (widget.emailEntity != null) {
      return FontAwesomeIcons.solidEnvelope;
    } else if (widget.socialNetworkEntity != null) {
      return IconsHelper.socialNetworkIcon(
        socialNetwork: widget.socialNetworkEntity!.socialNetwork!,
      );
    } else {
      return null;
    }
  }

  IconData? iconPhoneContact() {
    switch (widget.phoneContactEntity!.type) {
      case PhoneContactTypeEnum.mobile:
        return FontAwesomeIcons.solidMobileScreenButton;
      case PhoneContactTypeEnum.personal:
        return FontAwesomeIcons.solidSquarePhone;
      case PhoneContactTypeEnum.professional:
        return FontAwesomeIcons.solidHeadset;
      default:
        return null;
    }
  }
}
