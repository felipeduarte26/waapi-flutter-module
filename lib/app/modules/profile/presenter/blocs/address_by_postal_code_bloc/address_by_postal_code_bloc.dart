import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_address_by_postal_code_usecase.dart';
import 'address_by_postal_code_event.dart';
import 'address_by_postal_code_state.dart';

class AddressByPostalCodeBloc extends Bloc<AddressByPostalCodeEvent, AddressByPostalCodeState> {
  final GetAddressByPostalCodeUsecase _getAddressByPostalCodeUsecase;

  AddressByPostalCodeBloc({
    required GetAddressByPostalCodeUsecase getAddressByPostalCodeUsecase,
  })  : _getAddressByPostalCodeUsecase = getAddressByPostalCodeUsecase,
        super(const InitialAddressByPostalCodeState()) {
    on<GetAddressByPostalCodeEvent>(_getAddressByPostalCodeEvent);
  }

  Future<void> _getAddressByPostalCodeEvent(
    GetAddressByPostalCodeEvent event,
    Emitter<AddressByPostalCodeState> emit,
  ) async {
    emit(state.loadingAddressByPostalCodeState());

    final addressByPostalCode = await _getAddressByPostalCodeUsecase.call(
      postalCode: event.postalCode,
    );

    addressByPostalCode.fold(
      (left) {
        if (state.addressByPostalCodeEntity != null) {
          emit(state.errorUpdateAddressByPostalCodeState());
          emit(
            state.loadedAddressByPostalCodeState(
              addressByPostalCodeEntity: state.addressByPostalCodeEntity!,
            ),
          );
          return;
        }
        emit(state.errorAddressByPostalCodeState());
      },
      (right) {
        emit(
          state.loadedAddressByPostalCodeState(
            addressByPostalCodeEntity: right,
          ),
        );
      },
    );
  }
}
