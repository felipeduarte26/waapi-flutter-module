class SeniorModalDefinitions {
  /// Object with definitions to create modals.
  SeniorModalDefinitions({
    required this.cancelLabel,
    required this.confirmLabel,
    required this.content,
    required this.title,
  });

  /// The text for the button with the cancel function.
  final String cancelLabel;

  /// The text for the confirmation button.
  final String confirmLabel;

  /// The message shown in the modal.
  final String content;

  /// The modal title.
  final String title;
}
