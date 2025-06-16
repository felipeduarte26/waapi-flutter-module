import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_clocking_configuration_repository.dart';
import '../domain/repositories/save_clocking_configuration_repository.dart';
import '../domain/usecases/get_clocking_configuration_usecase.dart';
import '../domain/usecases/save_clocking_configuration_usecase.dart';
import '../external/drivers/get_clocking_configuration_driver_impl.dart';
import '../external/drivers/save_clocking_configuration_driver_impl.dart';
import '../infra/drivers/get_clocking_configuration_driver.dart';
import '../infra/drivers/save_clocking_configuration_driver.dart';
import '../infra/repositories/get_clocking_configuration_repository_impl.dart';
import '../infra/repositories/save_clocking_configuration_repository_impl.dart';

class ClockingConfigurationBinds {
  static List<Bind<Object>> binds = [
    // Drivers
    Bind.lazySingleton<GetClockingConfigurationUsecase>(
      (i) {
        return GetClockingConfigurationUsecaseImpl(
          getClockingConfigurationRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveClockingConfigurationUsecase>(
      (i) {
        return SaveClockingConfigurationUsecaseImpl(
          saveClockingConfigurationRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetClockingConfigurationDriver>(
      (i) {
        return GetClockingConfigurationDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveClockingConfigurationDriver>(
      (i) {
        return SaveClockingConfigurationDriverImpl(
          internalStorageService: i.get(),
        );
      },
      export: true,
    ),

    // Repositories
    Bind.lazySingleton<GetClockingConfigurationRepository>(
      (i) {
        return GetClockingConfigurationRepositoryImpl(
          getClockingConfigurationDriver: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.lazySingleton<SaveClockingConfigurationRepository>(
      (i) {
        return SaveClockingConfigurationRepositoryImpl(
          saveClockingConfigurationDriver: i.get(),
          
        );
      },
      export: true,
    ),
  ];
}
