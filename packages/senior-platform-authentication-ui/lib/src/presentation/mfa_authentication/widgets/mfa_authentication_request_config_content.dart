import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../cubit/mfa_authentication_code_cubit.dart';

class MfaAuthenticationRequestConfigContent extends StatelessWidget {
  final bool redefine;

  const MfaAuthenticationRequestConfigContent({
    super.key,
    this.redefine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
          right: SeniorSpacing.normal,
          bottom: SeniorSpacing.normal),
      child: BlocConsumer<MFAAuthenticationCubit, MFAAuthenticationState>(
        listener: (context, state) {
          if (state.errorType != null && state.status == NetworkStatus.idle) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SeniorSnackBar.error(
                  message: state.errorType!.name,
                  action: SeniorSnackBarAction(
                    label: context.l10n.ok,
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.cta(context.l10n.multifactorAuthentication),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              (redefine)
                  ? SeniorText.label(
                      context.l10n.redefineAuthenticationMultifactor)
                  : SeniorText.label(
                      context.l10n.firstAuthenticationMultifactor),
              const Spacer(),
              SeniorButton.primary(
                  fullWidth: true,
                  label: context.l10n.requestConfig,
                  disabled: state.status == NetworkStatus.loading,
                  busy: state.status == NetworkStatus.loading,
                  onPressed: () {
                    context.read<MFAAuthenticationCubit>().sendMFAConfigEmail(
                          temporaryToken: state.mfaInfo.temporaryToken ?? '',
                          tenant: state.mfaInfo.tenant ?? '',
                        );
                  }),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorButton.ghost(
                fullWidth: true,
                label: context.l10n.back,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
