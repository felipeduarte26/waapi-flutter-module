import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../domain/services/bottom_sheet_service/ibottom_sheet_service.dart';

class BottomSheetService implements IBottomSheetService {
  @override
  Future show({
    required BuildContext context,
    required List<Widget> content,
    userRootContext = true,
  }) {
    final themeRepository =
        Provider.of<ThemeRepository>(context, listen: false);
    BuildContext contextToUse = userRootContext
        ? Navigator.of(
            context,
            rootNavigator: true,
          ).context
        : context;

    return SeniorBottomSheet.showDynamicBottomSheet(
      style: SeniorBottomSheetStyle(
        closeButtonColor: themeRepository.isCustomTheme()
            ? SeniorServiceColor.getContrastAdjustedColorTheme(
                color: themeRepository.theme.primaryColor!,
              )
            : SeniorColors.primaryColor600,
      ),
      enableDrag: true,
      isDismissible: true,
      context: contextToUse,
      hasCloseButton: true,
      onTapCloseButton: () {
        Navigator.pop(contextToUse);
      },
      content: content,
    );
  }
}
