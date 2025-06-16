import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../core/extension/translate_extension.dart';
import '../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../presenter/bloc/home_screen_bloc/home_screen_bloc.dart';
import '../presenter/bloc/home_screen_bloc/home_screen_state.dart';

abstract class HomeDialogHelper {
  static void openSignOutModelDialog({
    required BuildContext context,
    required VoidCallback onSignOut,
  }) {
    final homeScreenBloc = Modular.get<HomeScreenBloc>();

    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return BlocBuilder<HomeScreenBloc, HomeScreenState>(
          bloc: homeScreenBloc,
          builder: (context, state) {
            return SeniorModal(
              title: context.translate.titleSettingsDialogExit,
              content: context.translate.descriptionSettingsDialogExit,
              defaultAction: SeniorModalAction(
                label: context.translate.optionCancel,
                action: () => Modular.to.pop(),
                busy: state.signOutState.signOutStatus == SignOutStatusEnum.loading,
              ),
              otherAction: SeniorModalAction(
                busy: state.signOutState.signOutStatus == SignOutStatusEnum.loading,
                label: context.translate.optionExitDialogExit,
                action: onSignOut,
                danger: true,
              ),
            );
          },
        );
      },
    );
  }
}
