import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import '../../../modules/clocking_event/domain/usecase/synchronize_clocking_event_usecase.dart';
import '../../infra/utils/enum/environment_enum.dart';
import '../../infra/utils/enum/synchronization_enum.dart';
import '../enums/sync_individual_status_type.dart';
import '../enums/token_type.dart';
import '../enums/work_indicator_type.dart';
import '../input_model/synchronization_result.dart';
import '../services/firebase/log_service.dart';
import '../services/work_indicator_service.dart';
import 'check_conection_usecase.dart';
import 'get_environment_usecase.dart';
import 'get_token_usecase.dart';
import 'mobile_login_usecase.dart';
import 'sync_face_employee_usecase.dart';

/// Synchronizes all information necessary for Individual/Driver mode to the device
abstract class SyncAllIndividualInfoUsecase {
  Future<SyncIndividualStatusType> call();
}

class SyncAllIndividualInfoUsecaseImpl implements SyncAllIndividualInfoUsecase {
  final GetTokenUsecase _getTokenUsecase;
  final IHasConnectivityUsecase _hasConnectivityUsecase;
  final WorkIndicatorService _workIndicatorService;
  final GetEnvironmentUsecase _getEnvironmentUsecase;
  final MobileLoginUsecase _mobileLoginUsecase;
  final IInitClockUsecase _initClockUsecase;
  final SyncFaceEmployeeUsecase _syncFaceEmployeeUsecase;
  final ISynchronizeClockingEventUsecase _synchronizeClockingEventUsecase;
  final LogService _logService;

  Future<SyncIndividualStatusType>? futureCall;

  SyncAllIndividualInfoUsecaseImpl({
    required GetTokenUsecase getTokenUsecase,
    required IHasConnectivityUsecase hasConnectivityUsecase,
    required WorkIndicatorService workIndicatorService,
    required GetEnvironmentUsecase getEnvironmentUsecase,
    required MobileLoginUsecase mobileLoginUsecase,
    required IInitClockUsecase initClockUsecase,
    required SyncFaceEmployeeUsecase syncFaceEmployeeUsecase,
    required ISynchronizeClockingEventUsecase synchronizeClockingEventUsecase,
    required LogService logService,
  })  : _getTokenUsecase = getTokenUsecase,
        _hasConnectivityUsecase = hasConnectivityUsecase,
        _workIndicatorService = workIndicatorService,
        _getEnvironmentUsecase = getEnvironmentUsecase,
        _mobileLoginUsecase = mobileLoginUsecase,
        _initClockUsecase = initClockUsecase,
        _syncFaceEmployeeUsecase = syncFaceEmployeeUsecase,
        _synchronizeClockingEventUsecase = synchronizeClockingEventUsecase,
        _logService = logService;

  @override
  Future<SyncIndividualStatusType> call() async {
    if (futureCall != null) {
      return futureCall!;
    } else {
      _workIndicatorService.addWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncAllIndividualInfo,
      );

      futureCall = _sync().whenComplete(() {
        futureCall = null;
        _workIndicatorService.removeWorkIndicator(
          workIndicatorType: WorkIndicatorType.syncAllIndividualInfo,
        );
      });

      return futureCall!;
    }
  }

  Future<SyncIndividualStatusType> _sync() async {
    Token? userAccessToken =
        await _getTokenUsecase.call(tokenType: TokenType.user);

    if (userAccessToken == null) {
      _logService.saveLocalLog(
        exception: 'SyncAllIndividualInfoUsecaseImpl',
        stackTrace: 'tokenAccessToken is null',
      );
      return SyncIndividualStatusType.tokenUnavailable;
    }

    bool hasConnectivity = await _hasConnectivityUsecase.call();

    if (!hasConnectivity) {
      _logService.saveLocalLog(
        exception: 'SyncAllIndividualInfoUsecaseImpl',
        stackTrace: 'No internet connection',
      );
      return SyncIndividualStatusType.connectionUnavailable;
    }

    EnvironmentEnum environmentEnum = await _getEnvironmentUsecase.call();
    var mobile =
        await _mobileLoginUsecase.call(environmentEnum, userAccessToken);
    if (mobile != null && mobile.success) {
      await _initClockUsecase.call();
      SynchronizationResult syncFaceResult =
          await _syncFaceEmployeeUsecase.call();

      SynchronizationResult syncClockResult =
          await _synchronizeClockingEventUsecase.call();

      _logService.saveLocalLog(
        exception: 'SyncAllIndividualInfoUsecaseImpl',
        stackTrace:
            'syncFaceResult: ${syncFaceResult.status}, syncClockResult: ${syncClockResult.status}',
      );

      if (syncFaceResult.status != SynchronizationStatus.success ||
          syncClockResult.status != SynchronizationStatus.success) {
        return SyncIndividualStatusType.failure;
      }

      return SyncIndividualStatusType.success;
    } else {
      _logService.saveLocalLog(
        exception: 'SyncAllIndividualInfoUsecaseImpl',
        stackTrace: 'Mobile login failed',
      );
      return SyncIndividualStatusType.failure;
    }
  }
}
