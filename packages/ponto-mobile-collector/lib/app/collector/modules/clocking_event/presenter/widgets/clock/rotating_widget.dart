import 'package:flutter/material.dart';

class RotatingWidget extends StatefulWidget {
  final bool repeat;
  final Widget child;

  const RotatingWidget({this.repeat = false, required this.child, super.key});

  @override
  State<RotatingWidget> createState() => _RotatingWidgetState();
}

class _RotatingWidgetState extends State<RotatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Sets the animation controller lasting 2 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Repeats the animation indefinitely
    if (widget.repeat) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
