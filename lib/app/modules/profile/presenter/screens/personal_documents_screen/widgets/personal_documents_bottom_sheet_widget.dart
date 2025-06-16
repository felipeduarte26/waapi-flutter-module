import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../../routes/profile_routes.dart';
import '../../../../enums/document_type_enum.dart';
import 'document_checkbox_widget.dart';

class PersonalDocumentsBottomSheetWidget extends StatefulWidget {
  final Map<DocumentTypeEnum, bool> documents;

  const PersonalDocumentsBottomSheetWidget({
    Key? key,
    required this.documents,
  }) : super(key: key);

  @override
  State<PersonalDocumentsBottomSheetWidget> createState() {
    return _PersonalDocumentsBottomSheetWidgetState();
  }
}

class _PersonalDocumentsBottomSheetWidgetState extends State<PersonalDocumentsBottomSheetWidget> {
  bool confirmButtonIsDisable = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: SeniorSpacing.normal,
        ),
        child: Scaffold(
          backgroundColor: Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor,
          body: Scrollbar(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: SeniorSpacing.normal,
                    ),
                  ),
                  DocumentCheckboxWidget(
                    documents: widget.documents,
                    thereAreDocumentsSelected: ({isSelected = false}) {
                      confirmButtonIsDisable = isSelected;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: EmployeeBottomSheetWidget(
            horizontalPadding: false,
            key: const Key('profile-personal_documents_screen-bottom_sheet'),
            seniorButtons: [
              Padding(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  key: const Key('profile-personal_documents_screen-bottom_sheet-button-send_competency'),
                  fullWidth: true,
                  label: context.translate.confirm,
                  onPressed: () async {
                    Modular.to.pop();
                    await Modular.to.pushNamed(
                      ProfileRoutes.editPersonalDocumentsScreenInitialRoute,
                      arguments: widget.documents,
                    );
                  },
                  disabled: !confirmButtonIsDisable,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                  top: SeniorSpacing.normal,
                ),
                child: SeniorButton.ghost(
                  key: const Key('profile-personal_documents_screen-bottom_sheet-button-option_cancel'),
                  fullWidth: true,
                  label: context.translate.optionCancel,
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
