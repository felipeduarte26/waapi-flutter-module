import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../edit_personal_documents_controllers.dart';

class EditPersonalDocumentsReservistCertificateScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsReservistCertificateScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsReservistCertificateScreen> createState() {
    return _EditPersonalDocumentsReservistCertificateScreenState();
  }
}

class _EditPersonalDocumentsReservistCertificateScreenState
    extends State<EditPersonalDocumentsReservistCertificateScreen> {
  FocusNode cdiNumberFocus = FocusNode();
  FocusNode cdiCategoryFocusFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.small,
              ),
              child: SeniorText.h4(
                context.translate.cdi,
              ),
            ),
            SeniorTextField(
              focusNode: cdiNumberFocus,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(cdiCategoryFocusFocus);
              },
              maxLength: 13,
              onChanged: (value) {
                setState(() {});
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentReservistNumber ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: widget.editPersonalDocumentsControllers.cdiNumberController,
              label: context.translate.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.small,
              ),
              child: SeniorTextField(
                focusNode: cdiCategoryFocusFocus,
                onChanged: (value) {
                  setState(() {});
                },
                disabled: !(widget.authEntity?.allowToUpdateDocumentReservistCategory ?? true),
                controller: widget.editPersonalDocumentsControllers.cdiCategoryController,
                label: context.translate.category,
              ),
            ),
            SeniorButton(
              outlined: true,
              style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
              disabled: deleteButtonIsEnable(),
              busy: false,
              fullWidth: true,
              label: context.translate.deleteDocument,
              onPressed: () async {
                await confirmDeletionReservist();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmDeletionReservist() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteCDI,
          content: context.translate.deleteMessageDocument,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () => Modular.to.pop(),
          ),
          otherAction: SeniorModalAction(
            label: context.translate.erase,
            action: () async {
              Modular.to.pop();
              await widget.editPersonalDocumentsControllers.clearReservistCertificate();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return widget.editPersonalDocumentsControllers.cdiNumberController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.cdiCategoryController.text.isEmpty;
  }
}
