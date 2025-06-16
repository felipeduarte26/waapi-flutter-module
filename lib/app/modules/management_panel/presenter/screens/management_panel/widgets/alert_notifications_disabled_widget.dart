import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';

class AlertNotificationsDisabledWidget extends StatelessWidget {
  final Function() onOpenSettings;

  const AlertNotificationsDisabledWidget({
    Key? key,
    required this.onOpenSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeRepository>(context, listen: false).theme.bottomSheetTheme!.style!.backgroundColor,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SeniorGradientIcon(
                icon: FontAwesomeIcons.solidBell,
                sizeIcon: 60,
              ),
              const SizedBox(
                height: SeniorSpacing.xxxsmall,
              ),
              Padding(
                padding: const EdgeInsets.all(SeniorSpacing.normal),
                child: SeniorText.h4(
                  context.translate.alertActivateNotificationsTitle,
                  textProperties: const TextProperties(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  color: SeniorColors.secondaryColor900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: SeniorText.body(
                  context.translate.alertActivateNotificationsDescription,
                  color: SeniorColors.secondaryColor600,
                  textProperties: const TextProperties(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: SeniorMenuItemList(
                  title: _getStepOneText(
                    context: context,
                  ),
                  titleMaxLines: 2,
                  style: const SeniorMenuListItemStyle(
                    titleColor: SeniorColors.secondaryColor600,
                  ),
                  leading: const SeniorIcon(
                    icon: FontAwesomeIcons.solidGear,
                    size: SeniorSpacing.medium,
                  ),
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: SeniorMenuItemList(
                  title: _getStepTwoText(
                    context: context,
                  ),
                  titleMaxLines: 2,
                  style: const SeniorMenuListItemStyle(
                    titleColor: SeniorColors.secondaryColor600,
                  ),
                  leading: const SeniorIcon(
                    icon: FontAwesomeIcons.solidBell,
                    size: SeniorSpacing.medium,
                  ),
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: SeniorMenuItemList(
                  title: _getStepThreeText(
                    context: context,
                  ),
                  titleMaxLines: 2,
                  style: const SeniorMenuListItemStyle(
                    titleColor: SeniorColors.secondaryColor600,
                  ),
                  leading: const SeniorIcon(
                    icon: FontAwesomeIcons.toggleOn,
                    size: SeniorSpacing.medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SeniorSpacing.normal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SeniorButton(
              label: _getButtonText(
                context: context,
              ),
              fullWidth: true,
              onPressed: onOpenSettings,
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            SeniorButton.ghost(
              label: context.translate.notNow,
              fullWidth: true,
              onPressed: Modular.to.pop,
            ),
            SizedBox(
              height: context.bottomSize,
            ),
          ],
        ),
      ),
    );
  }

  String _getStepOneText({
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return context.translate.stepOneEnableNotificationsIOS;
    }
    return context.translate.stepOneEnableNotificationsAndroid;
  }

  String _getStepTwoText({
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return context.translate.stepTwoEnableNotificationsIOS;
    }
    return context.translate.stepTwoEnableNotificationsAndroid;
  }

  String _getStepThreeText({
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return context.translate.stepThreeEnableNotificationsIOS;
    }
    return context.translate.stepThreeEnableNotificationsAndroid;
  }

  String _getButtonText({
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return context.translate.openSettingsIOS;
    }
    return context.translate.openSettingsAndroid;
  }
}
