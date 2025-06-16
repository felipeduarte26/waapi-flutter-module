import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

import '../../domain/entities/social_space_entity.dart';
import '../bloc/social_screen/social_screen_bloc.dart';
import 'modal/social_modal.dart';

class CreatePostActionButton extends StatelessWidget {
  final SocialScreenBloc socialScreenBloc;
  final ThemeRepository themeRepository;
  final SocialSpaceEntity? spaceSelected;

  const CreatePostActionButton({
    required this.socialScreenBloc,
    required this.themeRepository,
    this.spaceSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isCustomTheme = themeRepository.isCustomTheme();
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () async {
        await SocialModal.createPostModal(
          context: context,
          socialScreenBloc: socialScreenBloc,
          spaceSelected: spaceSelected,
        );
      },
      backgroundColor: isCustomTheme ? themeRepository.theme.primaryColor : SeniorColors.primaryColor500,
      child: SeniorIcon(
        icon: FontAwesomeIcons.solidPenToSquare,
        style: SeniorIconStyle(
          color: isCustomTheme
              ? SeniorServiceColor.getOptimalContrastColorTheme(color: themeRepository.theme.primaryColor!)
              : SeniorColors.pureWhite,
        ),
        size: 20,
      ),
    );
  }
}
