import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/constants/assets_path.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/file_helper.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../../../attachment/domain/entities/attachment_entity.dart';
import '../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../../../attachment/presenter/blocs/attachment_bloc/attachment_event.dart';
import '../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../domain/entities/social_attachment_entity.dart';

class SocialPostAttachmentCardWidget extends StatefulWidget {
  final SocialAttachmentEntity? attachment;

  const SocialPostAttachmentCardWidget({
    super.key,
    required this.attachment,
  });

  @override
  State<SocialPostAttachmentCardWidget> createState() => _SocialPostAttachmentCardWidgetState();
}

class _SocialPostAttachmentCardWidgetState extends State<SocialPostAttachmentCardWidget> {
  late AttachmentBloc _attachmentBloc;
  int fileSize = 0;
  late String fileName;

  @override
  void initState() {
    _attachmentBloc = Modular.get<AttachmentBloc>();
    fileName = widget.attachment!.fileName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.attachment != null
        ? BlocConsumer<AttachmentBloc, AttachmentState>(
            bloc: _attachmentBloc,
            listener: ((context, state) async {
              if (state is ErrorNativePermissionStorageState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: context.translate.errorPermissionStorage,
                  ),
                );
              }
              if (state is LoadedAttachmentsState) {
                final fileToShare = await FileHelper.bytesToFile(
                  bytes: state.fileBytes,
                  fileName: state.fileName,
                );
                OpenFile.open(
                  fileToShare.path,
                );
              }
            }),
            builder: (context, state) {
              return WaapiCardWidget(
                onTap: (() {
                  _attachmentBloc.add(
                    DownloadAttachmentEvent(
                      attachmentEntity: AttachmentEntity(
                        id: widget.attachment!.id,
                        name: widget.attachment!.fileName,
                        link: widget.attachment!.fileUrl,
                        personId: widget.attachment!.id,
                      ),
                    ),
                  );
                }),
                margin: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                  right: SeniorSpacing.normal,
                  bottom: SeniorSpacing.normal,
                ),
                height: 84,
                showActionIcon: false,
                padding: EdgeInsets.zero,
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: SeniorSpacing.normal,
                      ),
                      const SeniorIcon(
                        icon: FontAwesomeIcons.solidFileLines,
                        size: SeniorIconSize.medium,
                      ),
                      const SizedBox(
                        width: SeniorSpacing.normal,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SeniorText.labelBold(
                              textProperties: const TextProperties(
                                overflow: TextOverflow.ellipsis,
                              ),
                              emphasis: true,
                              widget.attachment!.title.isNotEmpty
                                  ? widget.attachment!.title
                                  : widget.attachment!.fileName,
                            ),
                            const SizedBox(
                              height: SeniorSpacing.xxsmall,
                            ),
                            SeniorText.small(
                              '${StringHelper.formatBytes(widget.attachment!.fileSize)} ${StringHelper.bulletPoint()} ${fileName.split('.').last.toUpperCase()}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: SeniorSpacing.normal,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SeniorSpacing.normal,
                        ),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            AssetsPath.downloadIconSvg,
                            width: SeniorSpacing.normal,
                            height: SeniorSpacing.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
