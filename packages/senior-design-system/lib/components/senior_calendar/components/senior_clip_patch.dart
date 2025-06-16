import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../senior_design_system.dart';

class SeniorClipPatch extends StatefulWidget {
  final SeniorFormsEnum form;
  final Color? colorCircleDefaultMarkedDay;
  final Color? colorSquareDefaultMarkedDay;
  final Color? colorTriangleDefaultMarkedDay;
  final Color? colorTriangleDownDefaultMarkedDay;
  final double? widthSize;
  final double? heightSize;

  const SeniorClipPatch({
    Key? key,
    required this.form,
    this.colorCircleDefaultMarkedDay,
    this.colorSquareDefaultMarkedDay,
    this.colorTriangleDefaultMarkedDay,
    this.colorTriangleDownDefaultMarkedDay,
    this.widthSize,
    this.heightSize,
  });

  @override
  State<SeniorClipPatch> createState() => _SeniorClipPatchState();
}

class _SeniorClipPatchState extends State<SeniorClipPatch> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    final Color? circleDefaultMarkedDayColor =
        widget.colorCircleDefaultMarkedDay ??
            theme.calendarTheme!.style!.colorCircleDefaultMarkedDay;
    final Color? squareDefaultMarkedDayColor =
        widget.colorSquareDefaultMarkedDay ??
            theme.calendarTheme!.style!.colorSquareDefaultMarkedDay;
    final Color? triangleDefaultMarkedDayColor =
        widget.colorTriangleDefaultMarkedDay ??
            theme.calendarTheme!.style!.colorTriangleDefaultMarkedDay;
    final Color? triangleDownDefaultMarkedDayColor =
        widget.colorTriangleDownDefaultMarkedDay ??
            theme.calendarTheme!.style!.colorTriangleDownDefaultMarkedDay;
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipPath(
        clipper: getClipper(),
        child: Container(
          width: widget.widthSize ?? 8,
          height: widget.heightSize ?? 8,
          decoration: BoxDecoration(
            color: getColor(
              colorSquareDefaultMarkedDay: squareDefaultMarkedDayColor!,
              colorTriangleDefaultMarkedDay: triangleDefaultMarkedDayColor!,
              colorTriangleDownDefaultMarkedDay:
                  triangleDownDefaultMarkedDayColor!,
              colorCircleDefaultMarkedDay: circleDefaultMarkedDayColor!,
            ),
          ),
        ),
      ),
    );
  }

  CustomClipper<Path> getClipper() {
    switch (widget.form) {
      case SeniorFormsEnum.SQUARE:
        return SeniorSquare();
      case SeniorFormsEnum.TRIANGLE:
        return SeniorTriangle();
      case SeniorFormsEnum.TRIANGLE_DOWN:
        return SeniorTriangleDown();
      case SeniorFormsEnum.CIRCLE:
        return SeniorCircle();
    }
  }

  Color getColor({
    required Color colorSquareDefaultMarkedDay,
    required Color colorTriangleDefaultMarkedDay,
    required Color colorTriangleDownDefaultMarkedDay,
    required Color colorCircleDefaultMarkedDay,
  }) {
    switch (widget.form) {
      case SeniorFormsEnum.SQUARE:
        return colorSquareDefaultMarkedDay;
      case SeniorFormsEnum.TRIANGLE:
        return colorTriangleDefaultMarkedDay;
      case SeniorFormsEnum.TRIANGLE_DOWN:
        return colorTriangleDownDefaultMarkedDay;
      case SeniorFormsEnum.CIRCLE:
        return colorCircleDefaultMarkedDay;
    }
  }
}
