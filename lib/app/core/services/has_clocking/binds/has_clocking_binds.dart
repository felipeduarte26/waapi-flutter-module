import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_has_clocking_repository.dart';
import '../domain/repositories/save_has_clocking_repository.dart';
import '../domain/usecases/get_has_clocking_usecase.dart';
import '../domain/usecases/save_has_clocking_usecase.dart';
import '../external/drivers/get_has_clocking_driver_impl.dart';
import '../external/drivers/save_has_clocking_driver_impl.dart';
import '../infra/drivers/get_has_clocking_driver.dart';
import '../infra/drivers/save_has_clocking_driver.dart';
import '../infra/repositories/get_has_clocking_repository_impl.dart';
import '../infra/repositories/save_has_clocking_repository_impl.dart';
import '../presenter/bloc/has_clocking_bloc.dart';

class HasClockingBinds {
  static List<Bind<Object>> binds = [
    // Drivers
    Bind.lazySingleton<GetHasClockingUsecase>(
      (i) {
        return GetHasClockingUsecaseImpl(
          getHasClockingRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveHasClockingUsecase>(
      (i) {
        return SaveHasClockingUsecaseImpl(
          saveHasClockingRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetHasClockingDriver>(
      (i) {
        return GetHasClockingDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveHasClockingDriver>(
      (i) {
        return SaveHasClockingDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<GetHasClockingRepository>(
      (i) {
        return GetHasClockingRepositoryImpl(
          getHasClockingDriver: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveHasClockingRepository>(
      (i) {
        return SaveHasClockingRepositoryImpl(
          saveHasClockingDriver: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return HasClockingBloc(
          getHasClockingUsecase: i.get(),
          saveHasClockingUsecase: i.get(),
        );
      },
      export: true,
    ),
  ];
}
