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
import '../../../../domain/entities/email_entity.dart';
import '../../../widgets/list_emails_widget.dart';
import 'input_email_bottom_sheet_content_widget.dart';

class InputPersonalContactsEmailsScreen extends StatelessWidget {
  final List<ContactEntity<EmailEntity>> emails;
  final ValueChanged<ContactEntity<EmailEntity>> onInsertEmail;
  final Function(
    ContactEntity<EmailEntity> newValue,
    ContactEntity<EmailEntity> oldValue,
  ) onEditEmail;
  final ValueChanged<ContactEntity<EmailEntity>> onDeleteEmail;
  final bool allowToUpdateContactEmployeeEmail;

  const InputPersonalContactsEmailsScreen({
    super.key,
    required this.emails,
    required this.onInsertEmail,
    required this.onEditEmail,
    required this.onDeleteEmail,
    required this.allowToUpdateContactEmployeeEmail,
  });

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
              context.translate.emails,
            ),
            const SizedBox(
              height: SeniorSpacing.medium,
            ),
            if (emails.isEmpty)
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
                      context.translate.noEmailRegistered,
                      color: SeniorColors.neutralColor900,
                    ),
                  ],
                ),
              ),
            if (emails.isNotEmpty)
              ListEmailsWidget(
                emails: emails,
                onDeleteEmail: onDeleteEmail,
                onEditEmail: onEditEmail,
                allowToUpdateContactEmployeeEmail: allowToUpdateContactEmployeeEmail,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: Center(
                child: SeniorButton(
                  icon: FontAwesomeIcons.solidPlus,
                  label: context.translate.addEmail,
                  outlined: true,
                  style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                  fullWidth: true,
                  onPressed: () {
                    addEmail(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addEmail(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.addEmail,
      height: context.bottomSheetSize,
      context: context,
      hasCloseButton: true,
      onTapCloseButton: Modular.to.pop,
      content: <Widget>[
        Expanded(
          child: InputEmailBottomSheetContentWidget(
            primaryButtonPressed: (contactEntity) {
              onInsertEmail(contactEntity);
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
