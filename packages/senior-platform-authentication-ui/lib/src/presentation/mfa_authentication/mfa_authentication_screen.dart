import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../core/authentication/presentation/bloc/authentication_bloc.dart';
import '../../core/l10n/l10n_extension.dart';
import '../helper_screen/helper_screen.dart';
import 'cubit/mfa_authentication_code_cubit.dart';
import 'widgets/mfa_authentication_content.dart';

class MFAAuthenticationScreen extends StatelessWidget {
  final MFAInfo mfaInfo;
  final String? helpImageUrl;
  final String? helpImageAsset;
  final String? username;

  const MFAAuthenticationScreen({
    super.key,
    required this.mfaInfo,
    this.helpImageUrl = '',
    this.helpImageAsset = '',
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MFAAuthenticationCubit>(
      create: (context) => MFAAuthenticationCubit(
        sendMfaConfigEmailUsecase: SendMFAConfigEmailUsecase(),
        loginMFAUsecase: LoginMFAUsecase(),
        authenticationBloc: context.read<AuthenticationBloc>(),
      )..initialize(mfaInfo, username!),
      child: SeniorBackdrop(
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.solidCircleQuestion,
              size: SeniorSpacing.normal,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HelperScreen(
                    isLoginHelp: true,
                    helpImageAsset: helpImageAsset,
                    helpImageUrl: helpImageUrl,
                  ),
                ),
              );
            },
          )
        ],
        onTapBack: () {
          Navigator.pop(context);
        },
        title: Builder(
          builder: (context) => SeniorText.label(
            context.l10n.authenticationCode,
            color: SeniorColors.pureWhite,
          ),
        ),
        body: const MFAAuthenticationContent(),
      ),
    );
  }
}
