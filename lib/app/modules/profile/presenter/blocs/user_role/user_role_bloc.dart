import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_user_role_id_usecase.dart';
import 'user_role_event.dart';
import 'user_role_state.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  final GetUserRoleIdUsecase _getUserRoleIdUsecase;

  UserRoleBloc({
    required GetUserRoleIdUsecase getUserRoleIdUsecase,
  })  : _getUserRoleIdUsecase = getUserRoleIdUsecase,
        super(InitialUserRoleState()) {
    on<GetUserRoleIdEvent>(_getUserRoleIdEvent);
  }

  Future<void> _getUserRoleIdEvent(
    GetUserRoleIdEvent _,
    Emitter<UserRoleState> emit,
  ) async {
    emit(LoadingUserRoleState());

    final userRoleId = await _getUserRoleIdUsecase.call();

    userRoleId.fold(
      (left) {
        emit(
          ErrorUserRoleState(),
        );
      },
      (right) {
        emit(
          LoadedUserRoleState(
            userRoleId: right,
          ),
        );
      },
    );
  }
}
