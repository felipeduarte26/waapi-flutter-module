import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';
import 'cubit/enable_biometric_auth_cubit.dart';
import 'enable_biometric_auth_widget.dart';

class EnableBiometricAuthForm extends StatelessWidget {
  final AuthenticationResponse authenticationResponse;

  const EnableBiometricAuthForm(
      {super.key, required this.authenticationResponse});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnableBiometricAuthCubit>(
      create: (context) => EnableBiometricAuthCubit(
        authenticationBloc: context.read<AuthenticationBloc>(),
        biometricAuthAvailableUseCase: BiometricAvailableUsecase(),
        biometricAuthCanCheckUseCase: BiometricCanCheckUseCase(),
        biometricAuthenticateUseCase: BiometricAuthenticateUsecase(),
      )..initialize(),
      child: Scaffold(
        body: EnableBiometricAuthWidget(
          authenticationResponse: authenticationResponse,
        ),
      ),
    );
  }
}
