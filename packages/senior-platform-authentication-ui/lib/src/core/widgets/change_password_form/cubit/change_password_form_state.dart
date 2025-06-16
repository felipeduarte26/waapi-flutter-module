part of 'change_password_form_cubit.dart';

class ChangePasswordFormState extends Equatable {
  final NetworkStatus networkStatus;
  final String newPassword;
  final String confirmNewPassword;
  final List<PasswordPolicy> passwordPolicies;
  final int? passwordPolicyMinimumLength;
  final int? passwordPolicyMaximumLength;
  final ErrorType? errorType;

  const ChangePasswordFormState({
    required this.networkStatus,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.passwordPolicies,
    this.passwordPolicyMinimumLength,
    this.passwordPolicyMaximumLength,
    this.errorType,
  });

  factory ChangePasswordFormState.initial() {
    return const ChangePasswordFormState(
      networkStatus: NetworkStatus.idle,
      newPassword: '',
      confirmNewPassword: '',
      passwordPolicies: [],
    );
  }

  ChangePasswordFormState copyWith({
    NetworkStatus? networkStatus,
    String? newPassword,
    String? confirmNewPassword,
    ErrorType? errorType,
    int? passwordPolicyMinimumLength,
    int? passwordPolicyMaximumLength,
    List<PasswordPolicy>? passwordPolicies,
    
  }) {
    return ChangePasswordFormState(
      networkStatus: networkStatus ?? this.networkStatus,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      passwordPolicies: passwordPolicies ?? this.passwordPolicies,
      passwordPolicyMinimumLength: passwordPolicyMinimumLength ??
          this.passwordPolicyMinimumLength,
      passwordPolicyMaximumLength: passwordPolicyMaximumLength ??
          this.passwordPolicyMaximumLength,
      errorType: errorType,
    );
  }

  @override
  List<Object?> get props => [
        networkStatus,
        newPassword,
        confirmNewPassword,
        passwordPolicies,
        passwordPolicyMinimumLength,
        passwordPolicyMaximumLength,
        errorType,
      ];
}

