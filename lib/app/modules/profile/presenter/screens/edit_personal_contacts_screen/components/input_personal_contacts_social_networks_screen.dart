import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../domain/entities/contact_entity.dart';
import '../../../../domain/entities/social_network_entity.dart';
import '../../../widgets/list_social_networks_widget.dart';
import 'input_social_network_bottom_sheet_content_widget.dart';

class InputPersonalContactsSocialNetworksScreen extends StatelessWidget {
  final List<ContactEntity<SocialNetworkEntity>> socialNetworksContacts;
  final ValueChanged<ContactEntity<SocialNetworkEntity>> onInsertSocialNetwork;
  final Function(
    ContactEntity<SocialNetworkEntity> newValue,
    ContactEntity<SocialNetworkEntity> oldValue,
  ) onEditSocialNetwork;
  final ValueChanged<ContactEntity<SocialNetworkEntity>> onDeleteSocialNetwork;

  const InputPersonalContactsSocialNetworksScreen({
    Key? key,
    required this.socialNetworksContacts,
    required this.onInsertSocialNetwork,
    required this.onEditSocialNetwork,
    required this.onDeleteSocialNetwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
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
              context.translate.socialNetworks,
            ),
            const SizedBox(
              height: SeniorSpacing.medium,
            ),
            if (socialNetworksContacts.isEmpty)
              SeniorCard(
                style: SeniorCardStyle(
                  backgroundColor: themeRepository.isDarkTheme()
                      ? themeRepository.theme.cardTheme!.style!.backgroundColor
                      : isCustomTheme
                          ? SeniorColors.pureWhite
                          : SeniorColors.secondaryColor100,
                ),
                withElevation: isCustomTheme,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SeniorSpacing.xsmall,
                      ),
                      child: SeniorIcon(
                        icon: FontAwesomeIcons.solidFileLines,
                        size: SeniorSpacing.big,
                      ),
                    ),
                    SeniorText.body(
                      context.translate.noSocialNetworksRegistered,
                      color: SeniorColors.neutralColor900,
                    ),
                  ],
                ),
              ),
            if (socialNetworksContacts.isNotEmpty)
              ListSocialNetworksWidget(
                socialNetworksContacts: socialNetworksContacts,
                onDeleteSocialNetwork: onDeleteSocialNetwork,
                onEditSocialNetwork: onEditSocialNetwork,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: Center(
                child: SeniorButton(
                  icon: FontAwesomeIcons.solidPlus,
                  label: context.translate.addSocialNetwork,
                  outlined: true,
                  fullWidth: true,
                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                  onPressed: () {
                    addSocialNetwork(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addSocialNetwork(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.addSocialNetwork,
      height: context.bottomSheetSize,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: InputSocialNetworkBottomSheetContentWidget(
            primaryButtonPressed: (contactEntity) {
              onInsertSocialNetwork(contactEntity);
              Modular.to.pop();
            },
            secondaryButtonPressed: () {
              Modular.to.pop();
            },
            typeEdit: 'CREATE',
          ),
        ),
      ],
    );
  }
}
