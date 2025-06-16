import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../ponto_mobile_collector.dart';
import '../../core/domain/services/face_recognition/face_recognition_settings_service.dart';
import '../../core/domain/services/navigator/navigator_service.dart';
import '../../core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import '../../core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import '../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'binds/facial_recognition_domain_binds.dart';
import 'binds/facial_recognition_external_binds.dart';
import 'binds/facial_recognition_infra_binds.dart';
import 'binds/facial_recognition_presenter_binds.dart';
import 'facial_recognition_binds.dart';
import 'presenter/cubit/employee_search/employee_search_cubit.dart';
import 'presenter/cubit/face_recognition/facial_recognition_cubit.dart';
import 'presenter/cubit/face_recognition/multiple/multiple_facial_recognition_cubit.dart';
import 'presenter/cubit/face_registration/face_registration_cubit.dart';
import 'presenter/screens/employee_select_screen.dart';
import 'presenter/screens/face_registration_screen.dart';
import 'presenter/screens/facial_recognition_screen.dart';
import 'presenter/screens/multiple_facial_recognition_screen.dart';

class FacialRecognitionModule extends Module {
  String homePath;

  FacialRecognitionModule({required this.homePath});

  @override
  List<Module> get imports => [
        FacialRecognitionBinds(),
        FacialRecognitionDomainBinds(),
        FacialRecognitionInfraBinds(),
        FacialRecognitionExternalBinds(),
        FacialRecognitionPresenterBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/${FacialRecognitionRoutes.recognition}',
          child: (context, args) => FacialRecognitionScreen(
            flutterGryfoLib: Modular.get<FlutterGryfoLib>(),
            facialRecognitionCubit: Modular.get<FacialRecognitionCubit>(),
            faceRecognitionSettingsService:
                Modular.get<FaceRecognitionSettingsService>(),
            utils: Modular.get<IUtils>(),
          ),
        ),
        ChildRoute(
          '/${FacialRecognitionRoutes.multipleRecognition}',
          child: (context, args) => MultipleFacialRecognitionScreen(
            utils: Modular.get<IUtils>(),
            flutterGryfoLib: Modular.get<FlutterGryfoLib>(),
            multipleFacialRecognitionCubit:
                Modular.get<MultipleFacialRecognitionCubit>(),
            timerBloc: Modular.get<TimerBloc>(),
            workIndicatorCubit: Modular.get<WorkIndicatorCubit>(),
            showBottomSheetUsecase: Modular.get<ShowBottomSheetUsecase>(),
            registerClockingEventBloc: Modular.get<RegisterClockingEventBloc>(),
            faceRecognitionSettingsService:
                Modular.get<FaceRecognitionSettingsService>(),
            confirmationSnackbarWidget: ConfirmationSnackbarWidget(
              utils: Modular.get(),
              getReceiptUsecase: Modular.get(),
              context: context,
              showBottomSheetUsecase: Modular.get(),
            ),
          ),
        ),
        ChildRoute(
          '/${FacialRecognitionRoutes.registration}/:id',
          child: (context, args) => FaceRegistrationScreen(
            faceRegistrationCubit: Modular.get<FaceRegistrationCubit>(),
            collectorCameraCubit: Modular.get<CollectorCameraCubit>(),
            navigatorService: Modular.get<NavigatorService>(),
            bottomSheetService: Modular.get<BottomSheetService>(),
            homePath: Modular.get<CollectorModuleService>().getHomePath(),
            employeeIdSelected: args.params['id'],
          ),
        ),
        ChildRoute(
          '/${FacialRecognitionRoutes.employeeSelect}',
          child: (context, args) => EmployeeSelectScreen(
            navigatorService: Modular.get<NavigatorService>(),
            employeeSearchCubit: Modular.get<EmployeeSearchCubit>(),
            utils: Modular.get<IUtils>(),
          ),
        ),
      ];
}
