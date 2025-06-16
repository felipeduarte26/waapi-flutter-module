import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/services/file/file_service/file_service.dart';
import '../../../../core/services/file/file_service/file_service_impl.dart';
import '../../../../core/theme/waapi_style_theme.dart';
import '../../domain/entities/attachment_entity.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_bloc.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_event.dart';
import '../blocs/waapi_management_panel_uploader_bloc/waapi_management_panel_uploader_state.dart';
import 'list_attachments_widget.dart';

class WaapiManagementPanelUploaderWidget extends StatefulWidget {
  final bool reading;
  final List<AttachmentEntity>? attachments;
  final bool attachmentShareable;
  final bool isRequestVacationUpdate;
  final WaapiManagementPanelUploaderBloc panelUploaderBloc;

  const WaapiManagementPanelUploaderWidget({
    super.key,
    required this.reading,
    this.attachments,
    this.attachmentShareable = false,
    this.isRequestVacationUpdate = false,
    required this.panelUploaderBloc,
  });

  @override
  State<WaapiManagementPanelUploaderWidget> createState() {
    return _WaapiManagementPanelUploaderWidgetState();
  }
}

class _WaapiManagementPanelUploaderWidgetState extends State<WaapiManagementPanelUploaderWidget> {
  final _fileService = Modular.get<FileService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaapiManagementPanelUploaderBloc, WaapiManagementPanelUploaderState>(
      bloc: widget.panelUploaderBloc,
      builder: (context, state) {
        return Column(
          children: [
            ListAttachmentsWidget(
              panelUploaderBloc: widget.panelUploaderBloc,
              isRequestVacationUpdate: widget.isRequestVacationUpdate,
              attachmentShareable: widget.attachmentShareable,
              reading: widget.reading,
              apiAttachments: widget.attachments,
            ),
            if (state is ErrorUploadPanelUploaderState)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.small,
                  vertical: SeniorSpacing.normal,
                ),
                child: SeniorText.small(
                  context.translate.errorLoadingAttachment,
                  color: SeniorColors.manchesterColorRed500,
                ),
              ),
            if (!widget.reading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    SeniorSpacing.normal,
                  ),
                  child: SeniorButton(
                    icon: FontAwesomeIcons.solidPlus,
                    label: context.translate.attachFile,
                    disabled: (state is! InitialPanelUploaderState),
                    onPressed: () {
                      SeniorImageCropper(
                        cancelButtonLabel: context.translate.optionCancel,
                        doneButtonLabel: context.translate.attach,
                        cropperTitle: context.translate.receiptPhoto,
                        onPermissionCameraDenied: () => ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.errorPermissionPhoto,
                          ),
                        ),
                        onPermissionGalleryDenied: () => ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.error(
                            message: context.translate.errorPermissionGallery,
                          ),
                        ),
                        maxSizeMb: 2,
                        onCropImage: (croppedImage) async {
                          FormData formData = FormData.fromMap(
                            {'file': await MultipartFile.fromFile(croppedImage.path)},
                          );
                          widget.panelUploaderBloc.add(
                            UploadAttachmentPanelUploaderEvent(
                              file: croppedImage,
                              contentType: 'multipart/form-data',
                              formData: formData,
                              nameAttachment: croppedImage.path.split('/').last.split('.').first,
                            ),
                          );
                        },
                        pickImageLabel: context.translate.photoGallery,
                        takePhotoLabel: context.translate.takePicture,
                        pickFileLabel: context.translate.file,
                        pickFileIcon: FontAwesomeIcons.file,
                        pickImageIcon: FontAwesomeIcons.image,
                        takePhotoIcon: FontAwesomeIcons.camera,
                        onPickFile: () async {
                          final file = await _fileService.pickFile(
                            isFileSizeValidationEnabled: true,
                            onException: (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SeniorSnackBar.error(
                                  message: e.toString == FilePickerErroResult.invalidSize.name
                                      ? context.translate.unableAccessFilePleaseAgain
                                      : context.translate.theAttachedFileLargerThan('2'),
                                ),
                              );
                            },
                            onPermissionDenied: () => ScaffoldMessenger.of(context).showSnackBar(
                              SeniorSnackBar.error(
                                message: context.translate.errorPermissionGallery,
                              ),
                            ),
                          );
                          if (file != null) {
                            final formData = FormData.fromMap({
                              'file': await MultipartFile.fromFile(file.path),
                            });

                            widget.panelUploaderBloc.add(
                              UploadAttachmentPanelUploaderEvent(
                                file: file,
                                contentType: 'multipart/form-data',
                                formData: formData,
                                nameAttachment: file.path.split('/').last.split('.').first,
                              ),
                            );
                          }
                          setState(() {
                            Modular.to.pop();
                          });
                        },
                      ).pickImage(context);
                    },
                    outlined: true,
                    style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
                    fullWidth: true,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
