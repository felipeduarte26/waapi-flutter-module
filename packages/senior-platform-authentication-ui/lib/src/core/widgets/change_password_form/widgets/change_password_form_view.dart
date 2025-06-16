import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../l10n/l10n_extension.dart';
import '../../../utils/constants.dart';
import '../cubit/change_password_form_cubit.dart';
import '../password_policy.dart';

class ChangePasswordFormView extends StatelessWidget {
  final PasswordPolicySettings passwordPolicySettings;
  final Future<bool> Function(String newPassword) submitCallback;

  const ChangePasswordFormView({
    super.key,
    required this.passwordPolicySettings,
    required this.submitCallback,
  });

  String _getPolicyDescription(BuildContext context, PasswordPolicy policy,
      PasswordPolicySettings passwordPolicySettings) {
    if (policy.passwordPolicyType == PasswordPolicyType.length) {
      return context.l10n.passwordPolicyMinimumLength(
        passwordPolicySettings.minimumPasswordLength,
        passwordPolicySettings.maximumPasswordLength,
      );
    }

    if (policy.passwordPolicyType == PasswordPolicyType.requireNumbers) {
      return context.l10n.passwordPolicyRequireNumbers;
    }

    if (policy.passwordPolicyType == PasswordPolicyType.requireLowercase) {
      return context.l10n.passwordPolicyRequireLowerCase;
    }

    if (policy.passwordPolicyType == PasswordPolicyType.requireUppercase) {
      return context.l10n.passwordPolicyRequireUpperCase;
    }

    if (policy.passwordPolicyType ==
        PasswordPolicyType.requireSpecialCharacters) {
      return context.l10n.passwordPolicyRequireSpecialCharacters;
    }

    if (policy.passwordPolicyType ==
        PasswordPolicyType.confirmPasswordMustMatchPassword) {
      return context.l10n.passwordPolicyPasswordConfirmPasswordMatches;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordFormCubit, ChangePasswordFormState>(
      listener: (context, state) {
        if (state.errorType != null &&
            state.networkStatus == NetworkStatus.idle) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SeniorSnackBar.error(
                message: context.l10n.genericErrorMessage,
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
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: SeniorSpacing.xmedium),
                  SeniorTextFieldPassword(
                    label: context.l10n.newPasswordHint,
                    prefixIcon: FontAwesomeIcons.lock,
                    textInputAction: TextInputAction.next,
                    onChanged: (String text) {
                      context
                          .read<ChangePasswordFormCubit>()
                          .onPasswordChanged(text);
                    },
                  ),
                  const SizedBox(height: SeniorSpacing.normal),
                  SeniorTextFieldPassword(
                    label: context.l10n.confirmNewPasswordHint,
                    prefixIcon: FontAwesomeIcons.lock,
                    textInputAction: TextInputAction.done,
                    onChanged: (String text) {
                      context
                          .read<ChangePasswordFormCubit>()
                          .onConfirmPasswordChanged(text);
                    },
                  ),
                  const SizedBox(height: SeniorSpacing.xmedium),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = state.passwordPolicies.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.small,
                      left: SeniorSpacing.normal,
                      right: SeniorSpacing.normal,
                    ),
                    child: Row(
                      children: [
                        FaIcon(
                          item.isValid
                              ? FontAwesomeIcons.check
                              : FontAwesomeIcons.minus,
                          size: item.isValid
                              ? SeniorSpacing.normal
                              : SeniorSpacing.normal,
                          color: item.isValid
                              ? SeniorColors.primaryColor500
                              : SeniorColors.neutralColor600,
                        ),
                        const SizedBox(width: SeniorSpacing.small),
                        Flexible(
                          child: SeniorText.body(
                            _getPolicyDescription(
                              context,
                              item,
                              passwordPolicySettings,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: state.passwordPolicies.length,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: SeniorButton.primary(
                    label: context.l10n.resetPasswordBtnText,
                    disabled:
                        state.passwordPolicies.any((p) => p.isValid == false) ||
                            state.networkStatus == NetworkStatus.loading,
                    busy: state.networkStatus == NetworkStatus.loading,
                    onPressed: () {
                      context
                          .read<ChangePasswordFormCubit>()
                          .submit(submitCallback);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
