import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/failures/happiness_index_failure.dart';
import '../../../domain/usecases/get_current_happiness_index_usecase.dart';
import '../../../domain/usecases/happiness_index_is_enabled_usecase.dart';
import '../../../domain/usecases/save_happiness_index_usecase.dart';
import 'happiness_index_event.dart';
import 'happiness_index_state.dart';

class HappinessIndexBloc extends Bloc<HappinessIndexEvent, HappinessIndexState> {
  final GetCurrentHappinessIndexUsecase _getCurrentHappinessIndexUsecase;
  final SaveHappinessIndexUsecase _saveHappinessIndexUsecase;
  final HappinessIndexIsEnabledUsecase _happinessIndexIsEnabledUsecase;

  HappinessIndexBloc({
    required GetCurrentHappinessIndexUsecase getCurrentHappinessIndexUsecase,
    required SaveHappinessIndexUsecase saveHappinessIndexUsecase,
    required HappinessIndexIsEnabledUsecase happinessIndexIsEnabledUsecase,
  })  : _getCurrentHappinessIndexUsecase = getCurrentHappinessIndexUsecase,
        _saveHappinessIndexUsecase = saveHappinessIndexUsecase,
        _happinessIndexIsEnabledUsecase = happinessIndexIsEnabledUsecase,
        super(HappinessIndexIsNotEnabledState()) {
    on<GetCurrentHappinessIndexEvent>(_getCurrentHappinessIndexEvent);
    on<SaveHappinessIndexEvent>(_saveHappinessIndexEvent);
    on<HappinessIndexIsEnabledEvent>(_happinessIndexIsEnabledEvent);
  }

  Future<void> _getCurrentHappinessIndexEvent(
    GetCurrentHappinessIndexEvent event,
    Emitter<HappinessIndexState> emit,
  ) async {
    emit(LoadingHappinessIndexState());

    final happinessIndexEntity = await _getCurrentHappinessIndexUsecase.call(
      language: event.language,
    );

    happinessIndexEntity.fold(
      (error) {
        if (error is NoHappinessIndexSelectedFailure) {
          emit(EmptyHappinessIndexState());
          return;
        }
        emit(
          ErrorOnGetHappinessIndexState(
            message: error.message,
          ),
        );
      },
      (happinessIndexMood) {
        emit(
          LoadedHappinessIndexState(
            happinessIndexMood: happinessIndexMood,
          ),
        );
      },
    );
  }

  Future<void> _saveHappinessIndexEvent(
    SaveHappinessIndexEvent event,
    Emitter<HappinessIndexState> emit,
  ) async {
    emit(LoadingHappinessIndexState());

    final moodWasSaved = await _saveHappinessIndexUsecase.call(
      mood: event.mood,
      language: event.language,
      notes: event.notes,
      reasons: event.reasons,
    );

    moodWasSaved.fold(
      (error) {
        emit(
          ErrorOnSaveHappinessIndexState(
            message: error.message,
          ),
        );
      },
      (_) {
        emit(SuccessOnSaveHappinessIndexState());
      },
    );
  }

  Future<void> _happinessIndexIsEnabledEvent(
    HappinessIndexIsEnabledEvent _,
    Emitter<HappinessIndexState> emit,
  ) async {
    final happinessIndexIsEnabledResult = await _happinessIndexIsEnabledUsecase.call();

    happinessIndexIsEnabledResult.fold(
      (_) {
        emit(HappinessIndexIsNotEnabledState());
      },
      (happinessIndexIsEnabled) {
        if (happinessIndexIsEnabled) {
          emit(HappinessIndexIsEnabledState());
          return;
        }
        emit(HappinessIndexIsNotEnabledState());
      },
    );
  }
}
