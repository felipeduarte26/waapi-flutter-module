import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_person_id_usecase.dart';
import 'person_event.dart';
import 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final GetPersonIdUsecase _getPersonIdUsecase;

  PersonBloc({
    required GetPersonIdUsecase getPersonIdUsecase,
  })  : _getPersonIdUsecase = getPersonIdUsecase,
        super(InitialPersonState()) {
    on<GetPersonIdEvent>(_getPersonIdEvent);
  }

  Future<void> _getPersonIdEvent(
    GetPersonIdEvent event,
    Emitter<PersonState> emit,
  ) async {
    emit(LoadingPersonState());

    final personId = await _getPersonIdUsecase.call(
      employeeId: event.employeeId,
    );

    personId.fold(
      (left) {
        emit(
          ErrorPersonState(),
        );
      },
      (right) {
        emit(
          LoadedPersonState(
            personId: right,
          ),
        );
      },
    );
  }
}
