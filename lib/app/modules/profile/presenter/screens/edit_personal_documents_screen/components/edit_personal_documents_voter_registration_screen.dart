import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../edit_personal_documents_controllers.dart';

class EditPersonalDocumentsVoterRegistrationScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsVoterRegistrationScreen({
    super.key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  });

  @override
  State<EditPersonalDocumentsVoterRegistrationScreen> createState() {
    return _EditPersonalDocumentsVoterRegistrationScreenState();
  }
}

class _EditPersonalDocumentsVoterRegistrationScreenState extends State<EditPersonalDocumentsVoterRegistrationScreen> {
  FocusNode voterNumberFocus = FocusNode();
  FocusNode voterSectionFocus = FocusNode();
  FocusNode voterZoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeniorText.h4(
              context.translate.voterRegistrationCard,
            ),
            const SizedBox(
              height: SeniorSpacing.normal,
            ),
            SeniorTextField(
              focusNode: voterNumberFocus,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(voterSectionFocus);
              },
              onChanged: (value) {
                setState(() {});
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentVoterNumber ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.editPersonalDocumentsControllers.voterNumberController,
              label: context.translate.number,
              maxLength: 13,
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            SeniorTextField(
              focusNode: voterSectionFocus,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(voterZoneFocus);
              },
              onChanged: (value) {
                setState(() {});
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentVoterSection ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.editPersonalDocumentsControllers.voterSectionController,
              label: context.translate.section,
              maxLength: 4,
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            SeniorTextField(
              focusNode: voterZoneFocus,
              onChanged: (value) {
                setState(() {});
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentVoterZone ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.editPersonalDocumentsControllers.voterZoneController,
              label: context.translate.zone,
              maxLength: 3,
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            SeniorButton(
              outlined: true,
              style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
              disabled: deleteButtonIsEnable(),
              busy: false,
              fullWidth: true,
              label: context.translate.deleteDocument,
              onPressed: () async {
                await confirmDeletionVoterRegistration();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmDeletionVoterRegistration() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteVoterRegistration,
          content: context.translate.deleteMessageDocument,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () {
              Modular.to.pop();
            },
          ),
          otherAction: SeniorModalAction(
            label: context.translate.erase,
            action: () async {
              Modular.to.pop();
              await widget.editPersonalDocumentsControllers.clearVoterRegistration();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return widget.editPersonalDocumentsControllers.voterNumberController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.voterSectionController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.voterZoneController.text.isEmpty;
  }
}
