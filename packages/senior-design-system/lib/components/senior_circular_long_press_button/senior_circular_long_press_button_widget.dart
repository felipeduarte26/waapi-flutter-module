import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import 'senior_circular_long_press_button_style.dart';
import '../../repositories/theme_repository.dart';

class SeniorCircularLongPressButton extends StatefulWidget {
  /// Creates the Long Press Button component of the design system.
  /// The [icon], [duration] and [onSubmit] parameters are required.
  const SeniorCircularLongPressButton({
    Key? key,
    required this.icon,
    required this.duration,
    this.label,
    required this.onSubmit,
    this.onTapDown,
    this.onTapUp,
    this.style,
  }) : super(key: key);

  /// The icon that will be displayed inside the button.
  final IconData icon;

  /// The duration the button needs to be pressed for the onSubmit event to be executed.
  final int duration;

  /// Label presented below the component.
  final String? label;

  /// Callback function executed when the button is pressed for the time specified in [duration].
  final VoidCallback onSubmit;

  /// Callback function executed when the button is pressed.
  final VoidCallback? onTapDown;

  /// Callback function executed when the button being pressed is released.
  final VoidCallback? onTapUp;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorLongPressButtonStyle.activeBorderColor] the active border color.
  /// [SeniorLongPressButtonStyle.borderColor] the default border color.
  /// [SeniorLongPressButtonStyle.iconColor] the icon color.
  /// [SeniorLongPressButtonStyle.labelColor] the color of the text displayed below the component.
  final SeniorCircularLongPressButtonStyle? style;

  @override
  State<SeniorCircularLongPressButton> createState() =>
      _SeniorCircularLongPressButtonState();
}

class _SeniorCircularLongPressButtonState
    extends State<SeniorCircularLongPressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onSubmit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    const double size = 154.0;
    const double strokeWidth = 5.0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(SeniorSpacing.small),
          child: GestureDetector(
            onTapDown: (_) {
              _controller.forward();
              widget.onTapDown?.call();
            },
            onTapUp: (_) {
              if (_controller.status == AnimationStatus.forward) {
                _controller.reverse();
              }
              widget.onTapUp?.call();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size / 2),
                    border: Border.all(
                      color: widget.style?.borderColor ??
                          theme.longPressButtonTheme?.style?.borderColor ??
                          SeniorColors.grayscale40,
                      width: strokeWidth,
                    ),
                  ),
                  child: Center(
                    child: FaIcon(
                      widget.icon,
                      color: widget.style?.iconColor ??
                          theme.longPressButtonTheme?.style?.iconColor ??
                          SeniorColors.pureBlack,
                      size: 96.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: size,
                  width: size,
                  child: Padding(
                    // Padding necessário para alinhar o circular progress indicator com a borda do container.
                    padding: const EdgeInsets.all(2.5),
                    child: CircularProgressIndicator(
                      value: _controller.value,
                      valueColor: AlwaysStoppedAnimation(
                        widget.style?.activeBorderColor ??
                            theme.longPressButtonTheme?.style
                                ?.activeBorderColor ??
                            SeniorColors.primaryColor500,
                      ),
                      strokeWidth: strokeWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        widget.label != null
            ? Text(
                widget.label!,
                style: SeniorTypography.label(
                  color: widget.style?.labelColor ??
                      theme.longPressButtonTheme?.style?.labelColor ??
                      SeniorColors.pureBlack,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
