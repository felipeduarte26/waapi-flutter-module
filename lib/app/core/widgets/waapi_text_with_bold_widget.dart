import 'package:flutter/widgets.dart';

class WaapiTextWithBold extends StatelessWidget {
  final String text;
  final TextStyle typography;
  final TextStyle typographyBold;

  const WaapiTextWithBold({
    Key? key,
    required this.text,
    required this.typography,
    required this.typographyBold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: typography,
        children: _parseText(text),
      ),
    );
  }

  List<TextSpan> _parseText(String text) {
    final regex = RegExp(r'\*\*(.*?)\*\*');
    final matches = regex.allMatches(text);
    int lastMatchEnd = 0;
    List<TextSpan> spans = [];

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: typography,
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: typographyBold,
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
