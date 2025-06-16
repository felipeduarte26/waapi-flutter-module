import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../notification/presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';
import '../../../notification/presenter/blocs/counter_notifications_bloc/counter_notifications_state.dart';
import '../../../routes/collector_routes.dart';
import '../bloc/clocking_event/clocking_event_bloc.dart';
import '../bloc/menu_action/menu_action_cubit.dart';
import '../bloc/timer/timer_bloc.dart';
import '../bloc/timer/timer_state.dart';
import '../widgets/day_mensage_widget.dart';

class ClockingEventScreen extends StatefulWidget {
  final Widget _clockingEventWidget;
  final bool _hideBackButton;
  final bool _showNotificationButton;
  final NavigatorService _navigatorService;
  final MenuActionCubit _menuActionCubit;
  final TimerBloc _timerBloc;
  final ClockingEventBloc _clockingEventBloc;
  final CounterNotificationsBloc _counterNotificationsBloc;

  const ClockingEventScreen({
    super.key,
    required Widget clockingEventWidget,
    required NavigatorService navigatorService,
    required MenuActionCubit menuActionCubit,
    required TimerBloc timerBloc,
    required ClockingEventBloc clockingEventBloc,
    bool hideBackButton = true,
    bool showNotificationButton = true,
    required CounterNotificationsBloc counterNotificationsBloc,
  })  : _clockingEventWidget = clockingEventWidget,
        _hideBackButton = hideBackButton,
        _showNotificationButton = showNotificationButton,
        _navigatorService = navigatorService,
        _menuActionCubit = menuActionCubit,
        _timerBloc = timerBloc,
        _clockingEventBloc = clockingEventBloc,
        _counterNotificationsBloc = counterNotificationsBloc;

  @override
  State<ClockingEventScreen> createState() => _ClockingEventScreenState();
}

class _ClockingEventScreenState extends State<ClockingEventScreen> {
  NotificationMessage? _notification;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        hideLeading: widget._hideBackButton,
        hasTopPadding: false,
        notification: _notification,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
          ),
          iconSize: SeniorSpacing.small,
          onPressed: () {
            widget._navigatorService.pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget._navigatorService.pushNamed(
                route: '/${PontoMobileCollectorRoutes.configurationHome}',
              );
            },
            icon: Icon(
              FontAwesomeIcons.gear,
              size: SeniorIconSize.small,
              color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
            ),
          ),
          Visibility(
            visible: widget._showNotificationButton,
            child: Stack(
              children: [
                IconButton(
                  onPressed: () async {
                    if (await widget._counterNotificationsBloc
                        .hasConnectivity()) {
                      widget._navigatorService.pushNamed(
                        route:
                            '/${PontoMobileCollectorRoutes.notificationHome}',
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SeniorSnackBar.error(
                          message: CollectorLocalizations.of(context)
                              .featureIsNotAvailableOffline,
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.solidBell,
                    size: SeniorIconSize.small,
                    color: isDark
                        ? SeniorColors.grayscale5
                        : SeniorColors.pureWhite,
                  ),
                  tooltip:
                      CollectorLocalizations.of(context).titleNotifications,
                ),
                BlocBuilder<CounterNotificationsBloc,
                    CounterNotificationsState>(
                  bloc: widget._counterNotificationsBloc,
                  builder: (context, state) {
                    if (state is SucceedCounterNotificationsState &&
                        state.hasUnreadPushMessage.hasUnreadPushMessage) {
                      return Positioned(
                        right: SeniorSpacing.xsmall,
                        top: SeniorSpacing.small,
                        child: IgnorePointer(
                          child: CircleAvatar(
                            backgroundColor:
                                SeniorColors.manchesterColorOrange500,
                            radius: SeniorSpacing.xsmall,
                            child: SeniorText.small(
                              state.hasUnreadPushMessage.number > 9
                                  ? '9+'
                                  : state.hasUnreadPushMessage.number
                                      .toString(),
                              color: SeniorColors.pureWhite,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
        title: SeniorText.label(
          CollectorLocalizations.of(context).clockingEventTitle,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(SeniorSpacing.normal),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BlocBuilder<TimerBloc, TimerState>(
                        bloc: widget._timerBloc,
                        buildWhen: (previous, current) {
                          if (current is TimerClockState &&
                              previous is TimerClockState &&
                              current.dateTime.hour != previous.dateTime.hour) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          return DayMessageWidget(
                            day: widget._timerBloc.lastDateTime,
                            fullName: widget._clockingEventBloc.hasEmployee()
                                ? widget._clockingEventBloc.getEmployeeName()
                                : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: SeniorSpacing.medium),
                    BlocBuilder<MenuActionCubit, MenuActionCubitState>(
                      bloc: widget._menuActionCubit,
                      builder: (context, state) {
                        return SeniorSquareButtonsMenu(
                          items: [
                                SeniorSquareButtonsMenuItemData(
                                  onTap: () {
                                    widget._navigatorService.pushNamed(
                                      route:
                                          '/${PontoMobileCollectorRoutes.timeAdjustmentHome}',
                                    );
                                  },
                                  icon: FontAwesomeIcons.solidCalendarDays,
                                  text: CollectorLocalizations.of(context)
                                      .clockingEvents,
                                  type: SeniorSquareButtonsMenuItemType.neutral,
                                ),
                              ] +
                              widget._menuActionCubit.squareButtonsMenuItemData,
                        );
                      },
                    ),
                    const SizedBox(height: SeniorSpacing.medium),
                  ],
                ),
              ),
              widget._clockingEventWidget,
            ],
          ),
        ),
      ),
    );
  }
}
