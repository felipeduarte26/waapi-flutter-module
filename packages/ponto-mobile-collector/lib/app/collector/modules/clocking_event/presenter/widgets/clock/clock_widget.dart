import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import '../../../../../core/presenter/cubit/work_indicator/work_indicator_state.dart';
import '../../../domain/usecase/show_bottom_sheet_usecase.dart';
import '../../bloc/timer/timer_bloc.dart';
import '../../bloc/timer/timer_state.dart';
import 'day_writing_widget.dart';
import 'rotating_widget.dart';

class ClockWidget extends StatefulWidget {
  final TimerBloc timerBloc;
  final WorkIndicatorCubit? workIndicatorCubit;
  final IShowBottomSheetUsecase? showBottomSheetUsecase;

  const ClockWidget({
    super.key,
    required this.timerBloc,
    required this.activeTimer,
    this.workIndicatorCubit,
    this.showBottomSheetUsecase,
    this.showFaceRecognitionSync = true,
  });

  final bool showFaceRecognitionSync;
  final bool activeTimer;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late DateTime _day;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      bloc: widget.timerBloc,
      builder: (context, state) {
        _day = widget.timerBloc.lastDateTime;
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                showFaceRecognitionSync(),
                const Spacer(),
                SeniorText.h2(_getHourAndMinutes()),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 2,
                    bottom: 2,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: SeniorText.labelBold(_getSeconds()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SeniorText.labelBold(_getAmPm()),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SeniorSpacing.normal),
                  child: Icon(
                    FontAwesomeIcons.mapLocationDot,
                    color: Colors.transparent,
                    size: SeniorIconSize.medium,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DayWritingWidget(day: _day),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget showFaceRecognitionSync() {
    if (!widget.showFaceRecognitionSync) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: Icon(
          FontAwesomeIcons.anchor,
          color: Colors.transparent,
          size: SeniorIconSize.medium,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: BlocBuilder<WorkIndicatorCubit, WorkIndicatorState>(
          bloc: widget.workIndicatorCubit,
          builder: (context, state) {
            if (widget.workIndicatorCubit?.isWorkInProgress ?? false) {
              return InkWell(
                onTap: () => showFacialInformation(),
                child: const RotatingWidget(
                  repeat: true,
                  child: Icon(
                    FontAwesomeIcons.rotate,
                    color: SeniorColors.manchesterColorBlue500,
                    size: SeniorIconSize.medium,
                  ),
                ),
              );
            } else {
              return const Icon(
                FontAwesomeIcons.rotate,
                color: Colors.transparent,
                size: SeniorIconSize.medium,
              );
            }
          },
        ),
      );
    }
  }

  Future<dynamic> showFacialInformation() {
    return widget.showBottomSheetUsecase!.call(
      context: context,
      content: [
        Row(
          children: [
            SeniorText.h3(
              CollectorLocalizations.of(context).facialInitTechnologyTitle,
            ),
          ],
        ),
        const SizedBox(
          height: SeniorSpacing.normal,
        ),
        SeniorText.body(
          CollectorLocalizations.of(context).facialInitTechnologyContent,
        ),
        Padding(
          padding: const EdgeInsets.all(SeniorSpacing.normal),
          child: SeniorButton(
            label: CollectorLocalizations.of(context).close,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            fullWidth: true,
            outlined: true,
          ),
        ),
      ],
    );
  }

  String _getHourAndMinutes() {
    if (CollectorLocalizations.of(context).localeName == 'en') {
      return DateFormat('h:mm').format(_day);
    }

    return DateFormat('HH:mm').format(_day);
  }

  String _getAmPm() {
    if (CollectorLocalizations.of(context).localeName == 'en') {
      return DateFormat('a').format(_day);
    }

    return '';
  }

  String _getSeconds() {
    if (_day.second < 10) {
      return '0${DateFormat.s(CollectorLocalizations.of(context).localeName).format(_day)}';
    } else {
      return DateFormat.s(CollectorLocalizations.of(context).localeName)
          .format(_day);
    }
  }
}
