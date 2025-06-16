import 'package:flutter/material.dart';

abstract class IBottomSheetService {
  Future<dynamic> show({
    required BuildContext context,
    required List<Widget> content,
    userRootContext = true,
  });
}
