import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../senior_profile_picture/senior_profile_picture_widget.dart';
import '../../repositories/theme_repository.dart';

OverlayEntry? _previousEntry;

void showTopSnackBar({
  required BuildContext context,
  required SeniorNotificationSnackbar child,
  OverlayState? overlayState,
}) async {
  overlayState ??= Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (_) {
      return _SeniorTopSnackbar(
        child: child,
        onDismissed: () {
          overlayEntry.remove();
          _previousEntry = null;
        },
        onTap: () {
          child.seniorNotificationSnackBarAction?.onPressed?.call();
        },
      );
    },
  );

  _previousEntry?.remove();
  overlayState.insert(overlayEntry);
  _previousEntry = overlayEntry;
}

class _SeniorTopSnackbar extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final VoidCallback? onTap;

  _SeniorTopSnackbar({
    Key? key,
    required this.child,
    required this.onDismissed,
    this.onTap,
  }) : super(key: key);

  @override
  _SeniorTopSnackbarState createState() => _SeniorTopSnackbarState();
}

class _SeniorTopSnackbarState extends State<_SeniorTopSnackbar>
    with SingleTickerProviderStateMixin {
  late Animation offsetAnimation;
  late AnimationController animationController;
  double? topPosition;

  @override
  void initState() {
    topPosition = SeniorSpacing.xsmall;
    _setupAndStartAnimation();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setupAndStartAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    final Tween<Offset> offsetTween = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    );

    offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
        reverseCurve: Curves.ease,
      ),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(
            const Duration(milliseconds: 4000),
          );
          if (mounted) {
            animationController.reverse();
            setState(() {
              topPosition = 0;
            });
          }
        }

        if (status == AnimationStatus.dismissed) {
          widget.onDismissed.call();
        }
      });

    if (mounted) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      top: topPosition,
      left: SeniorSpacing.normal,
      right: SeniorSpacing.normal,
      child: SlideTransition(
        position: offsetAnimation as Animation<Offset>,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (mounted) {
                widget.onTap?.call();
                animationController.reverse();
                setState(() {
                  topPosition = 0;
                });
              }
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class SeniorNotificationSnackBarAction {
  final String title;
  final VoidCallback? onPressed;

  SeniorNotificationSnackBarAction({
    required this.title,
    this.onPressed,
  });
}

class SeniorNotificationSnackbar extends StatefulWidget {
  final String title;
  final String message;
  final Widget? icon;
  final SeniorNotificationSnackBarAction? seniorNotificationSnackBarAction;

  SeniorNotificationSnackbar.avatar({
    Key? key,
    required this.title,
    required this.message,
    required ImageProvider imageProvider,
    required String employeeName,
    this.seniorNotificationSnackBarAction,
  }) : icon = SeniorProfilePicture(
          radius: SeniorRadius.huge,
          name: employeeName,
          imageProvider: imageProvider,
        );

  SeniorNotificationSnackbar.icon({
    Key? key,
    required this.title,
    required this.message,
    required IconData iconData,
    required Color circleColor,
    this.seniorNotificationSnackBarAction,
  }) : icon = CircleAvatar(
          radius: SeniorRadius.huge,
          backgroundColor: circleColor,
          child: Icon(
            iconData,
            size: SeniorIconSize.xsmall,
            color: Colors.white,
          ),
        );

  SeniorNotificationSnackbar({
    Key? key,
    required this.title,
    required this.message,
    this.seniorNotificationSnackBarAction,
    this.icon,
  });

  @override
  _SeniorNotificationSnackbarState createState() =>
      _SeniorNotificationSnackbarState();
}

class _SeniorNotificationSnackbarState
    extends State<SeniorNotificationSnackbar> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.notificationSnackbarTheme?.style?.color ??
            SeniorColors.grayscale20.withOpacity(0.93),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            SeniorRadius.medium,
          ),
        ),
        border: Border.all(
          color: theme.notificationSnackbarTheme?.style?.borderColor ??
              Colors.transparent,
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 1.0),
            spreadRadius: 0.2,
            blurRadius: 4,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.xxsmall,
        top: SeniorSpacing.xsmall,
        bottom: SeniorSpacing.xsmall,
      ),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Row(
            children: [
              widget.icon == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                        right: SeniorSpacing.xsmall,
                      ),
                      child: widget.icon,
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: SeniorTypography.smallBold(
                        color: theme
                                .notificationSnackbarTheme?.style?.titleColor ??
                            SeniorColors.grayscale90,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      widget.message,
                      style: SeniorTypography.small(
                        color: theme.notificationSnackbarTheme?.style
                                ?.messageColor ??
                            SeniorColors.grayscale90,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              widget.seniorNotificationSnackBarAction == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.xsmall,
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.resolveWith<Color?>(
                                  (_) => SeniorColors.grayscale30),
                        ),
                        onPressed: null,
                        child: Text(
                          widget.seniorNotificationSnackBarAction!.title,
                          style: SeniorTypography.smallBold(
                            color: theme.notificationSnackbarTheme?.style
                                    ?.actionButtonColor ??
                                SeniorColors.grayscale90,
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
}
