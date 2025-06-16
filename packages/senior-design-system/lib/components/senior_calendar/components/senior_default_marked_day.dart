import 'package:flutter/material.dart';

import 'senior_clip_patch.dart';
import 'senior_forms_enum.dart';

class SeniorDefaultMarkedDay extends StatelessWidget {
  /// Class that creates the day marking pattern
  ///
  /// Shows the triangle down in the day mark
  final bool showTriangle;

  ///  Shows the triangleDown in the day marker
  final bool showTriangleDown;

  /// Shows the square in the day marking
  final bool showSquare;

  /// Shows the circle in the day marking
  final bool showCircle;

  //Color of the circle in the day marking
  final Color? colorCircleDefaultMarkedDay;

  ///  Color of the square in the day marking
  final Color? colorSquareDefaultMarkedDay;

  ///Color of the triangle  at the day mark
  final Color? colorTriangleDefaultMarkedDay;

  /// Color of the triangle down at the day mark
  final Color? colorTriangleDownDefaultMarkedDay;

  const SeniorDefaultMarkedDay({
    Key? key,
    this.showTriangle = false,
    this.showTriangleDown = false,
    this.showSquare = false,
    this.showCircle = false,
    this.colorCircleDefaultMarkedDay,
    this.colorSquareDefaultMarkedDay,
    this.colorTriangleDefaultMarkedDay,
    this.colorTriangleDownDefaultMarkedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showSquare
                ? SeniorClipPatch(
                    form: SeniorFormsEnum.SQUARE,
                    colorSquareDefaultMarkedDay: colorSquareDefaultMarkedDay!,
                  )
                : const SizedBox.shrink(),
            showTriangle
                ? SeniorClipPatch(
                    form: SeniorFormsEnum.TRIANGLE,
                    colorTriangleDefaultMarkedDay:
                        colorTriangleDefaultMarkedDay!,
                  )
                : const SizedBox.shrink(),
            showTriangleDown
                ? SeniorClipPatch(
                    form: SeniorFormsEnum.TRIANGLE_DOWN,
                    colorTriangleDownDefaultMarkedDay:
                        colorTriangleDownDefaultMarkedDay!,
                  )
                : const SizedBox.shrink(),
            showCircle
                ? SeniorClipPatch(
                    form: SeniorFormsEnum.CIRCLE,
                    colorCircleDefaultMarkedDay: colorCircleDefaultMarkedDay!,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
