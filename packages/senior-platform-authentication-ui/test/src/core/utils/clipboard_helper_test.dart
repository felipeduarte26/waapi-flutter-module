import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/clipboard_helper.dart';

import '../../../mocks/clipboard_mock.dart';

void main() {
  final MockClipboard mockClipboard = MockClipboard();
  TestWidgetsFlutterBinding.ensureInitialized()
      .defaultBinaryMessenger
      .setMockMethodCallHandler(
          SystemChannels.platform, mockClipboard.handleMethodCall);

  test('ClipboardHelper.hasText returns true', () async {
    mockClipboard.clipboardData = <String, dynamic>{
      'text': 'Hello world',
    };
    final bool hasText = await ClipboardHelper.hasText();
    expect(hasText, true);
  });

  test(
      'ClipboardHelper.hasText returns false'
      ' when data is null', () async {
    mockClipboard.clipboardData = null;
    final bool hasText = await ClipboardHelper.hasText();
    expect(hasText, false);
  });

  test(
      'ClipboardHelper.hasText returns false'
      ' when text is empty', () async {
    mockClipboard.clipboardData = <String, dynamic>{
      'text': '',
    };
    final bool hasText = await ClipboardHelper.hasText();
    expect(hasText, false);
  });

  test('Clipboard.copy sets text to Flutter\' Clipboard', () async {
    await ClipboardHelper.copy('Hello world');

    expect(mockClipboard.clipboardData, <String, dynamic>{
      'text': 'Hello world',
    });
  });

  test('Clipboard.clear resets text of Flutter\' Clipboard', () async {
    await ClipboardHelper.copy('Hello World');

    expect(mockClipboard.clipboardData, <String, dynamic>{
      'text': 'Hello World',
    });

    await ClipboardHelper.clear();
    expect(mockClipboard.clipboardData, <String, dynamic>{
      'text': '',
    });
  });

  test('ClipboardHelper.paste returns text of Flutter\' Clipboard', () async {
    mockClipboard.clipboardData = <String, dynamic>{
      'text': 'Hello world',
    };
    final String text = await ClipboardHelper.paste();
    expect(text, 'Hello world');
  });
}
