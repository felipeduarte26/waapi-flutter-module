import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import 'employee_bottom_sheet_widget.dart';

class EmptyStateWidget extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String imagePath;
  final double imageHeight;
  final TextStyle? titleStyle;
  final List<Widget>? actions;

  const EmptyStateWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    this.imageHeight = 160,
    this.subTitle,
    this.actions,
    this.titleStyle,
  }) : super(key: key);

  @override
  EmptyStateWidgetState createState() {
    return EmptyStateWidgetState();
  }
}

class EmptyStateWidgetState extends State<EmptyStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                right: SeniorSpacing.normal,
                left: SeniorSpacing.normal,
                top: SeniorSpacing.normal,
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        widget.imagePath,
                        height: widget.imageHeight,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.small,
                      ),
                      SeniorText.h4(
                        widget.title,
                        style: widget.titleStyle,
                        textProperties: const TextProperties(
                          textAlign: TextAlign.center,
                        ),
                      ),
                      widget.subTitle == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: SeniorSpacing.xsmall,
                              ),
                              child: SeniorText.label(
                                widget.subTitle!,
                                color: SeniorColors.neutralColor500,
                                textProperties: const TextProperties(
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        widget.actions == null
            ? const SizedBox.shrink()
            : EmployeeBottomSheetWidget(
                seniorButtons: widget.actions!,
                horizontalPadding: false,
              ),
      ],
    );
  }
}
