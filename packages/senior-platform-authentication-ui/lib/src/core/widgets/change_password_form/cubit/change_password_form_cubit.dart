
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../utils/constants.dart';
import '../password_policy.dart';

part 'change_password_form_state.dart';

class ChangePasswordFormCubit extends Cubit<ChangePasswordFormState> {
  ChangePasswordFormCubit() : super(ChangePasswordFormState.initial());

  void initializePolicies(
      {required PasswordPolicySettings passwordPolicySettings}) {
      final passwordPolicies = [
      const PasswordPolicy(
        passwordPolicyType: PasswordPolicyType.length,
      ),
      if (passwordPolicySettings.requireNumbers)
        const PasswordPolicy(
          passwordPolicyType: PasswordPolicyType.requireNumbers,
        ),
      if (passwordPolicySettings.requireLowercase)
        const PasswordPolicy(
          passwordPolicyType: PasswordPolicyType.requireLowercase,
        ),
      if (passwordPolicySettings.requireUppercase)
        const PasswordPolicy(
          passwordPolicyType: PasswordPolicyType.requireUppercase,
        ),
      if (passwordPolicySettings.requireSpecialCharacters)
        const PasswordPolicy(
          passwordPolicyType: PasswordPolicyType.requireSpecialCharacters,
        ),
      const PasswordPolicy(
        passwordPolicyType: PasswordPolicyType.confirmPasswordMustMatchPassword,
      ),
    ];

    emit(state.copyWith(
      passwordPolicies: passwordPolicies,
      passwordPolicyMaximumLength: passwordPolicySettings.maximumPasswordLength,
      passwordPolicyMinimumLength: passwordPolicySettings.minimumPasswordLength,
    ));
  }

  void onPasswordChanged(String password) {
    var newList = state.passwordPolicies.map((policy) {
      return policy.copyWith(
          isValid: _getRegex(policy.passwordPolicyType)?.hasMatch(password) ??
              policy.isValid);
    }).toList();

    emit(state.copyWith(
      passwordPolicies: newList,
      newPassword: password,
    ));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    var newList = List.of(state.passwordPolicies);

    final index = newList.indexWhere((element) =>
        element.passwordPolicyType ==
        PasswordPolicyType.confirmPasswordMustMatchPassword);

    newList[index] = state.passwordPolicies
        .elementAt(index)
        .copyWith(isValid: state.newPassword.compareTo(confirmPassword) == 0);

    emit(state.copyWith(
      passwordPolicies: newList,
      confirmNewPassword: confirmPassword,
    ));
  }

  FutureOr<void> submit(
      Future Function(String newPassword) submitCallback) async {
    emit(state.copyWith(
      networkStatus: NetworkStatus.loading,
    ));

    final success = await submitCallback(state.newPassword);

    if (!success) {
      emit(state.copyWith(
        networkStatus: NetworkStatus.idle,
        errorType: ErrorType.unknown,
      ));
    }

    emit(state.copyWith(
      errorType: null,
    ));
  }

  RegExp? _getRegex(PasswordPolicyType type) {
    switch (type) {
      case PasswordPolicyType.length:
        final minLength = state.passwordPolicyMinimumLength ?? 6;
        final maxLength = state.passwordPolicyMaximumLength ?? 30;

        return RegExp('^.{$minLength,$maxLength}\$');

      case PasswordPolicyType.requireLowercase:
        return RegExp(r'(?=.*[a-z])');

      case PasswordPolicyType.requireUppercase:
        return RegExp(r'(?=.*[A-Z])');

      case PasswordPolicyType.requireNumbers:
        return RegExp(r'(?=.*\d)');

      case PasswordPolicyType.requireSpecialCharacters:
        return RegExp(r'(?=[!@#$%&*.\-=+^~]).');

      default:
        return null;
    }
  }
}