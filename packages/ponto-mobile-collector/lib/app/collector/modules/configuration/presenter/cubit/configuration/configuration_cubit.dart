import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/domain/entities/user_permission_check_entity.dart';
import '../../../../../core/domain/input_model/data_source_response_dto.dart';
import '../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../core/domain/services/shared_preferences/ishared_preferences_service.dart';
import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../../core/domain/usecases/get_logs_usecase.dart';
import '../../../../../core/domain/usecases/sync_logs_api_usecase.dart';
import '../../../../../core/external/drift/collector_database.dart';
import '../../../../../core/infra/utils/constants/constants_path.dart';
import '../../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../../core/infra/utils/enum/user_resource_enum.dart';
import '../../../../routes/privacy_policy_routes.dart';
import '../../../domain/usecases/get_user_face_recognition_usecase.dart';
import 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationBaseState> {
  IGetUserFaceRecognitionUsecase getUserFaceRecognitionUsecase;
  final ISharedPreferencesService sharedPreferencesService;
  final SyncLogsApiUsecase syncLogsApiUsecase;
  final GetLogsUsecase getLogsUsecase;
  final CheckUserPermissionUsecase checkUserPermissionUsecase;
  final HasConnectivityUsecase hasConnectivityUsecase;
  final NavigatorService navigatorService;

  bool showFacialRecognitionRegistration = false;
  bool isActiveLogs = false;
  bool hasLogsPermission = false;

  ConfigurationCubit({
    required this.getUserFaceRecognitionUsecase,
    required this.sharedPreferencesService,
    required this.syncLogsApiUsecase,
    required this.getLogsUsecase,
    required this.checkUserPermissionUsecase,
    required this.hasConnectivityUsecase,
    required this.navigatorService,
  }) : super(LoadingContentState());

  void loadContent() async {
    emit(LoadingContentState());

    UserPermissionCheckEntity userPermissionCheckEntity =
        UserPermissionCheckEntity(
      action: UserActionEnum.include.action,
      resource: UserResourceEnum.mobileLog.resource,
    );
    var userPermissionsEntity = await checkUserPermissionUsecase.call(
      userPermissionCheckEntity: [userPermissionCheckEntity],
    );

    hasLogsPermission = userPermissionsEntity.authorized;

    showFacialRecognitionRegistration =
        await getUserFaceRecognitionUsecase.call();
    emit(ReadContentState());
    isActiveLogs = await sharedPreferencesService.getSendCrashLog();
    emit(isActiveLogs ? LogActiveState() : LogInactiveState());
  }

  Future<void> toggleLogs() async {
    isActiveLogs = !isActiveLogs;
    await sharedPreferencesService.setSendCrashLog(value: isActiveLogs);
    emit(isActiveLogs ? LogActiveState() : LogInactiveState());
  }

  Future<void> syncLogsApi() async {
    const int batchSize = 100;
    int offset = 0;
    List<DataSourceResponseDto?> responseList = [];
    
    if (await hasConnectivityUsecase.call()) {
      List<LogsTableData> logs =
          await getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: batchSize, offset: offset);
      
      if (logs.isEmpty) {
        emit(NoLogsToSyncState());
        return;
      }

      emit(LoadSyncLogsApiState());

      while (logs.isNotEmpty) {
        DataSourceResponseDto? response = await syncLogsApiUsecase.call(listLogs: logs);
        responseList.add(response);

        if (!response.success) {
          offset += batchSize;
        }
        
        logs = await getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: batchSize, offset: offset);
      }

      int successCount = responseList.where((response) => response != null && response.success == true).length;

      if (successCount == responseList.length) {
        emit(SuccessSyncLogsApiState());
      } else if (successCount > 0 && successCount != responseList.length) {
        emit(PartialSuccessSyncLogs());
      } else {
        emit(FaliedSyncLogsApiState());
      }
    } else {
      emit(NoConnectionSyncLogsApiState());
    }
  }

  Future<void> goToLastPrivacyPoliceVersion() async {
      return navigatorService.pushNamed(
        route: PrivacyPolicyRoutes.homeFull,
      );
  }

  Future<void> goToHelpCenterDocumentation() async {
    if (await hasConnectivityUsecase.call()) {
      Uri url = Uri.parse(
        ConstantsPath.pontoLinkSeniorDocumentationHelpCenter,
      );
      await launchUrl(url);
    }
    return emit(HasNoConectionHelpCenterState());
  }
}
