import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../edit_dependents_controller.dart';
import '../widgets/edit_dependents_birth_certificate_widget.dart';
import '../widgets/edit_dependents_death_certificate_widget.dart';
import '../widgets/edit_dependents_rg_widget.dart';

class InputDocumentsScreen extends StatefulWidget {
  final EditDependentsController editDependentsController;
  final VoidCallback onValueChanged;

  const InputDocumentsScreen({
    Key? key,
    required this.editDependentsController,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<InputDocumentsScreen> createState() => _InputDocumentsScreenState();
}

class _InputDocumentsScreenState extends State<InputDocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditDependentsBirthCertificateWidget(
              onValueChanged: () {
                setState(() {});
              },
              editDependentsController: widget.editDependentsController,
            ),
            EditDependentsRgWidget(
              editDependentsController: widget.editDependentsController,
            ),
            EditDependentsDeathCertificateWidget(
              onValueChanged: () {
                setState(() {});
              },
              editDependentsController: widget.editDependentsController,
            ),
          ],
        ),
      ),
    );
  }
}
