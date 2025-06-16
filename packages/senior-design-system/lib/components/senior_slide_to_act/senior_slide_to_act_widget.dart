import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_slide_to_act_style.dart';
import '../senior_elevated_element/senior_elevated_element.dart';
import '../../repositories/theme_repository.dart';

class SeniorSlideToAct extends StatefulWidget {
  /// Creates the SeniorSlideToAct component.
  /// The [text] parameter is mandatory.
  const SeniorSlideToAct({
    Key? key,
    this.onSubmit,
    this.reversed = false,
    required this.text,
    this.style,
  }) : super(key: key);

  /// Callback function called when the slide is completed.
  /// The submitted status is only set when the [onSubmit] is informed.
  final VoidCallback? onSubmit;

  /// Whether the component's sliding direction will be reversed.
  /// The default is left to right.
  /// The default value is false.
  final bool reversed;

  /// The text displayed inside the component in the slider area.
  final String text;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorSlideToActStyle.containerColor] the color of the entire container.
  /// [SeniorSlideToActStyle.slideButtonColor] the color of the slide button.
  /// [SeniorSlideToActStyle.slideButtonIconColor] the color of the slide button icon.
  /// [SeniorSlideToActStyle.submittedIconColor] the color of the icon that is displayed in the submitted animation.
  /// [SeniorSlideToActStyle.textColor] the color of the displayed text.
  final SeniorSlideToActStyle? style;

  @override
  SeniorSlideToActState createState() => SeniorSlideToActState();
}

