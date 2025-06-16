import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/helper/string_helper.dart';

class SocialAttachmentCardWidget extends StatefulWidget {
  final ImageProvider imageProvider;
  final Function()? delete;
  final String fileName;
  final int fileSize;
  final double? width;
  final double? height;
  final bool reload;
  final bool reading;
  final String extension;
  final File? file;

  const SocialAttachmentCardWidget({
    Key? key,
    required this.imageProvider,
    required this.fileName,
    required this.extension,
    required this.fileSize,
    this.delete,
    this.width = 100.0,
    this.height = 100.0,
    this.reload = false,
    required this.reading,
    this.file,
  }) : super(key: key);

  @override
  State<SocialAttachmentCardWidget> createState() {
    return _SocialAttachmentCardWidgetState();
  }
}

class _SocialAttachmentCardWidgetState extends State<SocialAttachmentCardWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context);
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.isDarkTheme() ? SeniorColors.grayscale80 : SeniorColors.grayscale30,
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
                color: theme.isDarkTheme() ? SeniorColors.pureBlack : SeniorColors.pureWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    SeniorSpacing.xsmall,
                  ),
                  topRight: Radius.circular(
                    SeniorSpacing.xsmall,
                  ),
                ),
              ),
              height: widget.height! * 0.7,
              width: widget.width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    SeniorSpacing.xsmall,
                  ),
                  topRight: Radius.circular(
                    SeniorSpacing.xsmall,
                  ),
                ),
                child: Image(
                  image: widget.imageProvider,
                  height: widget.height! * 0.7,
                  width: widget.width,
                  errorBuilder: (c, e, s) {
                    return Padding(
                      padding: const EdgeInsets.all(
                        SeniorSpacing.xsmall,
                      ),
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
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.isDarkTheme() ? SeniorColors.grayscale90 : SeniorColors.grayscale50,
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
                color: theme.isDarkTheme() ? theme.theme.cardTheme!.style!.backgroundColor : SeniorColors.pureWhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    SeniorSpacing.xsmall,
                  ),
                  bottomRight: Radius.circular(
                    SeniorSpacing.xsmall,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(
                SeniorSpacing.small,
              ),
              width: widget.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SeniorText.small(
                    darkColor: SeniorColors.grayscale5,
                    '${StringHelper.formatBytes(widget.fileSize)} ${StringHelper.bulletPoint()} ${widget.extension}',
                    key: const Key('attachment_card-file_size-label'),
                    color: SeniorColors.grayscale70,
                    textProperties: const TextProperties(
                      maxLines: 1,
                    ),
                  ),
                  if (!widget.reading)
                    SizedBox(
                      height: SeniorSpacing.normal,
                      width: 13.33,
                      child: InkWell(
                        onTap: widget.delete,
                        child: SeniorIcon(
                          icon: FontAwesomeIcons.solidTrashCan,
                          style: SeniorIconStyle(
                            color: theme.isDarkTheme() ? SeniorColors.grayscale5 : SeniorColors.secondaryColor700,
                          ),
                          size: 14.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
