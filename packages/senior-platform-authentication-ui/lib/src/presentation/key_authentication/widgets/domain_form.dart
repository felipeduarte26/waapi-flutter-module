import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/validators.dart';

class DomainForm extends StatefulWidget {
  final String? initialDomain;
  final String? loginWithKeyWrongDomain;
  final String? loginWithKeyDomain;
  final String? loginWithKeyHelperDomain;

  const DomainForm({
    this.initialDomain,
    this.loginWithKeyWrongDomain,
    this.loginWithKeyDomain,
    this.loginWithKeyHelperDomain,
    super.key,
  });

  @override
  State<DomainForm> createState() => _UserNameAuthenticationFormState();
}

class _UserNameAuthenticationFormState extends State<DomainForm> {
  final _formDomain = GlobalKey<FormState>();
  bool domainOk = false;
  bool setDomain = true;

  @override
  void initState() {
    super.initState();
    // Setting a initial domain value on state.
    if (widget.initialDomain != null) {
      context.read<KeyAuthenticationCubit>().onDomainChanged(widget.initialDomain!);
      submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyAuthenticationCubit, KeyAuthenticationState>(
      builder: (context, state) {
        return Form(
          key: _formDomain,
          child: SeniorTextField(
            helper: widget.loginWithKeyHelperDomain,
            initialValue: context.read<KeyAuthenticationCubit>().state.tenantName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            prefixIcon: FontAwesomeIcons.solidUser,
            label: widget.loginWithKeyDomain ?? context.l10n.loginWithKeyDomain,
            validator: (value) {
              String? mensage = validateDomain(
                  context, value, widget.loginWithKeyWrongDomain);

              if (mensage == null &&
                  !context.read<KeyAuthenticationCubit>().state.domainOK) {
                return context.l10n.loginWithKeyDomainNotFound;
              }

              return mensage;
            },
            onChanged: (String text) {
              context.read<KeyAuthenticationCubit>().onDomainChanged(text);
            },
            onFieldSubmitted: (p0) => submit(),
          ),
        );
      },
    );
  }

  void submit() async {
    await context.read<KeyAuthenticationCubit>().getTenantLoginSettings();
    _formDomain.currentState?.validate();
  }
}
