// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import '../../service/senior_service_color.dart';
import '../../theme/senior_theme_data.dart';
import '../components.dart';

class SeniorColorfulHeaderStructure extends StatefulWidget {
  /// Create a view structure component with header (app bar) and body according to the design system.
  /// The [body] and [title] parameters are required.
  SeniorColorfulHeaderStructure({
    Key? key,
    this.actions,
    required this.body,
    this.notification,
    this.hasTopPadding = true,
    this.hideLeading = false,
    this.leading,
    this.style,
    required this.title,
    this.tabBarConfig,
    this.scrollController,
  }) : super(
          key: key,
        );

  /// List of actions in the header.
  final List<Widget>? actions;

  /// The content that will be displayed in the component body.
  final Widget body;

  /// Configuration of notifications that are displayed on the backdrop.
  final NotificationMessage? notification;

  /// Defines whether to have padding on top of the component's body.
  final bool hasTopPadding;

  /// Defines whether the leading will be hidden.
  final bool hideLeading;

  /// The leading of the component.
  final Widget? leading;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorColorfulHeaderStructureStyle.bodyColor] the color for the component's body.
  /// [SeniorColorfulHeaderStructureStyle.headerColors] the colors for the title bar gradient.
  final SeniorColorfulHeaderStructureStyle? style;

  /// The header title.
  final Widget title;

  /// settings for adding tabs in the app bar
  final TabBarConfig? tabBarConfig;

  /// Tab bar scroll controller.
  final ScrollController? scrollController;

  @override
  State<SeniorColorfulHeaderStructure> createState() => _SeniorColorfulHeaderStructureState();
}

class _SeniorColorfulHeaderStructureState extends State<SeniorColorfulHeaderStructure> {
  bool showNotification = false;

  final _borderRadius = const BorderRadius.only(
    topLeft: const Radius.circular(
      SeniorRadius.huge,
    ),
    topRight: Radius.circular(
      SeniorRadius.huge,
    ),
  );

  @override
  void initState() {
    super.initState();
    _showNotification();
  }

  @override
  void didUpdateWidget(SeniorColorfulHeaderStructure seniorColorfulHeaderStructure) {
    super.didUpdateWidget(seniorColorfulHeaderStructure);
    _showNotification();
  }

  void _showNotification() {
    if (widget.notification != null) {
      setState(() => showNotification = true);
      if (widget.notification?.timeout != null) {
        Future.delayed(widget.notification!.timeout!, () {
          setState(() => showNotification = false);
        });
      }
    }
  }

  Color _getMessageColor(SeniorThemeData theme) {
    if (widget.notification == null) {
      return Colors.transparent;
    }
    switch (widget.notification!.messageType) {
      case MessageTypes.messageSuccess:
        return widget.style?.successMessageBackgroundColor ??
            theme.colorfulHeaderStructureTheme?.style?.successMessageBackgroundColor ??
            SeniorColors.manchesterColorGreen100;
      case MessageTypes.messageInfo:
        return widget.style?.infoMessageBackgroundColor ??
            theme.colorfulHeaderStructureTheme?.style?.infoMessageBackgroundColor ??
            SeniorColors.manchesterColorBlue100;
      case MessageTypes.messageWarning:
        return widget.style?.warningMessageBackgroundColor ??
            theme.colorfulHeaderStructureTheme?.style?.warningMessageBackgroundColor ??
            SeniorColors.manchesterColorYellow100;
      case MessageTypes.messageError:
        return widget.style?.errorMessageBackgroundColor ??
            theme.colorfulHeaderStructureTheme?.style?.errorMessageBackgroundColor ??
            SeniorColors.manchesterColorRed100;
    }
  }

  Color _getIconColor(SeniorThemeData theme) {
    if (widget.notification == null) {
      return Colors.transparent;
    }
    switch (widget.notification!.messageType) {
      case MessageTypes.messageSuccess:
        return widget.style?.successMessageIconColor ??
            theme.colorfulHeaderStructureTheme?.style?.successMessageIconColor ??
            SeniorColors.manchesterColorGreen400;
      case MessageTypes.messageInfo:
        return widget.style?.infoMessageIconColor ??
            theme.colorfulHeaderStructureTheme?.style?.infoMessageIconColor ??
            SeniorColors.manchesterColorBlue500;
      case MessageTypes.messageWarning:
        return widget.style?.warningMessageIconColor ??
            theme.colorfulHeaderStructureTheme?.style?.warningMessageIconColor ??
            SeniorColors.manchesterColorOrange500;
      case MessageTypes.messageError:
        return widget.style?.errorMessageIconColor ??
            theme.colorfulHeaderStructureTheme?.style?.errorMessageIconColor ??
            SeniorColors.manchesterColorRed500;
    }
  }

