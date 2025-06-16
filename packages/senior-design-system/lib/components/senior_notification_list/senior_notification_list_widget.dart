import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import '../../theme/senior_theme_data.dart';
import '../components.dart';

class SeniorNotification {
  /// The information for creating a notification in the SeniorNotificationList component.
  ///
  /// The [body], [footer], [isRead] and [title] parameters are required.
  const SeniorNotification({
    required this.body,
    required this.footer,
    required this.isRead,
    this.removalConfirmation,
    this.onRemove,
    this.removeLabel,
    this.severity = SeniorNotificationListItemSeverity.none,
    required this.title,
  });

  /// The body content of the notification.
  final String body;

  /// The footer content of the notification.
  final String footer;

  /// Whether the notification has been read.
  final bool isRead;

  /// Removal confirmation function returning a boolean that defines whether the
  /// removal will continue (true) or be canceled (false)
  final Future<bool?> Function()? removalConfirmation;

  /// Function that runs when the item is removed.
  final VoidCallback? onRemove;

  /// Text that appears in the option to remove the item.
  final String? removeLabel;

  /// The severity status of item, represented by a color dot next to title on notification item.
  final SeniorNotificationListItemSeverity severity;

  /// The title of the notification.
  final String title;
}

class SeniorNotificationList extends StatefulWidget {
  /// Creates a component to display a list of notifications.
  ///
  /// The [notifications] and [title] parameters are required.
  const SeniorNotificationList({
    Key? key,
    this.actionButtonLabel,
    this.busyActionButton = false,
    this.disabledActionButton = false,
    this.isLoading = false,
    this.loadButtonLabel,
    required this.notifications,
    this.onLoad,
    this.onNotificationTap,
    this.onTapActionButton,
    this.scrollController,
    this.style,
    required this.title,
  }) : super(key: key);

  /// An action button that appears after the list.
  /// The button executes the function passed in the [onTapActionButton] parameter.
  final String? actionButtonLabel;

  /// Defines whether the action button will be in a busy state (loading).
  ///
  /// The default value is false.
  final bool busyActionButton;

  /// Defines whether the action button will be disabled.
  ///
  /// The default value is false.
  final bool disabledActionButton;

  /// Defines whether list information is being loaded.
  /// In this state it displays a SeniorLoading.
  ///
  /// The default value is false.
  final bool isLoading;

  /// Button label to load more items in the list.
  /// The button is only displayed if the value of the parameters [loadButtonLabel] and [onLoad] are different from null.
  final String? loadButtonLabel;

  /// The list of notifications that will be displayed.
  final List<SeniorNotification> notifications;

  /// Callback function executed when the button to load more items in the list is pressed.
  /// The button is only displayed if the value of the parameters [loadButtonLabel] and [onLoad] are different from null.
  final Function()? onLoad;

  /// Callback function executed when notification is tapped.
  /// Receives the selected notification index.
  final Function(int)? onNotificationTap;

  /// Callback function executed when action button is pressed.
  final Function()? onTapActionButton;

  /// The ScrollController used in the component's scrollbar.
  final ScrollController? scrollController;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorNotificationListStyle.notificationBodyColor] the color of the notification's body content.
  /// [SeniorNotificationListStyle.notificationFooterColor] the color of the notification's footer content.
  /// [SeniorNotificationListStyle.notificationTitleColor] the color of the notification title.
  /// [SeniorNotificationListStyle.separatorColor] the color of the notifications tab.
  /// [SeniorNotificationListStyle.titleColor] the color of the notification list title.
  final SeniorNotificationListStyle? style;

  /// The title of the notification list.
  final String title;

  @override
  State<SeniorNotificationList> createState() => _SeniorNotificationListState();
}

