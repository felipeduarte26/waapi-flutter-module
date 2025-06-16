import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/personalization_entity.dart';
import '../../../domain/usercases/get_personalization_usecase.dart';



part 'personalization_event.dart';
part 'personalization_state.dart';

class PersonalizationBloc extends Bloc<PersonalizationEvent, PersonalizationState> {
  final GetPersonalizationUsecase _getPersonalizationUsecase;

  PersonalizationBloc({
    required GetPersonalizationUsecase getPersonalizationUsecase,
  })  : _getPersonalizationUsecase = getPersonalizationUsecase,
        super(InitialPersonalizationState()) {
    on<GetPersonalizationEvent>(_getGetPersonalizationEvent);
    on<ReloadPersonalizationEvent>(_reloadPersonalizationEvent);
  }

  Future<void> _getGetPersonalizationEvent(
    GetPersonalizationEvent _,
    Emitter<PersonalizationState> emit,
  ) async {
    emit(LoadingPersonalizationState());
    add(ReloadPersonalizationEvent());
  }

  Future<void> _reloadPersonalizationEvent(
    ReloadPersonalizationEvent _,
    Emitter<PersonalizationState> emit,
  ) async {
    final personalization = await _getPersonalizationUsecase.call();

    personalization.fold(
      (left) {
        emit(
          ErrorPersonalizationState(
            message: left.message ?? '',
          ),
        );
      },
      (right) {
        emit(
          LoadedPersonalizationState(
            personalizationEntity: right,
          ),
        );
      },
    );
  }
}
