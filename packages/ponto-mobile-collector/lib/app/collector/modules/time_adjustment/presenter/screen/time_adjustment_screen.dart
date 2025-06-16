import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../../clocking_event/domain/usecase/get_clock_time_usecase.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../../../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import '../bloc/period/period_bloc.dart';
import '../bloc/tab_action/tab_action_bloc.dart';
import '../bloc/tab_action/tab_action_event.dart';
import '../bloc/tab_action/tab_action_state.dart';
import '../bloc/timer_adjustment/timer_adjustment_bloc.dart';
import 'time_adjustment_clocking_events_screen.dart';
import 'time_adjustment_period_screen.dart';

class TimeAdjustmentScreen extends StatefulWidget {
  final Widget? content;
  final TabActionBloc _tabActionBloc;
  final NavigatorService _navigatorService;
  final PeriodBloc _periodBloc;
  final TimerAdjustmentBloc _timerAdjustmentBloc;
  final IGetClockDateTimeUsecase _getClockDateTimeUsecase;
  final SynchronizeClockingEventBloc _synchronizeClockingEventBloc;
  final IUtils _utils;
  final bool hideBackButton;
  final bool showNotificationButton;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;
  final Object? routeArguments;

  const TimeAdjustmentScreen(
    this._tabActionBloc,
    this._navigatorService,
    this._periodBloc,
    this._timerAdjustmentBloc,
    this._getClockDateTimeUsecase,
    this._synchronizeClockingEventBloc,
    this._utils,
    this._showBottomSheetUsecase, {
    this.content,
    this.hideBackButton = true,
    this.showNotificationButton = false,
    this.routeArguments,
    super.key,
  });

  @override
  State<TimeAdjustmentScreen> createState() => _TimeAdjustmentScreenState();
}

class _TimeAdjustmentScreenState extends State<TimeAdjustmentScreen>
    with SingleTickerProviderStateMixin {
  late final PageController pageController;
  bool skipUpdate = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();
    final isCustom = themeRepository.isCustomTheme();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          widget._navigatorService.pop();
        }
      },
      child: Scaffold(
        body: BlocConsumer<TabActionBloc, TabActionState>(
          bloc: widget._tabActionBloc,
          listener: (context, state) {
            pageController.animateToPage(
              state.tabIndex,
              duration: kTabScrollDuration,
              curve: Curves.easeIn,
            );
          },
          builder: (context, state) {
            bool isMulti = false;
            bool isManagerOrAdmin = false;
            String username = '';

            if (widget.routeArguments != null) {
              var routeArguments = widget.routeArguments as List<dynamic>;
              isMulti = routeArguments[0] as bool;
              isManagerOrAdmin = routeArguments[1] as bool;
              username = routeArguments[2];
            }

            return SeniorColorfulHeaderStructure(
              hideLeading: widget.hideBackButton,
              leading: IconButton(
                icon: Icon(
                  FontAwesomeIcons.angleLeft,
                  color: isCustom
                      ? SeniorServiceColor.getOptimalContrastColorTheme(
                          color: themeRepository.theme.secondaryColor ??
                              SeniorColors.primaryColor,
                        )
                      : isDark
                          ? SeniorColors.grayscale5
                          : SeniorColors.pureWhite,
                ),
                iconSize: SeniorSpacing.small,
                onPressed: () {
                  widget._navigatorService.pop();
                  // logoutUser();
                },
              ),
              actions: [
                Visibility(
                  visible: widget.showNotificationButton,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.solidBell,
                      size: SeniorIconSize.small,
                      color: isDark
                          ? SeniorColors.grayscale5
                          : SeniorColors.pureWhite,
                    ),
                  ),
                ),
              ],
              tabBarConfig: TabBarConfig(
                tabIndex: state.tabIndex,
                onSelect: (newPage) {
                  skipUpdate = true;
                  widget._tabActionBloc.add(
                    ChangeTabActionEvent(
                      tabIndexToChange: newPage,
                    ),
                  );
                },
                tabs: [
                  CollectorLocalizations.of(context).period,
                  CollectorLocalizations.of(context).clockingEvents,
                ],
              ),
              title: SeniorText.label(
                CollectorLocalizations.of(context).clockingEvents,
                color: isCustom
                    ? SeniorServiceColor.getOptimalContrastColorTheme(
                        color: themeRepository.theme.secondaryColor ??
                            SeniorColors.primaryColor,
                      )
                    : SeniorColors.pureWhite,
                darkColor: SeniorColors.grayscale5,
              ),
              body: widget.content ??
                  PageView(
                    controller: pageController,
                    children: [
                      TimeAdjustmentPeriodScreen(
                        widget._navigatorService,
                        widget._periodBloc,
                        widget._tabActionBloc,
                        widget._timerAdjustmentBloc,
                        widget._synchronizeClockingEventBloc,
                        widget._utils,
                        widget._showBottomSheetUsecase,
                        username,
                        isMulti: isMulti,
                        isManagerOrAdmin: isManagerOrAdmin,
                      ),
                      TimeAdjustmentClockingEventsScreen(
                        widget._timerAdjustmentBloc,
                        widget._getClockDateTimeUsecase,
                        widget._synchronizeClockingEventBloc,
                        widget._utils,
                        widget._showBottomSheetUsecase,
                        widget._navigatorService,
                        username,
                        isMulti: isMulti,
                        isManagerOrAdmin: isManagerOrAdmin,
                      ),
                    ],
                    onPageChanged: (newPage) {
                      if (skipUpdate) {
                        skipUpdate = false;
                      } else {
                        widget._tabActionBloc.add(
                          ChangeTabActionEvent(
                            tabIndexToChange: newPage,
                          ),
                        );
                      }
                    },
                  ),
            );
          },
        ),
      ),
    );
  }
}
