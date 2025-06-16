import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../blocs/attachment_bloc/attachment_bloc.dart';
import '../blocs/attachment_bloc/attachment_event.dart';
import '../blocs/attachment_bloc/attachment_state.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_event.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import 'loading_attachment_card_widget.dart';

class AttachmentCardWidget extends StatefulWidget {
  final ImageProvider imageProvider;
  final Function()? delete;
  final String fileName;
  final String fileSize;
  final double? width;
  final double? height;
  final bool reload;
  final bool reading;
  final String extension;
  final File? file;
  final bool shareable;
  final WaapiManagementPanelUploaderBloc panelUploaderBloc;

  const AttachmentCardWidget({
    Key? key,
    required this.imageProvider,
    required this.fileName,
    required this.extension,
    required this.fileSize,
    this.delete,
    this.width = 152.0,
    this.height = 152.0,
    this.reload = false,
    required this.reading,
    this.file,
    this.shareable = false,
    required this.panelUploaderBloc,
  }) : super(key: key);

  @override
  State<AttachmentCardWidget> createState() {
    return _AttachmentCardWidgetState();
  }
}

class _AttachmentCardWidgetState extends State<AttachmentCardWidget> {
  late AttachmentBloc _attachmentBloc;

  @override
  void initState() {
    super.initState();
    _attachmentBloc = Modular.get<AttachmentBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentBloc, AttachmentState>(
      bloc: _attachmentBloc,
      listener: ((context, state) {
        if (state is ErrorNativePermissionStorageState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.errorPermissionStorage,
            ),
          );
        }
      }),
      builder: (context, state) {
        return WaapiCardWidget(
          onTap: (() {
            if (widget.shareable) {
              _attachmentBloc.add(
                ShareFileReceivedEvent(
                  fileToShare: widget.file!.path,
                ),
              );
            }
          }),
          width: widget.width,
          height: widget.height,
          showActionIcon: false,
          padding: EdgeInsets.zero,
          child: BlocBuilder<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
            bloc: widget.panelUploaderBloc,
            builder: (_, state) {
              if (state is DeletingPanelUploaderState && widget.fileName == state.attachmentName) {
                return LoadingAttachmentCardWidget(
                  height: widget.height!,
                  width: widget.width!,
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      if (widget.reload)
                        Container(
                          height: widget.height! / 2,
                          width: widget.width,
                          color: SeniorColors.secondaryColor100,
                          child: Padding(
                            padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: SeniorColors.pureWhite,
                              ),
                              child: const SeniorIcon(
                                icon: FontAwesomeIcons.solidCircleExclamation,
                                style: SeniorIconStyle(
                                  color: SeniorColors.manchesterColorRed500,
                                ),
                                size: SeniorIconSize.medium,
                              ),
                            ),
                          ),
                        ),
                      if (!widget.reload)
                        Expanded(
                          child: Container(
                            height: widget.height! / 2,
                            width: widget.width,
                            color: SeniorColors.secondaryColor100,
                            child: Image(
                              image: widget.imageProvider,
                              errorBuilder: (c, e, s) {
                                return Padding(
                                  padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: SeniorColors.pureWhite,
                                    ),
                                    child: const SeniorIcon(
                                      icon: FontAwesomeIcons.solidFile,
                                      size: SeniorIconSize.medium,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.normal,
                      left: SeniorSpacing.normal,
                      right: SeniorSpacing.normal,
                      bottom: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SeniorText.body(
                            widget.fileName,
                            key: const Key('attachment_card-file_name-label'),
                            color: (widget.reload) ? SeniorColors.manchesterColorRed500 : SeniorColors.neutralColor900,
                            textProperties: const TextProperties(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.xsmall,
                      right: SeniorSpacing.normal,
                      left: SeniorSpacing.normal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: SeniorText.small(
                            '${widget.fileSize} • ${widget.extension}',
                            key: const Key('attachment_card-file_size-label'),
                            color: SeniorColors.neutralColor500,
                            textProperties: const TextProperties(
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SeniorSpacing.normal,
                          width: 13.33,
                          child: (widget.reload)
                              ? InkWell(
                                  onTap: () async {
                                    if (state is ErrorUploadPanelUploaderState) {
                                      FormData formData = FormData.fromMap(
                                        {'file': await MultipartFile.fromFile(state.file.path)},
                                      );

                                      widget.panelUploaderBloc.add(
                                        UploadAttachmentPanelUploaderEvent(
                                          contentType: state.contentType,
                                          file: state.file,
                                          formData: formData,
                                          nameAttachment: state.file.path.split('/').last.split('.').first,
                                        ),
                                      );
                                    }
                                  },
                                  child: const SeniorIcon(
                                    icon: FontAwesomeIcons.arrowsRotate,
                                    style: SeniorIconStyle(
                                      color: SeniorColors.secondaryColor700,
                                    ),
                                    size: 14.0,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        if (!widget.reading)
                          SizedBox(
                            height: SeniorSpacing.normal,
                            width: 13.33,
                            child: InkWell(
                              onTap: widget.delete,
                              child: const SeniorIcon(
                                icon: FontAwesomeIcons.solidTrashCan,
                                style: SeniorIconStyle(
                                  color: SeniorColors.secondaryColor700,
                                ),
                                size: 14.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
