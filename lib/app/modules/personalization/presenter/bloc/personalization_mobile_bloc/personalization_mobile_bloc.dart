import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usercases/clean_personalization_mobile_driver_usecase.dart';
import '../../../domain/usercases/get_personalization_mobile_usecase.dart';
import 'personalization_mobile_event.dart';
import 'personalization_mobile_state.dart';

class PersonalizationMobileBloc extends Bloc<PersonalizationMobileEvent, PersonalizationMobileState> {
  final GetPersonalizationMobileUsecase _getPersonalizationMobileUsecase;
  final CleanPersonalizationMobileDriverUsecase _cleanPersonalizationMobileDriverUsecase;

  PersonalizationMobileBloc({
    required GetPersonalizationMobileUsecase getPersonalizationMobileUsecase,
    required CleanPersonalizationMobileDriverUsecase cleanPersonalizationMobileDriverUsecase,
  })  : _getPersonalizationMobileUsecase = getPersonalizationMobileUsecase,
        _cleanPersonalizationMobileDriverUsecase = cleanPersonalizationMobileDriverUsecase,
        super(InitialPersonalizationMobileState()) {
    on<GetPersonalizationMobileEvent>(_getGetPersonalizationMobileEvent);
    on<CleanPersonalizationMobileEvent>(_getCleanPersonalizationMobileEvent);
  }

  Future<void> _getCleanPersonalizationMobileEvent(
    CleanPersonalizationMobileEvent event,
    Emitter<PersonalizationMobileState> emit,
  ) async {
    emit(CleanPersonalizationMobileState());
    await _cleanPersonalizationMobileDriverUsecase.call();
    return emit(InitialPersonalizationMobileState());
  }

  Future<void> _getGetPersonalizationMobileEvent(
    GetPersonalizationMobileEvent event,
    Emitter<PersonalizationMobileState> emit,
  ) async {
    emit(LoadingPersonalizationMobileState());
    final personalizationMobile = await _getPersonalizationMobileUsecase.call();
    personalizationMobile.fold(
      (left) {
        emit(
          ErrorPersonalizationMobileState(
            message: left.message ?? '',
            personalizationMobileEntity: left.defaultPersonalizationMobileEntity,
          ),
        );
      },
      (right) {
        emit(
          LoadedPersonalizationMobileState(
            personalizationMobileEntity: right,
          ),
        );
      },
    );
  }
}
