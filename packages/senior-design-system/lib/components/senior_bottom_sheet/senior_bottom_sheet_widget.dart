import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../repositories/theme_repository.dart';
import './senior_bottom_sheet_style.dart';

class SeniorBottomSheet {
  /// Adds a bottom sheet component to the application.
  ///
  /// The [context], [height], [content], and [hasCloseButton] parameters are required.
  /// The [context] parameter expects to receive the current application context.
  /// The [content] parameter specifies the list of internal elements that will be presented in the bottom sheet.
  /// The [hasCloseButton] parameter specifies whether the bottom sheet will have a button to close it.
  /// The [height] parameter specifies the height of the bottom sheet.
  /// The [title] parameter sets a title for the bottom sheet.
  /// The [titleTextStyle] parameter sets the bottom sheet title text style.
  /// The [onTapCloseButton] parameter specifies a function that will be executed whenever the close button is tapped.
  /// The [style] parameter contains the component's style settings.
  /// The [isDismissible] parameter specifies whether the bottom sheet will be dismissed when user taps on the scrim.
  /// The [enableDrag] parameter specifies whether the bottom sheet can be dragged up and down and dismissed by swiping
  /// the [padding] parameter specifies the padding of the content inside the bottom sheet.
  /// the [titlePadding] parameter specifies the padding of the title inside the bottom sheet.
  /// the [titleAlignment] parameter specifies the alignment of the title inside the bottom sheet.
  /// downwards.
  static Future<dynamic> showBottomSheet({
    required BuildContext context,
    required List<Widget> content,
    required bool hasCloseButton,
    required double height,
    String? title,
    TextStyle? titleTextStyle,
    VoidCallback? onTapCloseButton,
    SeniorBottomSheetStyle? style,
    bool isDismissible = false,
    bool enableDrag = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? titlePadding,
    TextAlign titleAlignment = TextAlign.left,
  }) {
    final theme = Provider.of<ThemeRepository>(context, listen: false).theme;
    final closeButton = hasCloseButton && onTapCloseButton != null
        ? _buildCloseButton(
            context: context,
            onTapCloseButton: onTapCloseButton,
            style: style,
          )
        : const SizedBox();
    final header = _buildBottomSheetHeader(
      context: context,
      title: title,
      titleTextStyle: titleTextStyle,
      style: style,
      padding: titlePadding,
      alignment: titleAlignment,
    );
    final bottomSheetcontent = Column(
      children: [
        ...header,
        Expanded(
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
            child: Column(
              children: content,
            ),
          ),
        )
      ],
    );

    return showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            SeniorRadius.huge,
          ),
          topRight: Radius.circular(
            SeniorRadius.huge,
          ),
        ),
      ),
      elevation: 0,
      backgroundColor:
          style?.backgroundColor ?? theme.bottomSheetTheme?.style?.backgroundColor ?? SeniorColors.pureWhite,
      context: context,
      constraints: BoxConstraints(maxHeight: height),
      builder: (BuildContext context) {
        return Column(
          children: [
            closeButton,
            Expanded(
              child: bottomSheetcontent,
            ),
          ],
        );
      },
    );
  }

  /// Adds a bottom sheet component to the application with dynamic height.
  /// The height of bottom sheet will be the same as content's height.
  /// The [context], [content], and [hasCloseButton] parameters are required.
  /// The [context] parameter expects to receive the current application context.
  /// The [content] parameter specifies the list of internal elements that will be presented in the bottom sheet.
  /// The [hasCloseButton] parameter specifies whether the bottom sheet will have a button to close it.
  /// The [title] parameter sets a title for the bottom sheet.
  /// The [titleTextStyle] parameter sets the bottom sheet title text style.
  /// The [onTapCloseButton] parameter specifies a function that will be executed whenever the close button is tapped.
  /// The [style] parameter contains the component's style settings.
  /// The [isDismissible] parameter specifies whether the bottom sheet will be dismissed when user taps on the scrim.
  /// The [enableDrag] parameter specifies whether the bottom sheet can be dragged up and down and dismissed by swiping
  ///   /// the [padding] parameter specifies the padding of the content inside the bottom sheet.
  /// the [titlePadding] parameter specifies the padding of the title inside the bottom sheet.
  /// the [titleAlignment] parameter specifies the alignment of the title inside the bottom sheet.
  /// downwards.
  static Future<dynamic> showDynamicBottomSheet({
    required BuildContext context,
    required List<Widget> content,
    required bool hasCloseButton,
    String? title,
    TextStyle? titleTextStyle,
    VoidCallback? onTapCloseButton,
    SeniorBottomSheetStyle? style,
    bool isDismissible = false,
    bool enableDrag = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? titlePadding,
    TextAlign titleAlignment = TextAlign.left,
  }) {
    final theme = Provider.of<ThemeRepository>(context, listen: false).theme;
    final closeButton = hasCloseButton && onTapCloseButton != null
        ? _buildCloseButton(
            context: context,
            onTapCloseButton: onTapCloseButton,
            style: style,
          )
        : const SizedBox();
    final header = _buildBottomSheetHeader(
      context: context,
      title: title,
      titleTextStyle: titleTextStyle,
      style: style,
      padding: titlePadding,
      alignment: titleAlignment,
    );
    final bottomSheetcontent = Column(
      children: [
        ...header,
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
          child: Column(
            children: content,
          ),
        )
      ],
    );

    return showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            SeniorRadius.huge,
          ),
          topRight: Radius.circular(
            SeniorRadius.huge,
          ),
        ),
      ),
      backgroundColor:
          style?.backgroundColor ?? theme.bottomSheetTheme?.style?.backgroundColor ?? SeniorColors.pureWhite,
      context: context,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            closeButton,
            Flexible(
              child: SingleChildScrollView(
                child: bottomSheetcontent,
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildCloseButton({
    required BuildContext context,
    required VoidCallback onTapCloseButton,
    SeniorBottomSheetStyle? style,
  }) {
    final theme = Provider.of<ThemeRepository>(context, listen: false).theme;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTapCloseButton,
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(SeniorSpacing.normal),
            child: Icon(
              FontAwesomeIcons.xmark,
              size: SeniorIconSize.medium,
              color: style?.closeButtonColor ??
                  theme.bottomSheetTheme?.style?.closeButtonColor ??
                  SeniorColors.primaryColor300,
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildBottomSheetHeader({
    required BuildContext context,
    String? title,
    TextStyle? titleTextStyle,
    SeniorBottomSheetStyle? style,
    EdgeInsetsGeometry? padding,
    TextAlign alignment = TextAlign.left,
  }) {
    final theme = Provider.of<ThemeRepository>(context, listen: false).theme;
    return [
      title != null
          ? Padding(
              padding: padding ??
                  const EdgeInsets.only(
                    left: SeniorSpacing.normal,
                    right: SeniorSpacing.normal,
                    bottom: SeniorSpacing.normal,
                  ),
              child: Text(
                textAlign: alignment,
                title,
                style: titleTextStyle ??
                    SeniorTypography.h4(
                      color: style?.titleColor ?? theme.bottomSheetTheme?.style?.titleColor ?? SeniorColors.grayscale90,
                    ).copyWith(fontWeight: FontWeight.w700),
              ),
            )
          : const SizedBox.shrink(),
    ];
  }
}
