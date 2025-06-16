import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../core/authentication/presentation/bloc/authentication_bloc.dart';
import '../../core/l10n/l10n_extension.dart';
import '../../core/utils/preferences/domain/usecases/get_saml_onboarding_enabled_usecase.dart';
import '../../core/utils/preferences/domain/usecases/store_saml_onboarding_enabled_usecase.dart';
import 'cubit/saml_authentication_cubit.dart';
import 'widgets/saml_authentication_content.dart';

class SAMLAuthenticationScreen extends StatelessWidget {
  final String username;
  final String tenantDomain;

  const SAMLAuthenticationScreen({
    super.key,
    required this.username,
    required this.tenantDomain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SAMLAuthenticationCubit>(
        create: (context) => SAMLAuthenticationCubit(
          authenticationBloc: context.read<AuthenticationBloc>(),
          storeSAMLOnboardingEnabledUsecase:
              StoreSAMLOnboardingEnabledUsecase(),
          getSAMLOnboardingEnabledUsecase: GetSAMLOnboardingEnabledUsecase(),
          getAuthenticationResponseByTokenJsonUsecase:
              GetAuthenticationResponseByTokenJsonUsecase(),
        )..checkOnboardingEnabled(),
        child: SeniorBackdrop(
          onTapBack: () {
            Navigator.pop(context);
          },
          title: Builder(
              builder: (context) => SeniorText.label(
                    color: SeniorColors.pureWhite,
                    context.l10n.samlScreenTitle,
                  )),
          body: SAMLAuthenticationContent(
            username: username,
            tenantDomain: tenantDomain,
          ),
        ),
      ),
    );
  }
}
