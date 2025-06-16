import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/validators.dart';

class SecretForm extends StatefulWidget {
  final String? loginWithKeyHelperSecret;
  final String? loginWithKeyWrongSecret;
  final String? loginWithKeySecret;
  final String? loginWithKeyUnauthorizedErrorHelper;

  const SecretForm({
    this.loginWithKeyHelperSecret,
    this.loginWithKeyWrongSecret,
    this.loginWithKeySecret,
    this.loginWithKeyUnauthorizedErrorHelper,
    super.key,
  });

  @override
  State<SecretForm> createState() => _UserNameAuthenticationFormState();
}

class _UserNameAuthenticationFormState extends State<SecretForm> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeyAuthenticationCubit, KeyAuthenticationState>(
      listener: (context, state) {
        if (state.errorType == ErrorType.unauthorized) {
          _form.currentState?.validate();
        }
      },
      builder: (context, state) {
        return Form(
          key: _form,
          child: SeniorTextFieldPassword(
            helper: widget.loginWithKeyHelperSecret,
            disabled: !context.read<KeyAuthenticationCubit>().state.domainOK,
            label: widget.loginWithKeySecret ?? context.l10n.loginWithKeySecret,
            prefixIcon: FontAwesomeIcons.lock,
            validator: (value) {
              if (context.read<KeyAuthenticationCubit>().state.errorType ==
                  ErrorType.unauthorized) {
                return widget.loginWithKeyUnauthorizedErrorHelper ??
                    context.l10n.loginWithKeyUnauthorizedErrorHelper;
              }

              return validateSecret(
                  context, value, widget.loginWithKeyWrongSecret);
            },
            textInputAction: TextInputAction.done,
            onChanged: (String text) {
              context.read<KeyAuthenticationCubit>().onSecretChanged(text);
              context.read<KeyAuthenticationCubit>().setSecretOk =
                  _form.currentState!.validate();
            },
          ),
        );
      },
    );
  }
}
