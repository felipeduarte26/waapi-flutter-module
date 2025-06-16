import 'package:flutter/material.dart';

class ImageHelperWidget extends StatelessWidget {
  final String? urlLink;
  final String? assetLink;
  const ImageHelperWidget({
    super.key,
    this.urlLink = '',
    this.assetLink = '',
  });

  @override
  Widget build(BuildContext context) {
    if (urlLink != '') {
      return Image.network(
        urlLink!,
        fit: BoxFit.fill,
      );
    }

    if (assetLink != '') {
      return Image.asset(
        assetLink!,
        fit: BoxFit.fill,
      );
    }

    return const SizedBox.shrink();
  }
}
