import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import 'access_key_form.dart';
import 'domain_form.dart';
import 'secret_form.dart';

class KeyAuthenticationContent extends StatelessWidget {
  final String? initialDomain;
  final String? loginWithKeyTitle;
  final String? loginWithKeyHelperKey;
  final String? loginWithKeyHelperDomain;
  final String? loginWithKeyWrongDomain;
  final String? loginWithKeyHelperSecret;
  final String? loginWithKeyWrongKey;
  final String? loginWithKeyWrongSecret;
  final String? loginWithKeyAccessKey;
  final String? loginWithKeySecret;
  final String? loginWithKeyDomain;
  final String? loginWithKeyHelper;
  final String? loginWithKeyDomainNotFound;
  final String? loginWithKeyUnauthorizedErrorMessage;
  final String? loginWithKeyUnauthorizedErrorHelper;

  const KeyAuthenticationContent({
    this.initialDomain,
    this.loginWithKeyTitle,
    this.loginWithKeyHelperKey,
    this.loginWithKeyHelperDomain,
    this.loginWithKeyWrongDomain,
    this.loginWithKeyHelperSecret,
    this.loginWithKeyWrongKey,
    this.loginWithKeyWrongSecret,
    this.loginWithKeyAccessKey,
    this.loginWithKeySecret,
    this.loginWithKeyDomain,
    this.loginWithKeyHelper,
    this.loginWithKeyDomainNotFound,
    this.loginWithKeyUnauthorizedErrorMessage,
    this.loginWithKeyUnauthorizedErrorHelper,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        top: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
      ),
      child: BlocListener<KeyAuthenticationCubit, KeyAuthenticationState>(
        listener: (context, state) {
          if (state.errorType != null && state.status == NetworkStatus.idle) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SeniorSnackBar.error(
                  message: _getSnackbarErrorMessage(context, state.errorType!),
                  action: SeniorSnackBarAction(
                    label: context.l10n.ok,
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ),
              );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              //
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SeniorText.label(
                    loginWithKeyTitle ?? context.l10n.loginWithKeyTitle,
                  ),
                  const SizedBox(height: SeniorSpacing.xmedium),
                  DomainForm(
                    initialDomain: initialDomain,
                    loginWithKeyWrongDomain: loginWithKeyWrongDomain,
                    loginWithKeyDomain: loginWithKeyDomain,
                    loginWithKeyHelperDomain: loginWithKeyHelperDomain,
                  ),
                  const SizedBox(height: SeniorSpacing.normal),
                  AccessKeyForm(
                    loginWithKeyHelperKey: loginWithKeyHelperKey,
                    loginWithKeyWrongKey: loginWithKeyWrongKey,
                    loginWithKeyAccessKey: loginWithKeyAccessKey,
                    loginWithKeyUnauthorizedErrorHelper:
                        loginWithKeyUnauthorizedErrorHelper,
                  ),
                  const SizedBox(height: SeniorSpacing.normal),
                  SecretForm(
                    loginWithKeyHelperSecret: loginWithKeyHelperSecret,
                    loginWithKeyWrongSecret: loginWithKeyWrongSecret,
                    loginWithKeySecret: loginWithKeySecret,
                    loginWithKeyUnauthorizedErrorHelper:
                        loginWithKeyUnauthorizedErrorHelper,
                  ),
                  const Spacer(),
                  BlocBuilder<KeyAuthenticationCubit, KeyAuthenticationState>(
                    builder: (context, state) {
                      return SeniorButton.primary(
                        disabled: !context
                                .read<KeyAuthenticationCubit>()
                                .state
                                .domainOK ||
                            !context
                                .read<KeyAuthenticationCubit>()
                                .state
                                .accessKeyOK ||
                            !context
                                .read<KeyAuthenticationCubit>()
                                .state
                                .secretOK,
                        label: context.l10n.nextBtnText,
                        onPressed: () =>
                            context.read<KeyAuthenticationCubit>().login(),
                      );
                    },
                  ),
                  const SizedBox(height: SeniorSpacing.normal),
                  SeniorButton.ghost(
                    label: context.l10n.back,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  const SizedBox(height: SeniorSpacing.normal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSnackbarErrorMessage(BuildContext context, ErrorType errorType) {
    if (errorType == ErrorType.domainNotFound) {
      return loginWithKeyDomainNotFound ??
          context.l10n.loginWithKeyDomainNotFound;
    }

    if (errorType == ErrorType.unauthorized) {
      return loginWithKeyUnauthorizedErrorMessage ??
          context.l10n.loginWithKeyUnauthorizedErrorMessage;
    }

    return context.l10n.genericErrorMessage;
  }
}
