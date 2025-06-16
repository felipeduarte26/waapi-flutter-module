import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../routes/collector_routes.dart';
import '../cubit/hours_tab_cubit.dart';

class HoursScreen extends StatefulWidget {
  final Widget? content;
  final bool hideBackButton;
  final bool showNotificationButton;
  final HoursTabCubit hoursTabCubit;

  const HoursScreen({
    this.content,
    this.hideBackButton = true,
    this.showNotificationButton = true,
    required this.hoursTabCubit,
    super.key,
  });

  @override
  State<HoursScreen> createState() => _HoursScreenState();
}

class _HoursScreenState extends State<HoursScreen> {
  final PageController pageController = PageController();
  bool skipUpdate = false;
  late String username;
  late String accessToken;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    
    return BlocConsumer<HoursTabCubit, int>(
      bloc: widget.hoursTabCubit,
      listener: (context, state) {
        pageController.animateToPage(
          widget.hoursTabCubit.selectedTab,
          duration: kTabScrollDuration,
          curve: Curves.easeIn,
        );
      },
      builder: (context, state) {
        return SeniorColorfulHeaderStructure(
          hideLeading: widget.hideBackButton,
          hasTopPadding: false,
          title: SeniorText.label(
            CollectorLocalizations.of(context).hoursTitle,
            color: SeniorColors.pureWhite,
            darkColor: SeniorColors.grayscale5,
          ),
          tabBarConfig: TabBarConfig(
            tabIndex: widget.hoursTabCubit.selectedTab,
            onSelect: (newPage) {
              skipUpdate = true;
              widget.hoursTabCubit.changToTab(newPage);
            },
            tabs: [
              CollectorLocalizations.of(context).hoursTabTitle1,
              CollectorLocalizations.of(context).hoursTabTitle2,
              CollectorLocalizations.of(context).hoursTabTitle3,
            ],
          ),
          actions: [
            Visibility(
              visible: widget.showNotificationButton,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/${PontoMobileCollectorRoutes.configurationHome}',
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.gear,
                  size: SeniorIconSize.small,
                  color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
                ),
              ),
            ),
            Visibility(
              visible: widget.showNotificationButton,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.solidBell,
                  size: SeniorIconSize.small,
                  color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
                ),
              ),
            ),
          ],
          body: widget.content ??
              PageView(
                controller: pageController,
                children: const [
                  Text(''),
                  Text(''),
                  Text(''),
                ],
                onPageChanged: (newPage) {
                  if (skipUpdate) {
                    skipUpdate = false;
                  } else {
                    widget.hoursTabCubit.changToTab(newPage);
                  }
                },
              ),
        );
      },
    );
  }
}
