import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';

class AccessAuthenticationScreen extends StatelessWidget {
  final String? loginImageAsset;
  final String? loginImageUrl;
  final UserNameAuthenticationCubit userNameAuthenticationCubit;
  final Widget userNameAuthenticationContent;
  final Widget helperScreen;

  const AccessAuthenticationScreen({
    super.key,
    this.loginImageAsset = '',
    this.loginImageUrl = '',
    required this.userNameAuthenticationContent,
    required this.userNameAuthenticationCubit,
    required this.helperScreen,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Scaffold(
      body: BlocProvider<UserNameAuthenticationCubit>(
        create: (context) => userNameAuthenticationCubit,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: context.read<AuthenticationBloc>(),
          builder: (context, state) {
            return Container(
              color: isDark
                  ? SeniorColors.neutralColor800
                  : SeniorColors.pureWhite,
              child: SeniorColorfulHeaderStructure(
                title: SeniorText.label(
                  CollectorLocalizations.of(context).userNameScreenTitle,
                  color: SeniorColors.pureWhite,
                  darkColor: SeniorColors.pureWhite,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.solidCircleQuestion,
                      size: SeniorSpacing.normal,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => helperScreen,
                        ),
                      );
                    },
                  ),
                ],
                body: userNameAuthenticationContent,
              ),
            );
          },
        ),
      ),
    );
  }
}
