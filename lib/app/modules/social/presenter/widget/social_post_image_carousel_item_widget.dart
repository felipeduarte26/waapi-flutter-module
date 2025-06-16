// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../routes/app_routes.dart';

class SocialPostImageCarouselItemWidget extends StatefulWidget {
  final String selectedImage;
  final String imageUserName;
  final List<String> imageUrls;
  final bool expandImage;

  const SocialPostImageCarouselItemWidget({
    Key? key,
    required this.selectedImage,
    required this.imageUserName,
    required this.imageUrls,
    this.expandImage = false,
  }) : super(key: key);

  @override
  State<SocialPostImageCarouselItemWidget> createState() => _SocialPostImageCarouselItemWidgetState();
}

class _SocialPostImageCarouselItemWidgetState extends State<SocialPostImageCarouselItemWidget> {
  late ImageProvider _imageProvider;
  late bool _errorLoading;

  @override
  void initState() {
    super.initState();
    _imageProvider = NetworkImage(widget.selectedImage);
    _errorLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(
          AppRoutes.genericShowScreenRoute,
          arguments: {
            'imageUserName': widget.imageUserName,
            'imageUrls': widget.imageUrls,
          },
        );
      },
      child: _errorLoading
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _imageProvider = NetworkImage(widget.selectedImage);
                  _errorLoading = false;
                });
              },
              child: Container(
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
              ),
            )
          : Image(
              image: _imageProvider,
              fit: widget.expandImage ? BoxFit.cover : BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _errorLoading = true;
                  });
                });
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageProvider = NetworkImage(widget.selectedImage);
                      _errorLoading = false;
                    });
                  },
                  child: Container(
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
            ),
    );
  }
}
