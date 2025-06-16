import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../core/domain/usecases/authenticate_registered_key_usecase.dart';
import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../routes/application_key_routes.dart';
import '../../../../routes/collector_routes.dart';
import 'failed_authentication_key_state.dart';

class FailedAuthenticationKeyCubit
    extends Cubit<FailedAuthenticationKeyBaseState> {
  final AuthenticateRegisteredKeyUsecase _authenticateRegisteredKeyUsecase;
  final NavigatorService _navigatorService;
  final HasConnectivityUsecase _hasConnectivityUsecase;

  FailedAuthenticationKeyCubit({
    required AuthenticateRegisteredKeyUsecase authenticateRegisteredKeyUsecase,
    required NavigatorService navigatorService,
    required HasConnectivityUsecase hasConnectivityUsecase,
  })  : _authenticateRegisteredKeyUsecase = authenticateRegisteredKeyUsecase,
        _navigatorService = navigatorService,
        _hasConnectivityUsecase = hasConnectivityUsecase,
        super(ReadyFailedAuthenticationKeyState());

  Future<void> authenticateKey() async {
    emit(AuthenticatingFailedAuthenticationKeyState());

    bool isOnline = await _hasConnectivityUsecase.call();

    if (isOnline) {
      bool successAuthentication =
          await _authenticateRegisteredKeyUsecase.call();
      if (successAuthentication) {
        _navigatorService.navigate(
          route: PontoMobileCollectorRoutes.appStartupHome,
        );
      } else {
        emit(FailureFailedAuthenticationKeyState());
        emit(ReadyFailedAuthenticationKeyState());
      }
    } else {
      emit(NoConnectionFailedAuthenticationKeyState());
      emit(ReadyFailedAuthenticationKeyState());
    }
  }

  Future<void> navigateToRegisterKey() async {
    bool isOnline = await _hasConnectivityUsecase.call();
    if (isOnline) {
      _navigatorService.pushNamed(
        route: ApplicationKeyRoutes.registerKeyFull,
      );
    } else {
      emit(NoConnectionFailedAuthenticationKeyState());
      emit(ReadyFailedAuthenticationKeyState());
    }
  }

  Future<void> closeApplication() async {
    await _navigatorService.closeApplication();
  }
}
