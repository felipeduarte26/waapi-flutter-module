import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_driving_time_usecase.dart';
import 'domain/usecases/get_mandatory_break_usecase.dart';
import 'domain/usecases/get_total_hours_in_journey_usecase.dart';
import 'domain/usecases/get_total_time_paused_usecase.dart';
import 'domain/usecases/get_total_time_since_last_journey_usecase.dart';
import 'domain/usecases/get_waiting_time_usecase.dart';
import 'presenter/bloc/drivers_journey/drivers_journey_bloc.dart';

class DriversJourneyBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<DriversJourneyBloc>(
          (i) => DriversJourneyBloc(
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetDrivingTimeUsecase>(
          (i) => GetDrivingTimeUsecaseImpl(
            utils: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetMandatoryBreakUsecase>(
          (i) => GetMandatoryBreakUsecaseImpl(
            utils: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetDrivingTimeUsecase>(
          (i) => GetDrivingTimeUsecaseImpl(
            utils: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetTotalHoursInJourneyUsecase>(
          (i) => GetTotalHoursInJourneyUsecaseImpl(
            utils: i(),
            getMealTimeUsecase: i(),
            getMandatoryBreakUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetTotalTimePausedUsecase>(
          (i) => GetTotalTimePausedUsecaseImpl(
            utils: i(),
            getMandatoryBreakUsecase: i(),
            getMealTimeUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetTotalTimeSinceLastJourneyUseCase>(
          (i) => GetTotalTimeSinceLastJourneyUseCaseImpl(
            journeyRepository: i(),
            getClockDateTimeUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetWaitingTimeUsecase>(
          (i) => GetWaitingTimeUsecaseImpl(
            utils: i(),
          ),
          export: true,
        ),
      ];
}
