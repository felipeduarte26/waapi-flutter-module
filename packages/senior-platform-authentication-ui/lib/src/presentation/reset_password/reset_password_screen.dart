import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

import '../../../senior_platform_authentication_ui.dart';
import '../../core/l10n/l10n_extension.dart';
import 'cubit/reset_password_cubit.dart';
import 'widgets/reset_password_content.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPasswordInfo resetPasswordInfo;
  final String username;

  const ResetPasswordScreen({
    super.key,
    required this.resetPasswordInfo,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => ResetPasswordCubit(
        loginWithResetPasswordUsecase: LoginWithResetPasswordUsecase(),
        authenticationBloc: context.read<AuthenticationBloc>(),
      )..initialize(resetPasswordInfo, username),
      child: SeniorBackdrop(
        onTapBack: () {
          Navigator.pop(context);
        },
        title: Builder(
          builder: (context) => SeniorText.label(
            context.l10n.resetPasswordScreenTitle,
            color: SeniorColors.pureWhite,
          ),
        ),
        body: const ResetPasswordContent(),
      ),
    );
  }
}
