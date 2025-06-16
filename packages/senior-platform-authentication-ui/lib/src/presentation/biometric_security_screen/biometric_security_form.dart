import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../senior_platform_authentication_ui.dart';

import 'biometric_security_content.dart';
import 'cubit/biometric_security_cubit.dart';

class BiometricSecurityForm extends StatelessWidget {
  const BiometricSecurityForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BiometricSecurityCubit>(
      create: (context) => BiometricSecurityCubit(
        authenticationBloc: context.read<AuthenticationBloc>(),
      ),
      child: const BiometricSecurityContent(),
    );
  }
}
