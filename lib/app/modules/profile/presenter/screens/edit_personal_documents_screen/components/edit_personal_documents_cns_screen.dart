// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../edit_personal_documents_controllers.dart';

class EditPersonalDocumentsCnsScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsCnsScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsCnsScreen> createState() {
    return _EditPersonalDocumentsCnsScreenState();
  }
}

class _EditPersonalDocumentsCnsScreenState extends State<EditPersonalDocumentsCnsScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.h4(
                    context.translate.cns,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.normal,
                      bottom: SeniorSpacing.small,
                    ),
                    child: SeniorTextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      maxLength: 16,
                      disabled: !(widget.authEntity?.allowToUpdateDocumentCnsNumber ?? true),
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: widget.editPersonalDocumentsControllers.cnsNumberController,
                      label: context.translate.number,
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
                      await confirmDeletionCNS();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmDeletionCNS() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteCNS,
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
              await widget.editPersonalDocumentsControllers.clearCNS();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return widget.editPersonalDocumentsControllers.cnsNumberController.text.isEmpty;
  }
}
