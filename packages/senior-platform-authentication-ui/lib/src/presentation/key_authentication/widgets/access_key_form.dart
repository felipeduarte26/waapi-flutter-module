import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/validators.dart';

class AccessKeyForm extends StatefulWidget {
  final String? loginWithKeyHelperKey;
  final String? loginWithKeyWrongKey;
  final String? loginWithKeyAccessKey;
  final String? loginWithKeyUnauthorizedErrorHelper;

  const AccessKeyForm({
    this.loginWithKeyHelperKey,
    this.loginWithKeyWrongKey,
    this.loginWithKeyAccessKey,
    this.loginWithKeyUnauthorizedErrorHelper,
    super.key,
  });

  @override
  State<AccessKeyForm> createState() => _UserNameAuthenticationFormState();
}

class _UserNameAuthenticationFormState extends State<AccessKeyForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeyAuthenticationCubit, KeyAuthenticationState>(
      listener: (context, state) {
        if (state.errorType == ErrorType.unauthorized) {
          _formKey.currentState?.validate();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SeniorTextField(
            helper: widget.loginWithKeyHelperKey,
            disabled: !context.read<KeyAuthenticationCubit>().state.domainOK,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            prefixIcon: FontAwesomeIcons.key,
            label: widget.loginWithKeyAccessKey ??
                context.l10n.loginWithKeyAccessKey,
            validator: (value) {
              if (context.read<KeyAuthenticationCubit>().state.errorType ==
                  ErrorType.unauthorized) {
                return widget.loginWithKeyUnauthorizedErrorHelper ??
                    context.l10n.loginWithKeyUnauthorizedErrorHelper;
              }

              return validateAccessKey(
                  context, value, widget.loginWithKeyWrongKey);
            },
            onChanged: (String text) {
              context.read<KeyAuthenticationCubit>().onAccessKeyChanged(text);
              context.read<KeyAuthenticationCubit>().setAccessKeyOk =
                  _formKey.currentState!.validate();
            },
          ),
        );
      },
    );
  }
}