class SeniorSlideToActState extends State<SeniorSlideToAct>
    with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _sliderKey = GlobalKey();

  final Duration _animationDuration = const Duration(milliseconds: 300);

  final double _containerHeight = 56.0;
  final Size _buttonSize = const Size(88.0, 48.0);
  final double _padding = 4.0;

  double _dx = 0;
  double _maxDx = 0;
  double _endDx = 0;
  double _dz = 1;
  double _checkAnimationDx = 0;

  double? _initialContainerWidth;
  double? _containerWidth;

  bool submitted = false;

  late AnimationController _checkAnimationController;
  late AnimationController _shrinkAnimationController;
  late AnimationController _resizeAnimationController;
  late AnimationController _cancelAnimationController;

  double get _progress => _dx == 0 ? 0 : _dx / _maxDx;

  double get _opacity {
    final double opacity = 1 - 1 * _progress * 2;
    return opacity >= 0 ? opacity : 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(widget.reversed ? pi : 0),
      child: SeniorElevatedElement(
        borderRadius: SeniorRadius.xbig,
        elevation: SeniorElevations.dp01,
        child: Container(
          key: _containerKey,
          height: _containerHeight,
          width: _containerWidth,
          constraints: _containerWidth != null
              ? null
              : BoxConstraints.expand(height: _containerHeight),
          decoration: BoxDecoration(
            color: widget.style?.containerColor ??
                theme.slideToActTheme?.style?.containerColor ??
                SeniorColors.grayscale10,
            borderRadius: BorderRadius.circular(SeniorRadius.xbig),
          ),
          child: submitted
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(widget.reversed ? pi : 0),
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.check,
                          color: widget.style?.submittedIconColor ??
                              theme
                                  .slideToActTheme?.style?.submittedIconColor ??
                              SeniorColors.primaryColor,
                        ),
                        Positioned.fill(
                          right: 0,
                          child: Transform(
                            transform:
                                Matrix4.rotationY(_checkAnimationDx * (pi / 2)),
                            alignment: Alignment.centerRight,
                            child: Container(
                              color: widget.style?.containerColor ??
                                  theme
                                      .slideToActTheme?.style?.containerColor ??
                                  SeniorColors.grayscale10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Opacity(
                      opacity: _opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(widget.reversed ? pi : 0),
                        child: Padding(
                          padding: widget.reversed
                              ? EdgeInsets.only(right: _buttonSize.width)
                              : EdgeInsets.only(left: _buttonSize.width),
                          child: Text(
                            widget.text,
                            textAlign: TextAlign.center,
                            style: SeniorTypography.cta(
                              color: widget.style?.textColor ??
                                  theme.slideToActTheme?.style?.textColor ??
                                  SeniorColors.grayscale90,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Transform.scale(
                        scale: _dz,
                        origin: Offset(_dx, 0),
                        child: Transform.translate(
                          offset: Offset(_dx, 0),
                          child: Container(
                            key: _sliderKey,
                            child: GestureDetector(
                              onHorizontalDragUpdate: onHorizontalDragUpdate,
                              onHorizontalDragEnd: (details) async {
                                _endDx = _dx;
                                if (_progress <= 0.8 ||
                                    widget.onSubmit == null) {
                                  _cancelAnimation();
                                } else {
                                  await _resizeAnimation();
                                  await _shrinkAnimation();
                                  await _checkAnimation();
                                  widget.onSubmit!();
                                }
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: _padding),
                                child: Container(
                                  height: _buttonSize.height,
                                  width: _buttonSize.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SeniorRadius.xbig),
                                    color: widget.style?.slideButtonColor ??
                                        theme.slideToActTheme?.style
                                            ?.slideButtonColor ??
                                        SeniorColors.primaryColor,
                                  ),
                                  child: Transform.rotate(
                                    angle: -pi * _progress,
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowRight,
                                        size: SeniorIconSize.medium,
                                        color: widget
                                                .style?.slideButtonIconColor ??
                                            theme.slideToActTheme?.style
                                                ?.slideButtonIconColor ??
                                            SeniorColors.grayscale10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dx = (_dx + details.delta.dx).clamp(0.0, _maxDx);
    });
  }

  /// Call this method to revert the animations
  Future reset() async {
    await _checkAnimationController.reverse().orCancel;
    submitted = false;
    await _shrinkAnimationController.reverse().orCancel;
    await _resizeAnimationController.reverse().orCancel;
    await _cancelAnimation();
  }

  Future _checkAnimation() async {
    _checkAnimationController.reset();
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _checkAnimationController,
      curve: Curves.slowMiddle,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _checkAnimationDx = animation.value;
        });
      }
    });
    await _checkAnimationController.forward().orCancel;
  }

  Future _shrinkAnimation() async {
    _shrinkAnimationController.reset();

    final diff = _initialContainerWidth! - _containerHeight;
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shrinkAnimationController,
      curve: Curves.easeOutCirc,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _containerWidth = _initialContainerWidth! - (diff * animation.value);
        });
      }
    });

    setState(() {
      submitted = true;
    });
    await _shrinkAnimationController.forward().orCancel;
  }

  Future _resizeAnimation() async {
    _resizeAnimationController.reset();

    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _resizeAnimationController,
      curve: Curves.easeInBack,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dz = 1 - animation.value;
        });
      }
    });
    await _resizeAnimationController.forward().orCancel;
  }

  Future _cancelAnimation() async {
    _cancelAnimationController.reset();
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _cancelAnimationController,
      curve: Curves.fastOutSlowIn,
    ));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dx = (_endDx - (_endDx * animation.value));
        });
      }
    });
    _cancelAnimationController.forward().orCancel;
  }

  @override
  void initState() {
    super.initState();

    _cancelAnimationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _checkAnimationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _shrinkAnimationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _resizeAnimationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox containerBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox;
      _containerWidth = containerBox.size.width;
      _initialContainerWidth = _containerWidth;

      final RenderBox sliderBox =
          _sliderKey.currentContext!.findRenderObject() as RenderBox;
      final sliderWidth = sliderBox.size.width;

      _maxDx = _containerWidth! -
          (sliderWidth / 2) -
          _buttonSize.width / 2 -
          _padding;
    });
  }

  @override
  void dispose() {
    _cancelAnimationController.dispose();
    _checkAnimationController.dispose();
    _shrinkAnimationController.dispose();
    _resizeAnimationController.dispose();
    super.dispose();
  }
}
