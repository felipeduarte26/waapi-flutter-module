import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './senior_state_page_widget.dart';
import './senior_state_page_style.dart';
import '../senior_gradient_icon/senior_gradient_icon.dart';
import '../senior_button/senior_button.dart';

class SeniorStatePageIcon extends SeniorStatePage {
  /// Creates a SeniorStatePage component with an icon as an illustration.
  /// The icon can be solid color or with Senior's default gradient.
  /// [actions] The list of action buttons on the state page.
  /// [gradient] Defines whether the icon will have a gradient. Default value is false.
  /// [icon] The state page icon.
  /// [style] The style definitions for the component.
  /// [subTitle] The subtitle of the page.
  /// [title] The page title.
  /// The [icon], [subTitle] and [title] parameters are required.
  /// When configuring the icon to be a gradient, a color must not be informed for the icon. If the icon has a
  /// solid color, it is necessary to inform the icon color.
  SeniorStatePageIcon({
    Key? key,
    List<SeniorButton>? actions,
    Color? iconColor,
    bool gradient = false,
    required IconData icon,
    SeniorStatePageStyle? style,
    required String subTitle,
    required String title,
  })  : assert(gradient && iconColor == null || !gradient && iconColor != null),
        super(
          key: key,
          actions: actions,
          illustration: gradient
              ? SeniorGradientIcon(
                  icon: icon,
                  sizeIcon: 80.0,
                )
              : FaIcon(
                  icon,
                  color: iconColor,
                  size: 80.0,
                ),
          style: style,
          subTitle: subTitle,
          title: title,
        );
}
