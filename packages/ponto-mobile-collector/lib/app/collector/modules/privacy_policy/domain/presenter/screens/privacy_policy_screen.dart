import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../cubit/privacy_policy_cubit.dart';
import '../cubit/privacy_policy_state.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final PrivacyPolicyCubit cubit;
  final NavigatorService navigatorService;

  const PrivacyPolicyScreen({
    required this.cubit,
    required this.navigatorService,
    super.key,
  });

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        title: SeniorText.label(
          CollectorLocalizations.of(context).privacyPolicy,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.pureWhite,
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: SeniorColors.pureWhite,
          ),
          onPressed: () {
            widget.navigatorService.pop();
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.normal,
                    right: SeniorSpacing.normal,
                  ),
                  child:
                      BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyBaseState>(
                    bloc: widget.cubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is HasNoConectionState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 200,
                              ),
                              const Icon(
                                FontAwesomeIcons.circleExclamation,
                                color: SeniorColors.manchesterColorRed,
                                size: SeniorIconSize.huge,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: SeniorSpacing.medium,
                                  left: SeniorSpacing.xmedium,
                                  right: SeniorSpacing.xmedium,
                                ),
                              ),
                              SeniorText.h4(
                                CollectorLocalizations.of(context)
                                    .facialLooksLikeAreOffline,
                                textProperties: const TextProperties(
                                  textAlign: TextAlign.center,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              SeniorButton(
                                fullWidth: true,
                                label: CollectorLocalizations.of(context)
                                    .facialTryAgain,
                                onPressed: () {
                                  widget.cubit.initialize();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is LoadingContentState) {
                        return LoadingWidget(
                          bottomLabel:
                              CollectorLocalizations.of(context).loading,
                        );
                      }
                      if (state is ReadContentState) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SeniorText.body(
                                  CollectorLocalizations.of(context)
                                      .privacyPolicies,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SeniorSpacing.normal,
                            ),
                            InkWell(
                              onTap: () async {
                                await widget.cubit.goToPrivacyPolicyPage(
                                  lastVersionSaved: state.privacyPolicyEntity,
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: SeniorSpacing.normal,
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.solidFileLines,
                                    size: SeniorSpacing.normal,
                                    color: SeniorColors.primaryColor500,
                                  ),
                                  const SizedBox(width: SeniorSpacing.small),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: SeniorSpacing.normal,
                                        ),
                                        SeniorText.body(
                                          CollectorLocalizations.of(context)
                                              .privacyPolicy,
                                          color: SeniorColors.neutralColor800,
                                          darkColor: SeniorColors.pureWhite,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: SeniorSpacing.xsmall),
                                  Icon(
                                    FontAwesomeIcons.angleRight,
                                    size: SeniorSpacing.normal,
                                    color: isDark
                                        ? SeniorColors.pureWhite
                                        : SeniorColors.neutralColor800,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: SeniorSpacing.big,
                            ),
                            Row(
                              children: [
                                SeniorText.body(
                                  CollectorLocalizations.of(context).info,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SeniorSpacing.xxsmall,
                            ),
                            Row(
                              children: [
                                SeniorText.body(
                                  CollectorLocalizations.of(context).viewDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SeniorText.body(
                                  state.dateTimeEventRead,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
