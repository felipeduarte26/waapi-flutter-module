import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import 'social_post_image_carousel_item_widget.dart';

class SocialPostImageCarouselWidget extends StatefulWidget {
  final String imageUserName;
  final List<String> imageUrls;

  const SocialPostImageCarouselWidget({
    super.key,
    required this.imageUrls,
    required this.imageUserName,
  });

  @override
  State<SocialPostImageCarouselWidget> createState() => _SocialPostImageCarouselWidgetState();
}

class _SocialPostImageCarouselWidgetState extends State<SocialPostImageCarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final currentIndexColor =
        themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor : SeniorColors.primaryColor500;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.small,
      ),
      child: (widget.imageUrls.length > 1)
          ? Column(
              children: [
                SizedBox(
                  height: context.widthSize,
                  width: context.widthSize,
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
                        return SocialPostImageCarouselItemWidget(
                          selectedImage: widget.imageUrls[index],
                          imageUserName: widget.imageUserName,
                          imageUrls: widget.imageUrls,
                          expandImage: true,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.xsmall,
                  ),
                  child: Row(
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
                          color: _currentIndex == index ? currentIndexColor : SeniorColors.grayscale20,
                          border: Border.all(
                            color: SeniorColors.grayscale20,
                            width: _currentIndex == index ? 1 : 0,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          : SocialPostImageCarouselItemWidget(
              selectedImage: widget.imageUrls.first,
              imageUserName: widget.imageUserName,
              imageUrls: widget.imageUrls,
            ),
    );
  }
}
