import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../cubit/failed_authentication_key_cubit/failed_authentication_key_cubit.dart';
import '../cubit/failed_authentication_key_cubit/failed_authentication_key_state.dart';

class FailedAuthenticationKeyScreen extends StatefulWidget {
  final FailedAuthenticationKeyCubit _failedAuthenticationKeyCubit;

  const FailedAuthenticationKeyScreen({
    required FailedAuthenticationKeyCubit failedAuthenticationKeyCubit,
    super.key,
  }) : _failedAuthenticationKeyCubit = failedAuthenticationKeyCubit;

  @override
  State<FailedAuthenticationKeyScreen> createState() =>
      _FailedAuthenticationKeyScreenState();
}

class _FailedAuthenticationKeyScreenState
    extends State<FailedAuthenticationKeyScreen> {
  @override
  Widget build(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SeniorColorfulHeaderStructure(
          hideLeading: true,
          hasTopPadding: false,
          title: SeniorText.label(''),
          body: BlocConsumer<FailedAuthenticationKeyCubit,
              FailedAuthenticationKeyBaseState>(
            bloc: widget._failedAuthenticationKeyCubit,
            listener: (context, state) {
              if (state is FailureFailedAuthenticationKeyState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.error(
                    message: collectorLocalizations
                        .errorAuthenticatingApplicationKey,
                  ),
                );
              }

              if (state is NoConnectionFailedAuthenticationKeyState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.warning(
                    message: collectorLocalizations.facialLooksLikeAreOffline,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthenticatingFailedAuthenticationKeyState) {
                return Center(
                  child: LoadingWidget(
                    bottomLabel: collectorLocalizations.authenticating,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(SeniorSpacing.normal),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.triangleExclamation,
                            color: SeniorColors.manchesterColorRed,
                            size: SeniorIconSize.huge,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.medium,
                              left: SeniorSpacing.xmedium,
                              right: SeniorSpacing.xmedium,
                            ),
                            child: SeniorText.h4(
                              collectorLocalizations.authenticationFailure,
                              textProperties: const TextProperties(
                                textAlign: TextAlign.center,
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.xsmall,
                              left: SeniorSpacing.xmedium,
                              right: SeniorSpacing.xmedium,
                            ),
                            child: SeniorText.label(
                              collectorLocalizations
                                  .errorWhileAuthenticatingApplicationKey,
                              textProperties: const TextProperties(
                                textAlign: TextAlign.center,
                              ),
                              style: const TextStyle(
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SeniorButton(
                      fullWidth: true,
                      label: collectorLocalizations.facialTryAgain,
                      onPressed: () {
                        widget._failedAuthenticationKeyCubit.authenticateKey();
                      },
                    ),
                    const SizedBox(height: SeniorSpacing.normal),
                    SeniorButton(
                      fullWidth: true,
                      label: collectorLocalizations.reRegisterApplicationKey,
                      onPressed: () {
                        widget._failedAuthenticationKeyCubit
                            .navigateToRegisterKey();
                      },
                    ),
                    const SizedBox(height: SeniorSpacing.normal),
                    SeniorButton(
                      fullWidth: true,
                      outlined: true,
                      label: collectorLocalizations.goToLogin,
                      onPressed: () {
                        widget._failedAuthenticationKeyCubit.closeApplication();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
