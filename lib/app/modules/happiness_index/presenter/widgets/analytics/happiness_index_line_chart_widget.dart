library line_chart;

import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../infra/models/happiness_index_line_chart_model.dart';
import 'happiness_index_line_chart_painter_widget.dart';

class HappinessIndexLineChartWidget extends StatefulWidget {
  final BoxDecoration? pointerDecoration;
  final BoxDecoration? linePointerDecoration;
  final double width;
  final double height;
  final double circleRadiusValue;
  final bool showPointer;
  final bool showCircles;
  final Paint linePaint;
  final Paint? circlePaint;
  final Paint? insideCirclePaint;
  final List<HappinessIndexLineChartModel> data;
  final double padding;

  const HappinessIndexLineChartWidget({
    super.key,
    required this.width,
    required this.height,
    required this.data,
    required this.linePaint,
    this.circlePaint,
    this.showPointer = false,
    this.insideCirclePaint,
    this.circleRadiusValue = 6,
    this.showCircles = false,
    this.linePointerDecoration,
    this.pointerDecoration,
    this.padding = 16,
  });

  @override
  State<HappinessIndexLineChartWidget> createState() => _HappinessIndexLineChartWidgetState();
}

class _HappinessIndexLineChartWidgetState extends State<HappinessIndexLineChartWidget> {
  List<List> offsetsAndValues = [];
  BoxDecoration? linePointerDecoration = const BoxDecoration(
    color: Colors.black,
  );
  BoxDecoration? pointerDecoration = const BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  );
  double? x = 0;
  double? y = 0;
  bool showPointer = false;
  Paint? circlePaint = Paint()..color = Colors.black;
  List<double> percentagesOffsets = [];

  final maxValue = 5;
  final minValue = 1;

  @override
  void initState() {
    super.initState();
    generateOffsets();

    if (widget.linePointerDecoration != null) {
      linePointerDecoration = widget.linePointerDecoration;
    }

    if (widget.pointerDecoration != null) {
      pointerDecoration = widget.pointerDecoration;
    }

    if (widget.circlePaint != null) {
      circlePaint = widget.circlePaint;
    }
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as HappinessIndexLineChartWidget);

    generateOffsets();

    if (widget.linePointerDecoration != null) {
      linePointerDecoration = widget.linePointerDecoration;
    }

    if (widget.pointerDecoration != null) {
      pointerDecoration = widget.pointerDecoration;
    }
  }

  void generateOffsets() {
    double basePos = widget.width / widget.data.length;
    double next = 0;

    offsetsAndValues = widget.data.map((chart) {
      final Offset circlePosition = _getPointPos(next + widget.circleRadiusValue, chart.amount);

      next = next + basePos;
      return [
        circlePosition,
        chart,
      ];
    }).toList();
  }

  Offset _getPointPos(double width, double? amount) {
    if (maxValue == 0) {
      return Offset(width, widget.height);
    }

    double percentage = (amount! - minValue) / (maxValue - minValue);

    if (percentage.isNaN) {
      percentage = 0.5;
    }

    percentagesOffsets.add(percentage);

    return Offset(
      width - widget.circleRadiusValue * 2,
      widget.height * (1 - percentage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height + widget.padding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.width, widget.height),
            painter: HappinessIndexLineChartPainterWidget(
              offsetsAndValues,
              widget.width,
              widget.height,
              widget.linePaint,
              widget.circlePaint,
              insideCirclePaint: widget.insideCirclePaint,
              radiusValue: widget.circleRadiusValue,
              showCircles: widget.showCircles,
              padding: widget.padding,
            ),
          ),
          if (widget.data.where((e) => e.amount != null && e.amount! > 0).isEmpty)
            SeniorText.body(context.translate.noRegisterOnWeek),
          if (widget.showPointer) ...{
            // Line
            Positioned(
              left: x! + widget.padding - 1.5,
              top: 0,
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 200,
                ),
                opacity: showPointer ? 1 : 0,
                curve: Curves.easeInOut,
                child: Container(
                  height: widget.height + widget.padding,
                  width: 2,
                  decoration: linePointerDecoration,
                ),
              ),
            ),

            // Circle
            Positioned(
              left: x! + widget.padding - 6.5,
              top: (y! - 6) + widget.padding / 2,
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 200,
                ),
                opacity: showPointer ? 1 : 0,
                curve: Curves.easeInOut,
                child: Container(
                  width: widget.circleRadiusValue * 2,
                  height: widget.circleRadiusValue * 2,
                  decoration: pointerDecoration,
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}
