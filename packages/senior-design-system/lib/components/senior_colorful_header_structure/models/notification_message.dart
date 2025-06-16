import 'package:flutter/material.dart';

import 'action_notification.dart';
import 'message_types.dart';

class NotificationMessage {
  /// Backdrop notification settings.
  /// The [message], [messageType] and [icon] parameters are required.
  const NotificationMessage({
    this.timeout,
    this.actionNotification,
    required this.message,
    required this.messageType,
    required this.icon,
    this.showCloseButton = true,
  });

  /// Time the message is visible on the screen. If not informed, the notification remains on the screen until it is
  /// closed.
  final Duration? timeout;

  //Check false to hide the close button
  final showCloseButton;

  /// The notification action settings.
  final ActionNotification? actionNotification;

  /// The notification message.
  final String message;

  /// The message type. It could be [MessageTypes.messageInfo], [MessageTypes.messageSuccess],
  /// [MessageTypes.messageWarning] and [MessageTypes.messageError].
  final MessageTypes messageType;

  /// The notification icon.
  final IconData icon;
}
