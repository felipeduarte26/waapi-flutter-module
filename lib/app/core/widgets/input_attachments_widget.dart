import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../modules/attachment/domain/entities/attachment_entity.dart';
import '../../modules/attachment/presenter/blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../../modules/attachment/presenter/widgets/waapi_management_panel_uploader_widget.dart';
import 'warnings_panel_widget.dart';

class InputAttachmentsWidget extends StatefulWidget {
  final List<AttachmentEntity>? attachments;
  final bool isRequestVacationUpdate;
  final bool isRequiredAttachments;
  final WaapiManagementPanelUploaderBloc panelUploaderBloc;
  final String header;

  const InputAttachmentsWidget({
    Key? key,
    this.attachments,
    this.isRequestVacationUpdate = false,
    this.isRequiredAttachments = false,
    required this.panelUploaderBloc,
    required this.header,
  }) : super(key: key);

  @override
  State<InputAttachmentsWidget> createState() {
    return _InputAttachmentsWidgetState();
  }
}

class _InputAttachmentsWidgetState extends State<InputAttachmentsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
              left: SeniorSpacing.normal,
              right: SeniorSpacing.normal,
            ),
            child: SeniorText.h4(
              widget.header,
            ),
          ),
          WarningsPanelWidget(
            isRequiredAttachments: widget.isRequiredAttachments,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: WaapiManagementPanelUploaderWidget(
              panelUploaderBloc: widget.panelUploaderBloc,
              isRequestVacationUpdate: widget.isRequestVacationUpdate,
              attachments: widget.attachments,
              reading: false,
            ),
          ),
        ],
      ),
    );
  }
}
