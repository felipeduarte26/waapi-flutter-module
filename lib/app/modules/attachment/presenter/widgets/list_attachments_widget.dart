import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/file_helper.dart';
import '../../domain/entities/attachment_entity.dart';
import '../blocs/attachment_bloc/attachment_state.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_event.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import 'attachment_card_widget.dart';
import 'loading_attachment_card_widget.dart';

class ListAttachmentsWidget extends StatefulWidget {
  final bool reading;
  final bool attachmentShareable;
  final List<AttachmentEntity>? apiAttachments;
  final bool isRequestVacationUpdate;
  final WaapiManagementPanelUploaderBloc panelUploaderBloc;

  const ListAttachmentsWidget({
    Key? key,
    required this.reading,
    this.apiAttachments,
    this.attachmentShareable = false,
    this.isRequestVacationUpdate = false,
    required this.panelUploaderBloc,
  }) : super(key: key);

  @override
  State<ListAttachmentsWidget> createState() => _ListAttachmentsWidgetState();
}

class _ListAttachmentsWidgetState extends State<ListAttachmentsWidget> {
  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isCustomTheme = themeRepository.isCustomTheme();
    return BlocConsumer<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
      listener: ((context, state) {
        if (state is ErrorDeletePanelUploaderState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.deleteError,
              action: SeniorSnackBarAction(
                label: context.translate.repeat,
                onPressed: () => DeletedPanelUploaderState(
                  attachments: state.attachments,
                ),
              ),
            ),
          );
        }
        if (state is DeletedPanelUploaderState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: context.translate.deletedAttachment,
            ),
          );
        }
      }),
      bloc: widget.panelUploaderBloc,
      builder: (context, state) {
        final attachments = _getAttachmentList(state: state);

        if (attachments.isNotEmpty || state is ErrorUploadPanelUploaderState || state is UploadingPanelUploaderState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SeniorSpacing.normal,
            ),
            child: SizedBox(
              height: 152.0,
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                  right: SeniorSpacing.normal,
                  top: SeniorSpacing.xxxsmall,
                  bottom: SeniorSpacing.xxxsmall,
                ),
                key: const Key('attachment-list_attachments-list_view'),
                scrollDirection: Axis.horizontal,
                itemCount: ((state is ErrorUploadPanelUploaderState || state is UploadingPanelUploaderState)
                    ? attachments.length + 1
                    : attachments.length),
                itemBuilder: (_, index) {
                  if (state is UploadingPanelUploaderState && index == state.attachments.length) {
                    return const LoadingAttachmentCardWidget(
                      height: 152.0,
                      width: 152.0,
                    );
                  }
                  if (state is ErrorUploadPanelUploaderState && index == state.attachments.length) {
                    final bytes = state.file.readAsBytesSync().lengthInBytes;
                    final kb = (bytes / 1024).truncate();

                    return AttachmentCardWidget(
                      panelUploaderBloc: widget.panelUploaderBloc,
                      shareable: widget.attachmentShareable,
                      file: state.file,
                      key: Key('error_card-attachment-list_attachments-card-$index'),
                      width: 152.0,
                      height: 152.0,
                      imageProvider: NetworkImage(state.file.path),
                      fileName: state.file.path.split('/').last.split('.').first,
                      fileSize: '$kb KB',
                      reload: true,
                      extension: state.file.path.split('.').last,
                      reading: widget.reading,
                      delete: () {
                        _showDialogDelete(
                          context: context,
                          panelUploaderBloc: widget.panelUploaderBloc,
                          attachmentId: '',
                          attachmentName: state.file.path.split('/').last.split('.').first,
                        );
                      },
                    );
                  }
                  if (state is! ErrorUploadPanelUploaderState && state is! UploadingPanelUploaderState) {
                    return FutureBuilder<File>(
                      future: getFileAttachment(
                        url: attachments[index].link,
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }

                        final file = snapshot.data!;

                        final bytes = file.readAsBytesSync().lengthInBytes;
                        final kb = (bytes / 1024).truncate();

                        return AttachmentCardWidget(
                          panelUploaderBloc: widget.panelUploaderBloc,
                          shareable: widget.attachmentShareable,
                          file: file,
                          key: Key('attachment-list_attachments-card-$index'),
                          width: 152.0,
                          height: 152.0,
                          imageProvider: NetworkImage(attachments[index].link),
                          fileName: attachments[index].name.split('.').first,
                          fileSize: '$kb KB',
                          extension: attachments[index].name.split('.').last,
                          reading: widget.reading,
                          delete: () {
                            _showDialogDelete(
                              context: context,
                              panelUploaderBloc: widget.panelUploaderBloc,
                              attachmentId: state.attachments[index].id,
                              attachmentName: state.attachments[index].name.split('.').first,
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
                separatorBuilder: (_, __) => const SizedBox(
                  width: SeniorSpacing.normal,
                ),
              ),
            ),
          );
        }

        if (widget.reading && attachments.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(SeniorSpacing.small),
            child: SeniorCard(
              withElevation: isCustomTheme,
              style: SeniorCardStyle(
                backgroundColor: themeRepository.isDarkTheme()
                    ? themeRepository.theme.cardTheme!.style!.backgroundColor
                    : isCustomTheme
                        ? SeniorColors.pureWhite
                        : SeniorColors.secondaryColor100,
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      right: SeniorSpacing.small,
                    ),
                    child: SeniorIcon(
                      icon: FontAwesomeIcons.paperclip,
                      size: 33.33,
                    ),
                  ),
                  Expanded(
                    child: SeniorText.body(
                      context.translate.noReceiptsRequest,
                      color: SeniorColors.neutralColor800,
                      textProperties: const TextProperties(
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<File> getFileAttachment({
    required String url,
  }) async {
    final byteData = await NetworkAssetBundle(Uri.parse(url)).load(url);

    final attachment = byteData.buffer.asUint8List();

    return await FileHelper.createFileFromUint8List(attachment);
  }

  void _showDialogDelete({
    required BuildContext context,
    required WaapiManagementPanelUploaderBloc panelUploaderBloc,
    required String attachmentId,
    required String attachmentName,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocBuilder<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
          bloc: panelUploaderBloc,
          builder: (context, state) {
            return SeniorModal(
              title: context.translate.deleteAttachment,
              content: context.translate.uploadAgain,
              defaultAction: SeniorModalAction(
                label: context.translate.no,
                action: Modular.to.pop,
                busy: state is LoadingAttachmentState,
              ),
              otherAction: SeniorModalAction(
                busy: state is LoadingAttachmentState,
                label: context.translate.yes,
                action: () {
                  Modular.to.pop();
                  panelUploaderBloc.add(
                    DeleteAttachmentPanelUploaderEvent(
                      idAttachment: attachmentId,
                      nameAttachment: attachmentName,
                    ),
                  );
                },
                danger: true,
              ),
            );
          },
        );
      },
    );
  }

  List<AttachmentEntity> _getAttachmentList({required WaapiManagementPanelUploaderState state}) {
    List<AttachmentEntity> attachments = [];

    if (widget.isRequestVacationUpdate) {
      widget.apiAttachments
          ?.map(
            (apiAttachments) => {
              attachments.add(
                AttachmentEntity(
                  id: apiAttachments.id,
                  name: apiAttachments.name,
                  link: apiAttachments.link,
                  personId: apiAttachments.personId,
                ),
              ),
            },
          )
          .toList();
    }

    state.attachments
        .map(
          (stateAttachments) => {
            attachments.add(
              AttachmentEntity(
                id: stateAttachments.id,
                name: stateAttachments.name,
                link: stateAttachments.link,
                personId: stateAttachments.personId,
              ),
            ),
          },
        )
        .toList();

    return attachments;
  }
}
