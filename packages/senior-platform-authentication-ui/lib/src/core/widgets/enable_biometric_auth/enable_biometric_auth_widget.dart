import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../l10n/l10n_extension.dart';
import 'cubit/enable_biometric_auth_cubit.dart';

class EnableBiometricAuthWidget extends StatefulWidget {
  final AuthenticationResponse authenticationResponse;

  const EnableBiometricAuthWidget({
    super.key,
    required this.authenticationResponse,
  });
  @override
  State<EnableBiometricAuthWidget> createState() =>
      _EnableBiometricAuthWidgetState();
}

class _EnableBiometricAuthWidgetState extends State<EnableBiometricAuthWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EnableBiometricAuthCubit, EnableBiometricAuthState>(
      listener: (context, state) {
        if (state.biometryStatus == BiometryStatus.success) {
          context.read<EnableBiometricAuthCubit>().authentication(
                biometryStatus: state.biometryStatus,
                authenticationResponse: widget.authenticationResponse,
              );
        }

        if (state.biometryStatus == BiometryStatus.canceled) {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const UserNameAuthenticationScreen(),
            ),
            // Condição para não remover nenhuma rota
          );
        }
      },
      child: BlocBuilder<EnableBiometricAuthCubit, EnableBiometricAuthState>(
        builder: (context, state) {
          if (state.biometryStatus == BiometryStatus.authenticating ||
              state.biometryStatus == BiometryStatus.success ||
              state.biometryStatus == BiometryStatus.canceled) {
            return const Center(
              child: SeniorLoading(),
            );
          }

          if (state.enableBiometricAuthStatus ==
              BiometricAuthInfo.biometricsNotRegistered) {
            return SeniorModal(
              title: context.l10n.unregisteredSecurityMethods,
              content: context.l10n.unregisteredSecurityMethodsContent,
              defaultAction: SeniorModalAction(
                label: context.l10n.continueBtnText,
                action: () {
                  context.read<EnableBiometricAuthCubit>().authentication(
                        biometryStatus: BiometryStatus.unknown,
                        authenticationResponse: widget.authenticationResponse,
                      );
                },
              ),
            );
          }
          if (state.enableBiometricAuthStatus ==
              BiometricAuthInfo.getAvailableBiometrics) {
            return SeniorModal(
              title: context.l10n.enableAccessWithBiometricsTitle,
              content: context.l10n.enableAccessWithBiometricsContent,
              defaultAction: SeniorModalAction(
                label: context.l10n.no,
                action: () async {
                  context.read<EnableBiometricAuthCubit>().authentication(
                        biometryStatus: BiometryStatus.unknown,
                        authenticationResponse: widget.authenticationResponse,
                      );
                },
              ),
              otherAction: SeniorModalAction(
                label: context.l10n.yes,
                action: () async {
                  await context.read<EnableBiometricAuthCubit>().biometricAuth(
                        authenticationResponse: widget.authenticationResponse,
                      );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
