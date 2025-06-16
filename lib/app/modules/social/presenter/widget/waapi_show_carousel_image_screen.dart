import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/file_helper.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../../../attachment/presenter/blocs/attachment_bloc/attachment_event.dart';
import '../../../feedback/helper/screenshot_helper.dart';

class WaapiShowCarouselImageScreen extends StatefulWidget {
  final String imageUserName;
  final List<String> imageUrls;
  const WaapiShowCarouselImageScreen({
    super.key,
    required this.imageUserName,
    required this.imageUrls,
  });

  @override
  State<WaapiShowCarouselImageScreen> createState() => _WaapiShowCarouselImageScreenState();
}

class _WaapiShowCarouselImageScreenState extends State<WaapiShowCarouselImageScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: widget.imageUserName,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: SeniorSpacing.small,
            ),
            child: InkWell(
              onTap: () async {
                final filePath = await getImageFilePath();
                Modular.get<AttachmentBloc>().add(
                  ShareFileReceivedEvent(
                    fileToShare: filePath,
                  ),
                );
              },
              child: const Icon(
                Icons.share,
                size: SeniorIconSize.medium,
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.values[1],
                  color: SeniorColors.primaryColor500,
                  child: PageView.builder(
                    itemCount: widget.imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _CarouselImage(imageUrl: widget.imageUrls[index]);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            if (widget.imageUrls.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imageUrls.map((url) {
                  int index = widget.imageUrls.indexOf(url);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: SeniorSpacing.xsmall,
                    height: SeniorSpacing.xsmall,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index ? SeniorColors.primaryColor500 : SeniorColors.grayscale20,
                      border: Border.all(
                        color: SeniorColors.grayscale20,
                        width: _currentIndex == index ? 1 : 0,
                      ),
                    ),
                  );
                }).toList(),
              ),
            const SizedBox(
              height: SeniorSpacing.small,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getImageFilePath() async {
    final uint8List = await ScreenshotHelper.captureFromWidgetWithSize(
      _CarouselImage(
        imageUrl: widget.imageUrls[_currentIndex],
      ),
      context,
    );

    final File fileToShare = await FileHelper.createFileFromUint8List(uint8List);
    return fileToShare.path;
  }
}

class _CarouselImage extends StatefulWidget {
  final String imageUrl;
  const _CarouselImage({required this.imageUrl});

  @override
  State<_CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<_CarouselImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      fit: BoxFit.fitWidth,
      widget.imageUrl,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: SeniorColors.pureBlack,
          height: context.widthSize,
          width: context.widthSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SeniorIcon(
                icon: FontAwesomeIcons.solidImage,
                style: SeniorIconStyle(
                  color: SeniorColors.pureWhite,
                ),
                size: SeniorSpacing.xmedium,
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              SeniorText.body(
                context.translate.errorLoadingImage,
                color: SeniorColors.pureWhite,
                darkColor: SeniorColors.pureWhite,
              ),
              SeniorText.body(
                context.translate.tryAgain,
                color: SeniorColors.primaryColor300,
                darkColor: SeniorColors.primaryColor300,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: WaapiLoadingWidget(),
        );
      },
    );
  }
}
