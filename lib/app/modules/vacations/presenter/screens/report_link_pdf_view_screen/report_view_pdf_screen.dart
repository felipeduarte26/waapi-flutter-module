import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_event.dart';
import '../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';

class ReportViewPdfScreen extends StatefulWidget {
  final String filePath;
  final String title;

  const ReportViewPdfScreen({
    Key? key,
    required this.filePath,
    required this.title,
  }) : super(key: key);

  @override
  State<ReportViewPdfScreen> createState() => _ReportViewPdfScreenState();
}

class _ReportViewPdfScreenState extends State<ReportViewPdfScreen> {
  late AttachmentBloc _attachmentBloc;

  @override
  void initState() {
    _attachmentBloc = Modular.get<AttachmentBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentBloc, AttachmentState>(
      bloc: _attachmentBloc,
      listener: (context, state) {
        if (state is ErrorNativePermissionStorageState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.errorPermissionStorage,
            ),
          );
        }

        if (state is ErrorShareDetailsReceivedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.errorPermissionGallery,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: WaapiColorfulHeader(
            style: const SeniorColorfulHeaderStructureStyle(
              bodyColor: SeniorColors.secondaryColor300,
            ),
            titleLabel: widget.title,
            body: Column(
              children: [
                Expanded(
                  child: PDFView(
                    filePath: widget.filePath,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    fitEachPage: true,
                    pageSnap: true,
                  ),
                ),
                EmployeeBottomSheetWidget(
                  horizontalPadding: false,
                  seniorButtons: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: SeniorSpacing.normal,
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                      ),
                      child: SeniorButton(
                        busy: (state is LoadingAttachmentState),
                        disabled: (state is LoadingAttachmentState),
                        label: context.translate.sharePdf,
                        onPressed: () {
                          _attachmentBloc.add(
                            ShareFileReceivedEvent(
                              fileToShare: widget.filePath,
                            ),
                          );
                        },
                        fullWidth: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
