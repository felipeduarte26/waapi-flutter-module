import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../domain/entities/happiness_index_mood_entity.dart';
import '../../../domain/usecases/get_mood_records_usecase.dart';
import 'retrieve_mood_records_event.dart';
import 'retrieve_mood_records_state.dart';

class RetrieveMoodRecordsBloc extends Bloc<RetrieveMoodRecordsEvent, RetrieveMoodRecordsState> {
  final GetMoodRecordsUsecase _getMoodRecordsUsecase;

  RetrieveMoodRecordsBloc({
    required GetMoodRecordsUsecase getMoodRecordsUsecase,
  })  : _getMoodRecordsUsecase = getMoodRecordsUsecase,
        super(const InitialRetrieveMoodRecordsState()) {
    on<GetRetrieveMoodRecordsEvent>(_getRetrieveMoodRecordsEvent);
  }

  Future<void> _getRetrieveMoodRecordsEvent(
    GetRetrieveMoodRecordsEvent event,
    Emitter<RetrieveMoodRecordsState> emit,
  ) async {
    emit(const LoadingRetrieveMoodRecordsState());

    final moodsEntities = await _getMoodRecordsUsecase.call(
      language: event.language,
      startDate: event.startDate,
      endDate: event.endDate,
    );

    moodsEntities.fold(
      (error) {
        emit(
          ErrorRetrieveMoodRecordsState(
            message: error.message,
          ),
        );
      },
      (right) {
        right.removeWhere(
          (mood) => validateMoodDate(
            mood: mood,
            eventEndDate: event.endDate,
            locale: event.language,
          ),
        );

        emit(
          LoadedRetrieveMoodRecordsState(
            moods: right,
          ),
        );
      },
    );
  }

  bool adjustTimeZone(DateTime date) {
    return !(date.hour == 0 && date.minute == 0 && date.second == 0 && date.millisecond == 0);
  }

  bool validateMoodDate({
    required HappinessIndexMoodEntity mood,
    required DateTime eventEndDate,
    required String locale,
  }) {
    return DateTimeHelper.convertStringDdMmAaaaToDateTime(
      locale: LocaleHelper.languageAndCountryCode(
        locale: Locale(locale),
      ),
      stringDdMmAaaa: DateTimeHelper.formatWithDefaultDateTimePattern(
        dateTime: mood.date,
        locale: LocaleHelper.languageAndCountryCode(
          locale: Locale(locale),
        ),
        adjustTimeZone: adjustTimeZone(mood.date),
      ),
    ).isAfter(eventEndDate);
  }
}
