import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/validators.dart';
import '../../password_recovery/password_recovery_modal.dart';

class UserNameAuthenticationForm extends StatefulWidget {
  final String? usernameHint;
  final bool showUserNameScreenSubTitle;
  final String? loginBtnText;

  const UserNameAuthenticationForm({
    this.usernameHint,
    this.loginBtnText,
    this.showUserNameScreenSubTitle = true,
    super.key,
  });

  @override
  State<UserNameAuthenticationForm> createState() =>
      _UserNameAuthenticationFormState();
}

class _UserNameAuthenticationFormState
    extends State<UserNameAuthenticationForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserNameAuthenticationCubit,
        UserNameAuthenticationState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.showUserNameScreenSubTitle) ...[
                SeniorText.h3(
                  context.l10n.userNameScreenSubTitle,
                  emphasis: true,
                ),
              ],
              const SizedBox(height: SeniorSpacing.xmedium),
              _UserNameTextField(
                usernameHint: widget.usernameHint,
              ),
              const SizedBox(height: SeniorSpacing.normal),
              (state.authenticationFlow == AuthenticationFlow.password ||
                      state.authenticationFlow == AuthenticationFlow.mfa ||
                      state.authenticationFlow == AuthenticationFlow.offline)
                  ? const _PasswordTextField()
                  : const SizedBox.shrink(),
              const Spacer(),
              Builder(
                builder: (context) {
                  final isLogin = (state.authenticationFlow ==
                          AuthenticationFlow.password ||
                      state.authenticationFlow == AuthenticationFlow.mfa);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SeniorButton.primary(
                        label: isLogin
                            ? widget.loginBtnText ?? context.l10n.loginBtnText
                            : context.l10n.nextBtnText,
                        busy: state.status == NetworkStatus.loading,
                        disabled: state.status == NetworkStatus.loading ||
                            (isLogin
                                ? (state.username.isEmpty ||
                                    state.password.isEmpty)
                                : state.username.isEmpty),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          if (isLogin ||
                              (state.authenticationFlow ==
                                      AuthenticationFlow.offline &&
                                  state.password.isNotEmpty)) {
                            context.read<UserNameAuthenticationCubit>().login();
                          } else {
                            context
                                .read<UserNameAuthenticationCubit>()
                                .getTenantLoginSettings();
                          }
                        },
                      ),
                      isLogin
                          ? const SizedBox(height: SeniorSpacing.normal)
                          : const SizedBox.shrink(),
                      isLogin
                          ? _PasswordRecoveryButton(
                              changePasswordSettings: state
                                  .tenantLoginSettings!.changePasswordSettings,
                              username: state.username,
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: SeniorSpacing.normal),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UserNameTextField extends StatelessWidget {
  final String? usernameHint;

  const _UserNameTextField({this.usernameHint});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'input_email',
      child: SeniorTextField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        maxLines: 1,
        autocorrect: false,
        prefixIcon: FontAwesomeIcons.solidUser,
        label: usernameHint ?? context.l10n.usernameHint,
        hintText: context.l10n.usernameTextfieldHintText,
        validator: (value) => validateUserName(context, value),
        onChanged: (String text) {
          context.read<UserNameAuthenticationCubit>().onUserNameChanged(text);
        },
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'input_password',
      child: SeniorTextFieldPassword(
        label: context.l10n.passwordHint,
        prefixIcon: FontAwesomeIcons.lock,
        onChanged: (String text) {
          context.read<UserNameAuthenticationCubit>().onPasswordChanged(text);
        },
        textInputAction: TextInputAction.done,
        validator: (value) => validatePassword(context, value),
      ),
    );
  }
}

class _PasswordRecoveryButton extends StatelessWidget {
  final ChangePasswordSettings changePasswordSettings;
  final String username;

  const _PasswordRecoveryButton({
    required this.changePasswordSettings,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return SeniorButton.ghost(
      label: context.l10n.recoveryPasswordBtnText,
      onPressed: () {
        SeniorBottomSheet.showDynamicBottomSheet(
          enableDrag: true,
          isDismissible: true,
          context: context,
          hasCloseButton: true,
          onTapCloseButton: () {
            Navigator.pop(context);
          },
          content: <Widget>[
            PasswordRecoveryModal(
              changePasswordSettings: changePasswordSettings,
              username: username,
            ),
          ],
        );
      },
    );
  }
}
