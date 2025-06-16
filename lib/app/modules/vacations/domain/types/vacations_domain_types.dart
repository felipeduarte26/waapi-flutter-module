import '../../../../core/types/either.dart';
import '../entities/vacation_calendar_staff_view_entity.dart';
import '../entities/vacations_analytics_entity.dart';
import '../entities/vacations_entity.dart';
import '../failures/vacations_failure.dart';

typedef GetVacationsUsecaseCallback = Future<Either<VacationsFailure, List<VacationsEntity>>>;
typedef GetVacationsAnalyticsUsecaseCallback = Future<Either<VacationsFailure, VacationsAnalyticsEntity>>;
typedef SendVacationRequestUsecaseCallback = Future<Either<VacationsFailure, Unit>>;
typedef SendVacationRequestUpdateUsecaseCallback = Future<Either<VacationsFailure, Unit>>;
typedef CancelVacationRequestUsecaseCallback = Future<Either<VacationsFailure, Unit>>;
typedef GetVacationCalendarStaffViewUsecaseCallback = Future<Either<VacationsFailure, VacationCalendarStaffViewEntity>>;
typedef GetVacationScheduleIndividualUseCaseCallback = Future<Either<VacationsFailure, bool>>;
typedef GetReportVacationUsecaseCallback = Future<Either<VacationsFailure, List<int>>>;
