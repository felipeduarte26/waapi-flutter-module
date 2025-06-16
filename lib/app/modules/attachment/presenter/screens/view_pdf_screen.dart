// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../core/extension/translate_extension.dart';

import '../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../blocs/attachment_bloc/attachment_bloc.dart';
import '../blocs/attachment_bloc/attachment_event.dart';
import '../blocs/attachment_bloc/attachment_state.dart';

class ViewPdfScreen extends StatefulWidget {
  final String filePath;
  final String title;
  final AnalyticsEventEnum pdfErrorAnalytics;
  final AnalyticsEventEnum pdfSharedAnalytics;

  const ViewPdfScreen({
    Key? key,
    required this.filePath,
    required this.title,
    required this.pdfErrorAnalytics,
    required this.pdfSharedAnalytics,
  }) : super(key: key);

  @override
  State<ViewPdfScreen> createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  late AttachmentBloc _attachmentBloc;
  bool isRender = false;

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
            onTapBack: onTapBack,
            titleLabel: widget.title,
            body: Stack(
              children: [
                Offstage(
                  offstage: !isRender,
                  child: Column(
                    children: [
                      Expanded(
                        child: PDFView(
                          filePath: widget.filePath,
                          enableSwipe: true,
                          autoSpacing: false,
                          pageFling: true,
                          fitEachPage: true,
                          pageSnap: true,
                          onRender: (_) {
                            setState(() {
                              isRender = true;
                            });
                          },
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
                Offstage(
                  offstage: isRender,
                  child: const WaapiLoadingWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onTapBack() {
    Modular.to.pop();
  }
}