  Widget _buildNotification(SeniorThemeData theme) {
    if (widget.notification == null) {
      return const SizedBox.shrink();
    }
    Widget action = const SizedBox.shrink();

    if (widget.notification?.actionNotification != null) {
      action = GestureDetector(
        onTap: widget.notification!.actionNotification!.action,
        child: Container(
          child: SeniorText.smallBold(
            color: SeniorColors.grayscale90,
            darkColor: SeniorColors.grayscale5,
            widget.notification!.actionNotification!.actionName,
          ),
        ),
      );
    }

    return showNotification
        ? Container(
            color: _getMessageColor(theme),
            padding: const EdgeInsets.only(
                bottom: SeniorSpacing.small,
                left: SeniorSpacing.normal,
                right: SeniorSpacing.normal,
                top: SeniorSpacing.small),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Icon(
                    widget.notification?.icon,
                    color: _getIconColor(theme),
                  ),
                  const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                  Expanded(
                    child: Container(
                      child: SeniorText.small(
                        color: widget.style?.messageTextColor ??
                            theme.colorfulHeaderStructureTheme?.style?.messageTextColor ??
                            SeniorColors.grayscale90,
                        darkColor: widget.style?.messageTextColor ??
                            theme.colorfulHeaderStructureTheme?.style?.messageTextColor ??
                            SeniorColors.grayscale5,
                        widget.notification!.message,
                        textProperties: const TextProperties(
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                  action,
                  const SizedBox(width: SeniorSpacing.xsmall),
                  if (widget.notification?.showCloseButton)
                    SeniorIconButton(
                      style: SeniorIconButtonStyle(
                        buttonColor: _getMessageColor(theme),
                        borderColor: Colors.transparent,
                        iconColor: widget.style?.messageIconColor ??
                            theme.colorfulHeaderStructureTheme?.style?.messageIconColor ??
                            SeniorColors.grayscale90,
                      ),
                      icon: FontAwesomeIcons.xmark,
                      onTap: () {
                        setState(() {
                          showNotification = false;
                        });
                      },
                      size: SeniorIconButtonSize.small,
                      type: SeniorIconButtonType.ghost,
                    )
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final withTabs = widget.tabBarConfig != null && widget.tabBarConfig!.tabs.isNotEmpty;
    final fontColor = themeRepository.isCustomTheme()
        ? SeniorServiceColor.getOptimalContrastColorTheme(
            color: themeRepository.theme.secondaryColor ?? SeniorColors.primaryColor)
        : SeniorColors.pureWhite;
    final tabs = widget.tabBarConfig?.tabs
            .asMap()
            .map(
              (int index, String tab) => MapEntry(
                index,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SeniorSpacing.xxsmall),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => widget.tabBarConfig!.tabIndex = index);
                          widget.tabBarConfig?.onSelect?.call(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SeniorSpacing.small,
                            vertical: SeniorSpacing.xxsmall,
                          ),
                          child: widget.tabBarConfig!.tabIndex == index
                              ? SeniorText.bodyBold(tab, color: fontColor)
                              : SeniorText.body(tab, color: fontColor),
                        ),
                      ),
                      widget.tabBarConfig!.tabIndex == index
                          ? Container(
                              height: 2.0,
                              width: 24.0,
                              decoration: BoxDecoration(
                                color: fontColor,
                                borderRadius: const BorderRadius.all(Radius.circular(SeniorRadius.huge)),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            )
            .values
            .toList() ??
        [];

    final theme = themeRepository.theme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.style?.headerColors ??
              theme.colorfulHeaderStructureTheme?.style?.headerColors ??
              SeniorColors.primaryGradientColors,
        ),
      ),
      child: Column(
        children: [
          AppBar(
            leading: !widget.hideLeading ? widget.leading : null,
            automaticallyImplyLeading: !widget.hideLeading,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: widget.actions,
            title: widget.title,
            centerTitle: false,
          ),
          withTabs
              ? SingleChildScrollView(
                  controller: widget.scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.xsmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tabs,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: widget.hasTopPadding ? SeniorRadius.huge : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
                color: widget.style?.bodyColor ??
                    theme.colorfulHeaderStructureTheme?.style?.bodyColor ??
                    SeniorColors.pureWhite,
              ),
              child: ClipRRect(
                borderRadius: _borderRadius,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNotification(theme),
                    Expanded(child: widget.body),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
