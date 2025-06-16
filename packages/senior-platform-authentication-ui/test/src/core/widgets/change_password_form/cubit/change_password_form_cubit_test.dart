import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/cubit/change_password_form_cubit.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/password_policy.dart';

void main() {
  late ChangePasswordFormCubit changePasswordFormCubit;
  final tPasswordPolicySettings = PasswordPolicySettings(
    minimumPasswordLength: 6,
    maximumPasswordLength: 30,
    requireNumbers: true,
    requireLowercase: true,
    requireUppercase: true,
    requireSpecialCharacters: true,
  );
  final tPasswordPolicies = [
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.length,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireNumbers,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireLowercase,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireUppercase,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireSpecialCharacters,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.confirmPasswordMustMatchPassword,
    ),
  ];

  final tPasswordPoliciesValid = [
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.length,
      isValid: true,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireNumbers,
      isValid: true,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireLowercase,
      isValid: true,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireUppercase,
      isValid: true,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.requireSpecialCharacters,
      isValid: true,
    ),
    const PasswordPolicy(
      passwordPolicyType: PasswordPolicyType.confirmPasswordMustMatchPassword,
      isValid: true,
    ),
  ];

  const String tValidPassword = 'Password123!';

  const String tInvalidConfirmPassword = 'Password12!';

  setUp(() {
    changePasswordFormCubit = ChangePasswordFormCubit();
  });

  blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
    'emits correct states when initializePolicies is called succesfully',
    build: () => changePasswordFormCubit,
    act: (cubit) => cubit.initializePolicies(
        passwordPolicySettings: tPasswordPolicySettings),
    expect: () => <ChangePasswordFormState>[
      ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPolicies,
      )
    ],
  );

  group('onConfirmPasswordChanged with valid confirmPassword', () {
    var auxList = List.of(tPasswordPolicies);
    final index = auxList.indexWhere((element) =>
        element.passwordPolicyType ==
        PasswordPolicyType.confirmPasswordMustMatchPassword);
    auxList[index] = tPasswordPolicies.elementAt(index).copyWith(isValid: true);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPolicies,
        newPassword: tValidPassword,
      ),
      act: (cubit) => cubit.onConfirmPasswordChanged(tValidPassword),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tValidPassword,
          confirmNewPassword: tValidPassword,
        )
      ],
    );
  });

  group('onConfirmPasswordChanged with invalid confirmPassword', () {
    var auxList = List.of(tPasswordPolicies);
    final index = auxList.indexWhere((element) =>
        element.passwordPolicyType ==
        PasswordPolicyType.confirmPasswordMustMatchPassword);
    auxList[index] =
        tPasswordPolicies.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPolicies,
        newPassword: tValidPassword,
      ),
      act: (cubit) => cubit.onConfirmPasswordChanged(tInvalidConfirmPassword),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tValidPassword,
          confirmNewPassword: tInvalidConfirmPassword,
        )
      ],
    );
  });

  group(
      'onPasswordChanged with invalid password'
      'not matches minimum length policy', () {
    const String tInvalidMinimumLength = 'Sen3@';
    var auxList = List.of(tPasswordPoliciesValid);
    final index = auxList.indexWhere(
        (element) => element.passwordPolicyType == PasswordPolicyType.length);
    auxList[index] =
        tPasswordPoliciesValid.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
      ),
      act: (cubit) => cubit.onPasswordChanged(tInvalidMinimumLength),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tInvalidMinimumLength,
        )
      ],
    );
  });

  group(
      'onPasswordChanged with invalid password'
      'not matches maximum length policy', () {
    const String tInvalidMaximumLength =
        'Se!4567890123456789012345678900asassasa2s2000';
    var auxList = List.of(tPasswordPoliciesValid);
    final index = auxList.indexWhere(
        (element) => element.passwordPolicyType == PasswordPolicyType.length);
    auxList[index] =
        tPasswordPoliciesValid.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
      ),
      act: (cubit) => cubit.onPasswordChanged(tInvalidMaximumLength),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tInvalidMaximumLength,
        )
      ],
    );
  });

  group(
      'onPasswordChanged with invalid password'
      'not matches require number policy', () {
    const String tInvalidRequireNumber = 'Senha!Z';
    var auxList = List.of(tPasswordPoliciesValid);
    final index = auxList.indexWhere((element) =>
        element.passwordPolicyType == PasswordPolicyType.requireNumbers);
    auxList[index] =
        tPasswordPoliciesValid.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
      ),
      act: (cubit) => cubit.onPasswordChanged(tInvalidRequireNumber),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tInvalidRequireNumber,
        )
      ],
    );
  });

  group(
      'onPasswordChanged with invalid password'
      'not matches require lowercase policy', () {
    const String tInvalidRequireLowercase = 'SENHA1!';
    var auxList = List.of(tPasswordPoliciesValid);
    final index = auxList.indexWhere((element) =>
        element.passwordPolicyType == PasswordPolicyType.requireLowercase);
    auxList[index] =
        tPasswordPoliciesValid.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
      ),
      act: (cubit) => cubit.onPasswordChanged(tInvalidRequireLowercase),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tInvalidRequireLowercase,
        )
      ],
    );
  });

  group(
      'onPasswordChanged with invalid password'
      'not matches require uppercase policy', () {
    const String tInvalidRequireUppercase = 'senha1!';
    var auxList = List.of(tPasswordPoliciesValid);
    final index = auxList.indexWhere((element) =>
        element.passwordPolicyType == PasswordPolicyType.requireUppercase);
    auxList[index] =
        tPasswordPoliciesValid.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
      ),
      act: (cubit) => cubit.onPasswordChanged(tInvalidRequireUppercase),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tInvalidRequireUppercase,
        )
      ],
    );
  });

  group(
      'onPasswordChanged with invalid password'
      'not matches require special characters policy', () {
    const String tInvalidRequireSpecialCharacters = 'Senha12';
    var auxList = List.of(tPasswordPoliciesValid);
    final index = auxList.indexWhere((element) =>
        element.passwordPolicyType ==
        PasswordPolicyType.requireSpecialCharacters);
    auxList[index] =
        tPasswordPoliciesValid.elementAt(index).copyWith(isValid: false);
    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
      ),
      act: (cubit) => cubit.onPasswordChanged(tInvalidRequireSpecialCharacters),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: auxList,
          newPassword: tInvalidRequireSpecialCharacters,
        )
      ],
    );
  });

  group('submit executes successfully', () {
    Future<bool> mockedCallback(String _) async => true;

    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
        newPassword: tValidPassword,
        confirmNewPassword: tValidPassword,
      ),
      act: (cubit) => cubit.submit(mockedCallback),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: tPasswordPoliciesValid,
          newPassword: tValidPassword,
          confirmNewPassword: tValidPassword,
          networkStatus: NetworkStatus.loading,
        )
      ],
    );
  });

  group('submit fails', () {
    Future<bool> mockedCallback(String _) async => false;

    blocTest<ChangePasswordFormCubit, ChangePasswordFormState>(
      'emits correct states',
      build: () => changePasswordFormCubit,
      seed: () => ChangePasswordFormState.initial().copyWith(
        passwordPolicies: tPasswordPoliciesValid,
        newPassword: tValidPassword,
        confirmNewPassword: tValidPassword,
      ),
      act: (cubit) => cubit.submit(mockedCallback),
      expect: () => <ChangePasswordFormState>[
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: tPasswordPoliciesValid,
          newPassword: tValidPassword,
          confirmNewPassword: tValidPassword,
          networkStatus: NetworkStatus.loading,
        ),
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: tPasswordPoliciesValid,
          newPassword: tValidPassword,
          confirmNewPassword: tValidPassword,
          networkStatus: NetworkStatus.idle,
          errorType: ErrorType.unknown,
        ),
        ChangePasswordFormState.initial().copyWith(
          passwordPolicies: tPasswordPoliciesValid,
          newPassword: tValidPassword,
          confirmNewPassword: tValidPassword,
          networkStatus: NetworkStatus.idle,
          errorType: null,
        )
      ],
    );
  });
}
