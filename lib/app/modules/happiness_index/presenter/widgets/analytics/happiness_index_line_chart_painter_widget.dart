import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class HappinessIndexLineChartPainterWidget extends CustomPainter {
  final List<List> data;
  final double width;
  final double height;
  final Paint linePaint;
  final Paint? circlePaint;
  final bool showCircles;
  final double radiusValue;
  final Paint? insideCirclePaint;
  final double padding;

  HappinessIndexLineChartPainterWidget(
    this.data,
    this.width,
    this.height,
    this.linePaint,
    this.circlePaint, {
    this.showCircles = true,
    this.radiusValue = 6,
    this.insideCirclePaint,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const yPosPaintLimitPosition = 138.0;
    Path path = Path();

    for (var d in data) {
      path.moveTo(d.first.dx + SeniorSpacing.xmedium, yPosPaintLimitPosition);
      path.lineTo(d.first.dx + SeniorSpacing.xmedium, 144);
      Paint columnWeekPaintBorder = Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke
        ..color = SeniorColors.neutralColor300;
      canvas.drawPath(path, columnWeekPaintBorder);
    }

    path.moveTo(0, yPosPaintLimitPosition);
    path.lineTo(size.width, yPosPaintLimitPosition);
    Paint rowPaintBorder = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = SeniorColors.neutralColor300;
    canvas.drawPath(path, rowPaintBorder);

    path.moveTo(0, -16);
    path.lineTo(0, yPosPaintLimitPosition);

    Paint columnPaintBorder = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = SeniorColors.neutralColor300;
    canvas.drawPath(path, columnPaintBorder);

    final Paint dashPaint = Paint()
      ..color = SeniorColors.neutralColor300
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    for (int i = 0; i < 5; i++) {
      _drawDashedLine(canvas, size, dashPaint, i);
    }

    if (data.isNotEmpty) {
      _drawChartLine(canvas);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawDashedLine(Canvas canvas, Size size, Paint paint, int posY) {
    // Chage to your preferred size
    const int dashWidth = 4;
    const int dashSpace = 4;

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startX = 0;
    double y = (30 * posY).toDouble() - 15;

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startX < size.width) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);

      // Update the starting X
      startX += dashWidth + dashSpace;
    }
  }

  void _drawChartLine(
    Canvas canvas,
  ) {
    int lastIndexCouldShow = 0;

    for (var value in data) {
      if (value.last.amount > 0) {
        lastIndexCouldShow = data.indexOf(value);
      }
    }

    for (var value in data) {
      final currentIndex = data.indexOf(value);

      Path path = Path();

      path.moveTo(value.first.dx + padding, value.first.dy);

      if (data[lastIndexCouldShow] != value && value.last.amount > 0) {
        int nextValidIndex = currentIndex + 1;
        while (nextValidIndex < lastIndexCouldShow) {
          if (data[nextValidIndex].last.amount > 0) break;
          nextValidIndex++;
        }
        path.lineTo(data[nextValidIndex].first.dx + padding + 1, data[nextValidIndex].first.dy);
      }

      if (value.last.amount > 0) {
        canvas.drawPath(path, linePaint);
      }

      if (showCircles && value.last.amount > 0) {
        canvas.drawCircle(Offset(value.first.dx + padding, value.first.dy), radiusValue, circlePaint!);
        canvas.drawCircle(
          Offset(value.first.dx + padding, value.first.dy),
          radiusValue / 2,
          insideCirclePaint != null ? insideCirclePaint! : circlePaint!,
        );
      }
    }
  }
}
