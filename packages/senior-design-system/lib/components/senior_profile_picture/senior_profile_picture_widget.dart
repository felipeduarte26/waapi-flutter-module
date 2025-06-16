import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import './senior_profile_picture_style.dart';
import '../../components/senior_loading/senior_loading.dart';
import '../../repositories/theme_repository.dart';

class SeniorProfilePicture extends StatelessWidget {
  /// Creates a profile picture component.
  ///
  /// Displays the user's profile picture or initials.
  /// There is a loading state that can be set by parameter [isLoading].
  /// The [radius] and [name] parameters are required.
  const SeniorProfilePicture({
    Key? key,
    required this.name,
    this.imageProvider,
    this.isLoading = false,
    required this.radius,
    this.style,
  }) : super(key: key);

  /// The size of the avatar, expressed as the radius (half the diameter).
  final double radius;

  /// The name of the individual represented in the profile picture.
  ///
  /// When there is no associated image, the initials of the first and last
  /// name will be displayed.
  final String name;

  /// Determines whether the profile picture component will be in the loading
  /// state.
  ///
  /// In the loading state it shows a Circular Progress Indicator.
  /// The defaults is false.
  final bool isLoading;

  /// Profile picture image.
  final ImageProvider? imageProvider;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorProfilePictureStyle.backgroundColor] the background color of the profile picture.
  /// [SeniorProfilePictureStyle.loadingOverlappingdColor] the overlay color when the component is loading.
  /// [SeniorProfilePictureStyle.textColor] the text color of the profile picture.
  final SeniorProfilePictureStyle? style;

  String _getInitials() {
    final List<String> names = name.split(' ');
    names.retainWhere((e) => e != '');
    String initials = '';
    for (var i = 0; i < names.length; i++) {
      if (initials.length != 2) {
        initials += '${names[i].substring(0, 1)}';
      }
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: style?.backgroundColor ??
              theme.profilePictureTheme?.style?.backgroundColor ??
              SeniorColors.grayscale30,
          radius: radius,
          backgroundImage: imageProvider,
          child: Offstage(
            offstage: imageProvider != null,
            child: Text(
              _getInitials().toUpperCase(),
              style: SeniorTypography.label(
                color: style?.textColor ??
                    theme.profilePictureTheme?.style?.textColor ??
                    SeniorColors.pureBlack,
              ),
            ),
          ),
        ),
        isLoading
            ? CircleAvatar(
                backgroundColor: style?.loadingOverlappingdColor ??
                    theme
                        .profilePictureTheme?.style?.loadingOverlappingdColor ??
                    SeniorColors.pureWhite.withOpacity(.5),
                radius: radius,
                child: const SeniorLoading(),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
