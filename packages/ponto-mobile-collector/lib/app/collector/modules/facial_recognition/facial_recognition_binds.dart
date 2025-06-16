import 'package:flutter_modular/flutter_modular.dart';

import '../../../../ponto_mobile_collector.dart';
import '../../core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import '../../core/domain/usecases/get_message_recognition_stream_usecase.dart';
import '../../core/domain/usecases/register_face_employee_usecase.dart';
import '../../core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import 'domain/usecases/person_exists_on_facial_recognition_usecase.dart';
import 'presenter/cubit/employee_search/employee_search_cubit.dart';
import 'presenter/cubit/face_recognition/facial_recognition_cubit.dart';
import 'presenter/cubit/face_recognition/multiple/multiple_facial_recognition_cubit.dart';
import 'presenter/cubit/face_registration/face_registration_cubit.dart';

class FacialRecognitionBinds extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<IPersonExistsOnFacialRecognitionUsecase>(
          (i) => PersonExistsOnFacialRecognitionUsecase(
            environmentService: i(),
            httpClient: i(),
            sessionService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<FaceRegistrationCubit>(
          (i) => FaceRegistrationCubit(
            hasConnectivityUsecase: i(),
            personExistsOnFacialRecognitionUsecase: i(),
            registerFaceEmployeeUsecase: i(),
            syncFaceEmployeeUsecase: i(),
            faceRecognitionSdkAuthenticationService: i(),
            checkUserPermissionUsecase: i(),
            requestCameraPermissionsModalWidget: i(),
            getExecutionModeUsecase: i(),
            syncMultipleFaceEmployeesUsecase: i(),
            syncEmployeeByIdUsecase: i(),
          ),
          export: true,
          onDispose: (value) => value.close(),
        ),
        Bind.lazySingleton<IRegisterFaceEmployeeUsecase>(
          (i) => RegisterFaceEmployeeUsecase(
            faceRecognitionRegisterFaceRepository: i(),
            sessionService: i(),
            employeeRepository: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<CollectorCameraCubit>(
          (i) => CollectorCameraCubit(sharedPreferencesService: i()),
          export: true,
        ),
        Bind.lazySingleton<IGetMessageRecognitionStreamUsecase>(
          (i) => GetMessageRecognitionStreamUsecase(
            faceRecognitionSdkAuthenticationService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<FacialRecognitionCubit>(
          (i) => FacialRecognitionCubit(
            getSessionEmployeeUsecase: i(),
            getMessageRecognitionStremUsecase: i(),
            sharedPreferencesService: i(),
            flutterGryfoLib: i(),
            logService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<MultipleFacialRecognitionCubit>(
          (i) => MultipleFacialRecognitionCubit(
            getMessageRecognitionStremUsecase: i(),
            sharedPreferencesService: i(),
            flutterGryfoLib: i(),
            registerClockingEventBloc: i(),
            employeeRepository: i(),
            platformService: i(),
            logService: i(),
            getLifecycleStreamUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<EmployeeSearchCubit>(
          (i) => EmployeeSearchCubit(
            checkUserPermissionUsecase: i(),
            getEmployeesToFacialRegistrationUsecase: i(),
            hasConnectivityUsecase: i(),
          ),
          export: true,
          onDispose: (cubit) => cubit.close(),
        ),
        Bind.lazySingleton<IBottomSheetService>(
          (i) => BottomSheetService(),
          export: true,
        ),
      ];
}
