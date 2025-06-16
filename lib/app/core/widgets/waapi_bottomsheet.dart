import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

class WaapiBottomsheet {
  static void showDynamicBottomSheet({
    required BuildContext context,
    required List<Widget> content,
  }) {
    SeniorBottomSheet.showDynamicBottomSheet(
      context: context,
      content: content,
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
