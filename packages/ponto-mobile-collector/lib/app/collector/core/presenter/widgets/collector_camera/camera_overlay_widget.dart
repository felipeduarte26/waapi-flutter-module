import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../domain/enums/camera_type.dart';
import '../loading/loading_widget.dart';

/// The closer to 1, the rounder the ellipse will be.
double _ellipseWidthRatio = 0.7;

enum CameraOverlayState {
  initial(SeniorColors.primaryColor500, SeniorColors.pureWhite),
  processing(SeniorColors.primaryColor500, SeniorColors.pureWhite),
  error(SeniorColors.manchesterColorRed, SeniorColors.pureWhite),
  success(SeniorColors.primaryColor500, SeniorColors.pureWhite),
  alert(SeniorColors.manchesterColorOrange500, SeniorColors.pureWhite),
  ready(SeniorColors.primaryColor500, SeniorColors.pureWhite);

  final Color borderColor;
  final Color textColor;

  const CameraOverlayState(
    this.borderColor,
    this.textColor,
  );

  bool get isInitial => this == CameraOverlayState.initial;

  bool get isProcessing => this == CameraOverlayState.processing;

  bool get isError => this == CameraOverlayState.error;

  bool get isSuccess => this == CameraOverlayState.success;

  bool get isReady => this == CameraOverlayState.ready;
}

typedef OnToggleFlash = void Function();
typedef OnToggleCamera = void Function();
typedef OnCaptureImage = void Function();

class CameraOverlayWidget extends StatelessWidget {
  /// [ellipseScale] Values ​​between 0 and 1, represent the width of the ellipse in proportion to the size of the widget.
  final double ellipseScale;

  /// [ellipseBorderSize] Ellipse edge thickness in pixels.
  final int ellipseBorderSize;

  /// [ellipseHeightCenterPosition] Determines the center of the ellipse on the screen, 1 is the center
  /// values ​​less than 1 go up and values ​​greater than 1 go down
  final double ellipseHeightCenterPosition;

  /// [enableEllipsis] Determine whether or not the ellipse with the shadow will be displayed, default value is true.
  final bool enableEllipsis;

  /// [enableSquare] Determine whether or not the square will be displayed, default value is false.
  final bool enableSquare;

  final OnToggleFlash? onToggleFlash;
  final OnToggleCamera? onToggleCamera;
  final OnCaptureImage? onCaptureImage;
  final Widget? child;
  final CameraOverlayState uiState;
  final String? customMessage;
  final bool enableToggleFlash;
  final bool enableToggleCamera;
  final bool enableCaptureButton;
  final bool enableShadow;
  final bool isFraudAlert;
  final int? timerBlockFraudEvidence;
  final CameraType cameraType;

  const CameraOverlayWidget({
    super.key,
    this.ellipseScale = 0.5,
    this.ellipseBorderSize = 10,
    this.ellipseHeightCenterPosition = 1,
    this.onToggleFlash,
    this.onToggleCamera,
    this.onCaptureImage,
    required this.uiState,
    this.customMessage,
    this.enableToggleCamera = true,
    this.enableToggleFlash = true,
    this.enableCaptureButton = true,
    this.enableShadow = true,
    this.enableEllipsis = true,
    this.enableSquare = false,
    this.isFraudAlert = false,
    this.child,
    this.timerBlockFraudEvidence,
    required this.cameraType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final mediaQuery = MediaQuery.of(context);
    final isOnLandscape = mediaQuery.orientation == Orientation.landscape;

    var colorMessage = SeniorColors.pureWhite;

    if (cameraType.isFacialRecognition()) {
      return Container(
        color: SeniorColors.pureBlack,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// Camera
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isOnLandscape
                          ? mediaQuery.size.width * 0.3
                          : double.infinity,
                    ),
                    child: child!,
                  ),

                  /// Square
                  Offstage(
                    offstage: !enableSquare,
                    child: Square(
                      height: mediaQuery.size.height,
                      width: isOnLandscape
                          ? mediaQuery.size.width * 0.3
                          : mediaQuery.size.width,
                      uiState: uiState,
                    ),
                  ),

                  /// Processing Circular
                  Offstage(
                    offstage: !uiState.isProcessing,
                    child: const Align(
                      alignment: Alignment.center,
                      child: LoadingWidget(bottomLabel: ''),
                    ),
                  ),

                  /// Success Icon
                  Offstage(
                    offstage: !uiState.isSuccess,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        FontAwesomeIcons.solidCircleCheck,
                        size: SeniorIconSize.big + SeniorIconSize.xsmall,
                        color: uiState.borderColor,
                      ),
                    ),
                  ),

