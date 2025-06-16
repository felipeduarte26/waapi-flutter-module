import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../senior_button/senior_button.dart';

class SeniorLinearLongPressButton extends StatefulWidget {
  /// Creates the Long Press Button component of the design system.
  /// The [icon], [duration] and [onSubmit] parameters are required.
  const SeniorLinearLongPressButton({
    Key? key,
    this.busy = false,
    required this.busyMessage,
    this.icon,
    required this.duration,
    this.fullLength = false,
    required this.label,
    required this.onSubmit,
    this.onTapDown,
    this.onTapUp,
  }) : super(key: key);

  /// Defines whether the button will be in a busy state.
  /// In this state, a circular progress indicator is displayed on the button.
  ///
  /// The default value is false.
  final bool busy;

  /// A message to be displayed when the button is in a busy state.
  /// It is displayed only when the button is in a busy state.
  final String busyMessage;

  /// The icon that will be displayed inside the button.
  final IconData? icon;

  /// The duration the button needs to be pressed for the onSubmit event to be executed.
  final int duration;

  /// Label presented below the component.
  final String label;

  /// Callback function executed when the button is pressed for the time specified in [duration].
  final VoidCallback onSubmit;

  /// Callback function executed when the button is pressed.
  final VoidCallback? onTapDown;

  /// Callback function executed when the button being pressed is released.
  final VoidCallback? onTapUp;

  /// Determines whether the button will take up all available side space.
  /// The default value is false.
  final bool fullLength;

  @override
  State<SeniorLinearLongPressButton> createState() => _SeniorLinearLongPressButtonState();
}

class _SeniorLinearLongPressButtonState extends State<SeniorLinearLongPressButton> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool showLoading = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onSubmit();
      }
    });
  }

  @override
  void didUpdateWidget(SeniorLinearLongPressButton oldState) {
    super.didUpdateWidget(oldState);
    if (!widget.busy) {
      controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SeniorSpacing.small),
      child: GestureDetector(
        onTapDown: (_) {
          controller.forward();
          widget.onTapDown?.call();
        },
        onTapUp: (_) {
          if (controller.status == AnimationStatus.forward) {
            controller.reverse();
          }
          widget.onTapUp?.call();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SeniorButton.primary(
              icon: widget.icon,
              label: widget.busy ? widget.busyMessage : widget.label,
              onPressed: widget.onSubmit,
              busy: widget.busy,
              fullWidth: widget.fullLength,
            ),
            Positioned.fill(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SeniorRadius.xbig),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    value: controller.value,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
