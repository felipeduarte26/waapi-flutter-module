import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../helper/cpf_validator_help.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../edit_personal_documents_controllers.dart';

class EditPersonalDocumentsCpfScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsCpfScreen({
    super.key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  });

  @override
  State<EditPersonalDocumentsCpfScreen> createState() {
    return _EditPersonalDocumentsCpfScreenState();
  }
}

class _EditPersonalDocumentsCpfScreenState extends State<EditPersonalDocumentsCpfScreen> {
  @override
  void initState() {
    super.initState();
    widget.editPersonalDocumentsControllers.cpfController.text = CpfValidatorHelp.format(
      CpfValidatorHelp.strip(
        widget.editPersonalDocumentsControllers.cpfController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                context.translate.cpf,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                  top: SeniorSpacing.normal,
                ),
                child: SeniorText.body(
                  '* ${context.translate.mandatoryItem}',
                  color: SeniorColors.neutralColor600,
                ),
              ),
              SeniorTextField(
                onChanged: (value) {
                  setState(() {});
                },
                disabled: !(widget.authEntity?.allowToUpdateDocumentCpf ?? true),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  SeniorMaskTextInputHelper(
                    initialText: widget.editPersonalDocumentsControllers.cpfController.text,
                    mask: '###.###.###-##',
                    filter: {'#': RegExp(r'[0-9]')},
                    type: SeniorMaskAutoCompletionType.lazy,
                  ),
                ],
                controller: widget.editPersonalDocumentsControllers.cpfController,
                label: '${context.translate.cpfNumber} *',
                validator: (value) {
                  if (CpfValidatorHelp.isValid(value)) {
                    return null;
                  }
                  return context.translate.invalidCpfNumber;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