                  /// Buttons
                  if (isOnLandscape)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Buttons(
                        customMessage: customMessage,
                        uiState: uiState,
                        onToggleFlash: onToggleFlash,
                        enableToggleFlash: enableToggleFlash,
                        onCaptureImage: onCaptureImage,
                        enableCaptureButton: enableCaptureButton,
                        onToggleCamera: onToggleCamera,
                        enableToggleCamera: enableToggleCamera,
                        isDarkTheme: isDark,
                        isFraudAlert: isFraudAlert,
                        timerBlockFraudEvidence: timerBlockFraudEvidence,
                        isOnLandscape: isOnLandscape,
                      ),
                    ),
                ],
              ),
            ),

            /// Message
            if (isFraudAlert || customMessage != null)
              Container(
                color: SeniorColors.pureBlack,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.xxsmall,
                      bottom: SeniorSpacing.xxsmall,
                      left: SeniorSpacing.xsmall,
                      right: SeniorSpacing.xsmall,
                    ),
                    child: isFraudAlert
                        ? CountdownTimerWidget(
                            durationInSeconds: timerBlockFraudEvidence!,
                            colorMessage: colorMessage,
                          )
                        : SeniorText.label(
                            customMessage ?? '',
                            color: colorMessage,
                            textProperties: const TextProperties(
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                ),
              ),

            /// Buttons
            if (!isOnLandscape)
              Align(
                alignment: Alignment.bottomCenter,
                child: Buttons(
                  customMessage: customMessage,
                  uiState: uiState,
                  onToggleFlash: onToggleFlash,
                  enableToggleFlash: enableToggleFlash,
                  onCaptureImage: onCaptureImage,
                  enableCaptureButton: enableCaptureButton,
                  onToggleCamera: onToggleCamera,
                  enableToggleCamera: enableToggleCamera,
                  isDarkTheme: isDark,
                  isFraudAlert: isFraudAlert,
                  timerBlockFraudEvidence: timerBlockFraudEvidence,
                  isOnLandscape: isOnLandscape,
                ),
              ),
          ],
        ),
      );
    } else {
      return Container(
        color: SeniorColors.pureBlack,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            /// Camera
            FittedBox(
              fit: isOnLandscape ? BoxFit.contain : BoxFit.cover,
              child: child,
            ),

            /// Ellipsis
            Offstage(
              offstage: !enableEllipsis,
              child: Ellipsis(
                enableShadow: enableShadow,
                ellipseScale: isOnLandscape ? 0.75 : ellipseScale,
                ellipseBorderSize: ellipseBorderSize,
                uiState: uiState,
                ellipseHeightCenterPosition: 1,
              ),
            ),

            Align(
              alignment: isOnLandscape
                  ? Alignment.centerRight
                  : Alignment.bottomCenter,
              child: Buttons(
                customMessage: customMessage,
                uiState: uiState,
                onToggleFlash: onToggleFlash,
                enableToggleFlash: enableToggleFlash,
                onCaptureImage: onCaptureImage,
                enableCaptureButton: enableCaptureButton,
                onToggleCamera: onToggleCamera,
                enableToggleCamera: enableToggleCamera,
                isDarkTheme: isDark,
                isFraudAlert: isFraudAlert,
                timerBlockFraudEvidence: timerBlockFraudEvidence,
                isOnLandscape: isOnLandscape,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class Buttons extends StatelessWidget {
  final CameraOverlayState uiState;
  final OnToggleFlash? onToggleFlash;
  final OnCaptureImage? onCaptureImage;
  final OnToggleCamera? onToggleCamera;
  final bool enableToggleFlash;
  final bool enableCaptureButton;
  final bool enableToggleCamera;
  final String? customMessage;
  final bool isDarkTheme;
  final bool isFraudAlert;
  final int? timerBlockFraudEvidence;
  final bool isOnLandscape;

  const Buttons({
    super.key,
    required this.customMessage,
    required this.uiState,
    required this.onToggleFlash,
    required this.enableToggleFlash,
    required this.onCaptureImage,
    required this.enableCaptureButton,
    required this.onToggleCamera,
    required this.enableToggleCamera,
    required this.isDarkTheme,
    required this.isFraudAlert,
    required this.timerBlockFraudEvidence,
    required this.isOnLandscape,
  });

  List<Widget> getButtons() {
    return [
      /// Light Button
      if (enableToggleFlash)
        Align(
          alignment:
              isOnLandscape ? Alignment.bottomCenter : Alignment.centerLeft,
          child: IconButton(
            onPressed: () => onToggleFlash?.call(),
            icon: const Icon(
              FontAwesomeIcons.boltLightning,
              size: SeniorIconSize.medium,
              color: SeniorColors.pureWhite,
            ),
          ),
        ),

      /// Camera Capture Button
      if (enableCaptureButton)
        Align(
          child: IconButton(
            key: const Key('cameraCaptureButtonKey'),
            iconSize: SeniorIconSize.big + SeniorIconSize.xsmall,
            onPressed: onCaptureImage,
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: enableCaptureButton
                      ? SeniorColors.pureWhite
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Ink(
                child: Container(
                  height: SeniorIconSize.big + SeniorIconSize.xsmall,
                  width: SeniorIconSize.big + SeniorIconSize.xsmall,
                  decoration: BoxDecoration(
                    color: enableCaptureButton
                        ? SeniorColors.pureWhite
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),

      /// Camera Change Button
      if (enableToggleCamera)
        Align(
          alignment:
              isOnLandscape ? Alignment.topCenter : Alignment.centerRight,
          child: IconButton(
            onPressed: () => onToggleCamera?.call(),
            icon: const Icon(
              FontAwesomeIcons.cameraRotate,
              size: SeniorIconSize.medium,
              color: SeniorColors.pureWhite,
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final color =
        Platform.isAndroid ? SeniorColors.pureBlack : Colors.transparent;
    final padding = EdgeInsets.only(
      bottom: Platform.isIOS ? SeniorSpacing.normal : SeniorSpacing.xsmall,
      top: SeniorSpacing.xsmall,
      left: SeniorSpacing.xsmall,
      right: SeniorSpacing.xsmall,
    );

    if (isOnLandscape) {
      return IntrinsicWidth(
        child: Container(
          color: color,
          padding: padding,
          child: Stack(
            children: getButtons(),
          ),
        ),
      );
    }

    return IntrinsicHeight(
      child: Container(
        color: color,
        padding: padding,
        child: Stack(
          children: getButtons(),
        ),
      ),
    );
  }
}

double scaleValidation(double scale) {
  if (scale > 1) {
    return 1;
  } else if (scale < 0) {
    return 0;
  } else {
    return scale;
  }
}

class OvalShadePath extends CustomClipper<Path> {
  late final double _heightScale;
  late final double _ellipseHeightCenterPosition;

  OvalShadePath({
    required double heightScale,
    required double ellipseHeightCenterPosition,
  }) {
    _heightScale = scaleValidation(heightScale);
    _ellipseHeightCenterPosition = ellipseHeightCenterPosition;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    path.fillType = PathFillType.evenOdd;
    path.addRect(rect);

    path.addOval(
      Rect.fromCenter(
        center: Offset(
          size.width / 2,
          size.height * _ellipseHeightCenterPosition / 2,
        ),
        width: size.height * _heightScale * _ellipseWidthRatio,
        height: size.height * _heightScale,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant OvalShadePath oldClipper) {
    return false;
  }
}

class OvalBorderClipper extends CustomClipper<Path> {
  late final double _heightScale;
  late final int _border;
  late final double _ellipseHeightCenterPosition;

  OvalBorderClipper({
    required double heightScale,
    required int border,
    required double ellipseHeightCenterPosition,
  }) {
    _heightScale = scaleValidation(heightScale);
    _border = border;
    _ellipseHeightCenterPosition = ellipseHeightCenterPosition;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();

    final rect = Rect.fromCenter(
      center: Offset(
        size.width / 2,
        size.height * _ellipseHeightCenterPosition / 2,
      ),
      width: size.height * _heightScale * _ellipseWidthRatio,
      height: size.height * _heightScale,
    );

    path.fillType = PathFillType.evenOdd;
    path.addOval(rect);

    path.addOval(
      Rect.fromCenter(
        center: Offset(
          size.width / 2,
          size.height * _ellipseHeightCenterPosition / 2,
        ),
        width: (size.height * _heightScale * _ellipseWidthRatio) + _border,
        height: (size.height * _heightScale) + _border,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class OvalSuccessShadePath extends CustomClipper<Path> {
  late final double _heightScale;
  late final double _ellipseHeightCenterPosition;

  OvalSuccessShadePath({
    required double heightScale,
    required double ellipseHeightCenterPosition,
  }) {
    _heightScale = scaleValidation(heightScale);
    _ellipseHeightCenterPosition = ellipseHeightCenterPosition;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addOval(
      Rect.fromCenter(
        center: Offset(
          size.width / 2,
          size.height * _ellipseHeightCenterPosition / 2,
        ),
        width: size.height * _heightScale * _ellipseWidthRatio,
        height: size.height * _heightScale,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant OvalSuccessShadePath oldClipper) {
    return false;
  }
}

class CountdownTimerWidget extends StatefulWidget {
  final int durationInSeconds;
  final Color colorMessage;

  const CountdownTimerWidget({
    super.key,
    required this.durationInSeconds,
    required this.colorMessage,
  });

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.durationInSeconds;
    _startTimer();
  }

  @override
  void didUpdateWidget(CountdownTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.durationInSeconds != widget.durationInSeconds) {
      _remainingTime = widget.durationInSeconds;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return remainingSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeniorText.label(
          '${CollectorLocalizations.of(context).recognitionBlocked}:',
          color: widget.colorMessage,
          textProperties: const TextProperties(textAlign: TextAlign.center),
          style: const TextStyle(
            height: 1.2,
          ),
        ),
        SeniorText.label(
          '${_formatTime(_remainingTime)} ${CollectorLocalizations.of(context).secondsFullName}',
          color: widget.colorMessage,
          textProperties: const TextProperties(textAlign: TextAlign.center),
          style: const TextStyle(
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class Ellipsis extends StatelessWidget {
  final bool enableShadow;
  final double ellipseScale;
  final int ellipseBorderSize;
  final CameraOverlayState uiState;
  final double ellipseHeightCenterPosition;

  const Ellipsis({
    super.key,
    required this.enableShadow,
    required this.ellipseScale,
    required this.ellipseBorderSize,
    required this.uiState,
    required this.ellipseHeightCenterPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Ellipse Shade
        Offstage(
          offstage: !enableShadow,
          child: ClipPath(
            clipper: OvalShadePath(
              heightScale: ellipseScale,
              ellipseHeightCenterPosition: ellipseHeightCenterPosition,
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.6)),
          ),
        ),

        /// Ellipse Border
        ClipPath(
          clipper: OvalBorderClipper(
            border: ellipseBorderSize,
            heightScale: ellipseScale,
            ellipseHeightCenterPosition: ellipseHeightCenterPosition,
          ),
          child: Container(color: uiState.borderColor),
        ),
      ],
    );
  }
}

class Square extends StatelessWidget {
  final CameraOverlayState uiState;
  final double width;
  final double height;

  const Square({
    super.key,
    required this.uiState,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: uiState.borderColor,
        ),
      ),
    );
  }
}
