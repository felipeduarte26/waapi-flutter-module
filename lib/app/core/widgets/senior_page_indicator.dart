import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class SeniorPageIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const SeniorPageIndicator({
    Key? key,
    required this.length,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return SizedBox(
      height: 12,
      child: ListView.separated(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: SeniorSpacing.small,
          );
        },
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(
              milliseconds: 350,
            ),
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: currentPage == index
                  ? themeRepository.isCustomTheme()
                      ? themeRepository.theme.primaryColor!
                      : SeniorColors.primaryColor
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor! : SeniorColors.primaryColor,
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
