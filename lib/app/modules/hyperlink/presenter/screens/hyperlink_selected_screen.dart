import 'package:flutter/material.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import '../../domain/entities/hyperlink_entity.dart';
import '../widgets/hyperlink_web_view_widget.dart';

class HyperlinkSelectedScreen extends StatelessWidget {
  final HyperlinkEntity hyperlink;

  const HyperlinkSelectedScreen({
    Key? key,
    required this.hyperlink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: hyperlink.label ?? '',
        body: HyperlinkWebViewWidget(
          hyperlink: hyperlink,
        ),
      ),
    );
  }
}
