import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_user_authorizations_usecase.dart';
import 'authorization_event.dart';
import 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final GetUserAuthorizationsUsecase _getUserAuthorizationsUsecase;

  AuthorizationBloc({
    required GetUserAuthorizationsUsecase getUserAuthorizationsUsecase,
  })  : _getUserAuthorizationsUsecase = getUserAuthorizationsUsecase,
        super(InitialAuthorizationState()) {
    on<GetAuthorizationsEvent>(_getAuthorizationsEvent);
    on<ReloadAuthorizationsEvent>(_reloadAuthorizationsEvent);
  }

  Future<void> _getAuthorizationsEvent(
    GetAuthorizationsEvent _,
    Emitter<AuthorizationState> emit,
  ) async {
    emit(LoadingAuthorizationState());
    add(ReloadAuthorizationsEvent());
  }

  Future<void> _reloadAuthorizationsEvent(
    ReloadAuthorizationsEvent _,
    Emitter<AuthorizationState> emit,
  ) async {
    final userAuthorization = await _getUserAuthorizationsUsecase.call();

    userAuthorization.fold(
      (left) {
        emit(
          ErrorAuthorizationState(
            message: left.message ?? '',
          ),
        );
      },
      (right) {
        emit(
          LoadedAuthorizationState(
            authorizationEntity: right,
          ),
        );
      },
    );
  }
}
