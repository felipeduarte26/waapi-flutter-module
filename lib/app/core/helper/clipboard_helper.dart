import 'package:flutter/services.dart';

class ClipboardHelper {
  ClipboardHelper._();

  static Future<void> copy({
    required String value,
  }) async {
    await Clipboard.setData(
      ClipboardData(
        text: value,
      ),
    );
  }

  static Future<String?> paste() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  static Future<bool> hasData() async {
    return Clipboard.hasStrings();
  }
}
