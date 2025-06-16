import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './senior_state_page_widget.dart';
import './senior_state_page_style.dart';
import '../senior_button/senior_button.dart';

class SeniorStatePageImage extends SeniorStatePage {
  /// Create a Senior StartPage with an image as an illustration.
  /// The image must be in svg format.
  /// [actions] The list of action buttons on the state page.
  /// [imagePath] O caminho para a imagem.
  /// [imageSize] O tamanho da imagem na state page.
  /// [style] The style definitions for the component.
  /// [subTitle] The subtitle of the page.
  /// [title] The page title.
  /// The [imagePath], [subTitle] and [title] parameters are required.
  SeniorStatePageImage({
    Key? key,
    List<SeniorButton>? actions,
    required String imagePath,
    double imageSize = 160.0,
    SeniorStatePageStyle? style,
    required String subTitle,
    required String title,
  }) : super(
          key: key,
          actions: actions,
          illustration: SvgPicture.asset(
            imagePath,
            height: 160.0,
          ),
          style: style,
          subTitle: subTitle,
          title: title,
        );
}
