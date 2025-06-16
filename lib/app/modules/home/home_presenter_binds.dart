import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/has_clocking/presenter/bloc/has_clocking_bloc.dart';
import '../authentication/presenter/blocs/sign_out/sign_out_bloc.dart';
import 'presenter/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'presenter/bloc/home_screen_bloc/home_screen_bloc.dart';

class HomePresenterBinds {
  static List<Bind<Object>> binds = [
    //blocs
    Bind.singleton<HomeScreenBloc>(
      (i) {
        return HomeScreenBloc(
          authorizationBloc: i.get(),
          authenticationBloc: i.get(),
          activeContractBloc: i.get(),
          onboardingBloc: i.get(),
          signOutBloc: i.get(),
          hasClockingBloc: i.get(),
          personalizationBloc: i.get(),
          connectivityBloc: i.get(),
          happinessIndexBloc: i.get(),
          moodsBloc: i.get(),
        );
      },
    ),

    Bind.lazySingleton<ConnectivityBloc>((i) {
      return ConnectivityBloc();
    }),

    Bind.singleton<HasClockingBloc>(
      (i) {
        return HasClockingBloc(
          getHasClockingUsecase: i.get(),
          saveHasClockingUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<SignOutBloc>(
      (i) {
        return SignOutBloc(
          authenticationBloc: i.get(),
        );
      },
      export: true,
    ),
  ];
}
