import 'package:flutter/services.dart';

/// Helper to copy and paste data from clipboard.
class ClipboardHelper {
  ClipboardHelper._();

  /// Stores the given clipboard data on the clipboard.
  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  /// Retrieves data from the clipboard that matches the given format.
  ///
  /// Returns a future which completes to an [String] object if it could.
  static Future<String> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text ?? '';
  }

  /// Remove all dirty data from current clipboard value.
  static Future<void> clear() async {
    await Clipboard.setData(const ClipboardData(text: ''));
  }

  /// Check if the clipboard has any dirty value.
  static Future<bool> hasText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text?.isNotEmpty ?? false;
  }
}