class _SeniorNotificationListState extends State<SeniorNotificationList> {
  Widget _buildSeverityDot(SeniorNotification notification) {
    if (notification.severity == SeniorNotificationListItemSeverity.none) {
      return const SizedBox.shrink();
    }

    final Color dotColor;

    switch (notification.severity) {
      case SeniorNotificationListItemSeverity.error:
        dotColor = SeniorColors.manchesterColorRed500;
      case SeniorNotificationListItemSeverity.warning:
        dotColor = SeniorColors.manchesterColorOrange500;
      case SeniorNotificationListItemSeverity.success:
        dotColor = SeniorColors.manchesterColorGreen500;
      default:
        dotColor = Colors.transparent;
    }

    return Container(
      margin: const EdgeInsets.all(SeniorSpacing.xsmall),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: dotColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  Widget _buildNotification(SeniorNotification notification, SeniorThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: notification.severity == SeniorNotificationListItemSeverity.none ? SeniorSpacing.xmedium : 0,
        vertical: SeniorSpacing.normal,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSeverityDot(notification),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.xsmall,
                  ),
                  child: Text(
                    notification.title,
                    style: SeniorTypography.body(
                      color: widget.style?.notificationTitleColor ??
                          theme.notificationListTheme?.style?.notificationTitleColor ??
                          SeniorColors.pureBlack,
                    ).copyWith(
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.xsmall,
                  ),
                  child: Text(
                    notification.body,
                    style: SeniorTypography.body(
                      color: widget.style?.notificationBodyColor ??
                          theme.notificationListTheme?.style?.notificationBodyColor ??
                          SeniorColors.grayscale80,
                    ),
                  ),
                ),
                Text(
                  notification.footer,
                  style: SeniorTypography.small(
                    color: widget.style?.notificationFooterColor ??
                        theme.notificationListTheme?.style?.notificationFooterColor ??
                        SeniorColors.grayscale50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    final padding = MediaQuery.of(context).padding;

    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.xmedium,
                vertical: SeniorSpacing.small,
              ),
              child: Text(
                widget.title,
                style: SeniorTypography.body(
                  color: widget.style?.titleColor ??
                      theme.notificationListTheme?.style?.titleColor ??
                      SeniorColors.grayscale80,
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: widget.scrollController,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                controller: widget.scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.notifications.length,
                separatorBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.normal,
                    ),
                    height: SeniorSpacing.xxxsmall,
                    color: widget.style?.separatorColor ??
                        theme.notificationListTheme?.style?.separatorColor ??
                        SeniorColors.grayscale30,
                  );
                },
                itemBuilder: (context, index) {
                  final notification = widget.notifications[index];

                  if (index == widget.notifications.length) {
                    if (widget.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(
                          SeniorSpacing.normal,
                        ),
                        child: Center(
                          child: const SeniorLoading(),
                        ),
                      );
                    }

                    return widget.onLoad != null && widget.loadButtonLabel != null && !widget.isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(SeniorSpacing.normal),
                            child: SeniorButton.ghost(
                              label: widget.loadButtonLabel!,
                              onPressed: widget.onLoad!,
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  return Dismissible(
                    key: UniqueKey(),
                    confirmDismiss: (direction) async {
                      if (notification.removalConfirmation != null) {
                        return await notification.removalConfirmation!.call();
                      } else {
                        return true;
                      }
                    },
                    direction: (notification.removeLabel == null &&
                            notification.onRemove == null &&
                            notification.removalConfirmation == null)
                        ? DismissDirection.none
                        : DismissDirection.endToStart,
                    background: Container(
                      color: SeniorColors.manchesterColorRed500,
                      padding: const EdgeInsets.all(SeniorSpacing.xsmall),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.trashCan,
                              color: SeniorColors.pureWhite,
                            ),
                            widget.notifications[index].removeLabel != null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: SeniorSpacing.xsmall),
                                    child: SeniorText.small(
                                      widget.notifications[index].removeLabel!,
                                      color: SeniorColors.pureWhite,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        widget.notifications.removeAt(index);
                      });
                    },
                    child: InkWell(
                      onTap: widget.onNotificationTap != null ? () => widget.onNotificationTap!(index) : null,
                      child: _buildNotification(widget.notifications[index], theme),
                    ),
                  );
                },
              ),
            ),
          ),
          (widget.onTapActionButton != null && widget.actionButtonLabel != null)
              ? Padding(
                  padding: const EdgeInsets.all(SeniorSpacing.normal),
                  child: SeniorButton.primary(
                    label: widget.actionButtonLabel!,
                    onPressed: widget.onTapActionButton!,
                    busy: widget.busyActionButton,
                    disabled: widget.disabledActionButton,
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: padding.bottom,
          ),
        ],
      ),
    );
  }
}
