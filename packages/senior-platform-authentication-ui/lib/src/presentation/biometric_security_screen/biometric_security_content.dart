import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../core/l10n/l10n_extension.dart';

import '../../../../senior_platform_authentication_ui.dart';
import 'cubit/biometric_security_cubit.dart';
import 'cubit/biometric_security_state.dart';

class BiometricSecurityContent extends StatefulWidget {
  const BiometricSecurityContent({
    super.key,
  });

  @override
  State<BiometricSecurityContent> createState() =>
      _BiometricSecurityContentState();
}

class _BiometricSecurityContentState extends State<BiometricSecurityContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BiometricSecurityCubit, BiometricSecurityState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(
            SeniorSpacing.normal,
          ),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: SvgPicture.asset(
                      logoSeniorSvg,
                      width: 160,
                      height: SeniorSpacing.huge,
                      package: 'senior_platform_authentication_ui',
                    ),
                  ),
                ),
              ),
              SeniorButton.primary(
                label: context.l10n.signWithBiometrics,
                onPressed: () {
                  context.read<BiometricSecurityCubit>().checkAuthentication();
                },
                fullWidth: true,
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorButton.ghost(
                label: context.l10n.optionExitDialogExit,
                onPressed: () async {
                  context.read<BiometricSecurityCubit>().unauthenticated(
                        biometryStatus: BiometryStatus.unknown,
                      );
                },
                fullWidth: true,
              ),
            ],
          ),
        );
      }),
    );
  }
}
