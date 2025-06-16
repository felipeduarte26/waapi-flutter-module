import 'package:flutter_bloc/flutter_bloc.dart';

import 'civil_certificate_event.dart';
import 'civil_certificate_state.dart';

class CivilCertificateBloc extends Bloc<CivilCertificateEvent, CivilCertificateState> {
  CivilCertificateBloc() : super(const InitialCivilCertificateState()) {
    on<ClearCivilCertificateProfileEvent>(_clearCivilCertificateProfileEvent);
    on<SelectCivilCertificateFromEntityToProfileEvent>(_selectCivilCertificateFromEntity);
    on<UnselectCivilCertificateFromEntityToProfileEvent>(_unselectCivilCertificateFromEntity);
  }

  Future<void> _clearCivilCertificateProfileEvent(
    ClearCivilCertificateProfileEvent _,
    Emitter<CivilCertificateState> emit,
  ) async {
    emit(state.initialCivilCertificateState());
  }

  Future<void> _selectCivilCertificateFromEntity(
    SelectCivilCertificateFromEntityToProfileEvent event,
    Emitter<CivilCertificateState> emit,
  ) async {
    emit(
      state.loadedSelectCivilCertificateState(
        selectedCivilCertificateEntity: event.civilCertificateEntity,
      ),
    );
  }

  Future<void> _unselectCivilCertificateFromEntity(
    UnselectCivilCertificateFromEntityToProfileEvent event,
    Emitter<CivilCertificateState> emit,
  ) async {
    emit(
      state.unselectCivilCertificateState(
        selectedselectedCivilCertificateEntity: event.civilCertificateEntity,
      ),
    );
  }
}
