import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../reset_password/reset_password_screen.dart';

import '../../../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/utils/clipboard_helper.dart';
import '../cubit/mfa_authentication_code_cubit.dart';

class MFAAuthenticationCode extends StatefulWidget {
  final MFAInfo mfaInfo;
  final String? username;

  const MFAAuthenticationCode({
    super.key,
    required this.mfaInfo,
    this.username,
  });

  @override
  State<MFAAuthenticationCode> createState() => _MFAAuthenticationCodeState();
}

class _MFAAuthenticationCodeState extends State<MFAAuthenticationCode> with WidgetsBindingObserver {
  String clipboardText = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      ClipboardHelper.hasText().then((value) async {
        try {
          clipboardText = await ClipboardHelper.paste();
          double.parse(clipboardText);
          if (clipboardText.length == 6) {
            getClipBoard(clipboardText);
          }
        } catch (_) {
          return;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MFAAuthenticationCubit, MFAAuthenticationState>(
      listener: (context, state) {
        if (state.errorType != null && state.status == NetworkStatus.idle) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SeniorSnackBar.error(
                message: _getSnackbarErrorMessage(context, state.errorType!),
                action: SeniorSnackBarAction(
                  label: context.l10n.ok,
                  onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
              ),
            );
        }
        if (state.authenticationResponse?.resetPasswordInfo != null &&
            state.mfaStatus == MFAAuthenticationStatus.configured) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(
                resetPasswordInfo: ResetPasswordInfo(
                  temporaryToken: state.authenticationResponse!.resetPasswordInfo!.temporaryToken,
                  tenant: state.authenticationResponse!.resetPasswordInfo!.tenant,
                ),
                username: widget.username!,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: SeniorSpacing.normal,
            top: SeniorSpacing.xsmall,
            right: SeniorSpacing.normal,
            bottom: SeniorSpacing.normal,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.h3(
                    context.l10n.insertAuthenticationCodeMessage,
                    emphasis: true,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xsmall,
                  ),
                  SeniorText.label(
                    context.l10n.insertAuthenticationCodeMessageBody,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: SeniorPinCodeFields(
                    keyboardType: TextInputType.number,
                    length: 6,
                    onComplete: (code) {},
                    onChange: (value) {},
                    onCompleteValidator: (error) async {
                      final result = await context.read<MFAAuthenticationCubit>().login(
                            validationCode: controller.text,
                            tenant: widget.mfaInfo.tenant!,
                            temporaryToken: widget.mfaInfo.temporaryToken!,
                          );
                      if (!result) {
                        setState(() {
                          controller.text = '';
                        });
                      }
                      return result;
                    },
                    controller: controller,
                  ),
                ),
              ),
              Visibility(
                visible: state.status == NetworkStatus.loading,
                replacement: const SizedBox.shrink(),
                child: const SeniorLoading(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getSnackbarErrorMessage(BuildContext context, ErrorType errorType) {
    if (errorType == ErrorType.unauthorized) {
      return context.l10n.invalidCode;
    }

    return context.l10n.genericErrorMessage;
  }

  getClipBoard(String text) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (ctx) {
        return SeniorModal(
          title: context.l10n.pasteCode,
          content: context.l10n.youWantToPasteCode(text),
          defaultAction: SeniorModalAction(
            label: context.l10n.cancel,
            action: () => Navigator.pop(ctx),
          ),
          otherAction: SeniorModalAction(
            label: context.l10n.paste,
            action: () {
              controller.text = text;
              Navigator.pop(ctx);
            },
          ),
        );
      },
    );
  }
}
