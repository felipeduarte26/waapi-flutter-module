import 'package:equatable/equatable.dart';

enum PasswordPolicyType {
  length,
  requireNumbers,
  requireLowercase,
  requireUppercase,
  requireSpecialCharacters,
  confirmPasswordMustMatchPassword,
}

class PasswordPolicy extends Equatable {
  final PasswordPolicyType passwordPolicyType;
  final bool isValid;

  const PasswordPolicy({
    required this.passwordPolicyType,
    this.isValid = false,
  });

  PasswordPolicy copyWith({
    PasswordPolicyType? passwordPolicyType,
    bool? isValid,
  }) {
    return PasswordPolicy(
      passwordPolicyType: passwordPolicyType ?? this.passwordPolicyType,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        passwordPolicyType,
        isValid,
      ];
}
