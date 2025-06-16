import 'package:flutter_modular/flutter_modular.dart';

import '../../../../ponto_mobile_collector.dart';
import '../../core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import '../../core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import 'domain/usecase/get_company_dto_usecase.dart';
import 'domain/usecase/get_employee_dto_usecase.dart';
import 'domain/usecase/get_employee_usecase.dart';
import 'domain/usecase/show_bottom_sheet_usecase.dart';
import 'domain/usecase/show_face_registration_message_usecase.dart';
import 'presenter/bloc/menu_action/menu_action_cubit.dart';

class ClockingEventBinds extends Module {
  @override
  List<Bind> get binds => [
        // USECASES
        Bind.lazySingleton<IShowBottomSheetUsecase>(
          (i) => ShowBottomSheetUsecase(bottomSheetService: i()),
          export: true,
        ),

        Bind.lazySingleton<IGetEmployeeDtoUsecase>(
          (i) => GetEmployeeDtoUsecase(employeeRepository: i()),
          export: true,
        ),

        Bind.lazySingleton<IGetCompanyDtoUsecase>(
          (i) => GetCompanyDtoUsecase(companyRepository: i()),
          export: true,
        ),

        Bind.lazySingleton<IGetEmployeeUsecase>(
          (i) => GetEmployeeUsecase(sessionService: i(),),
          export: true,
        ),

        Bind.lazySingleton<ShowFaceRegistrationMessageUsecase>(
          (i) => ShowFaceRegistrationMessageUsecaseImpl(
            sessionService: i(),
            sharedPreferencesService: i(),
            faceRecognitionSdkAuthenticationService: i(),
            getAccessTokenUsernameUsecase: i(),
            getClockingEventUseUsecase: i(),
          ),
          export: true,
        ),

        // SERVICES
        Bind.lazySingleton<IBottomSheetService>(
          (i) => BottomSheetService(),
          export: true,
        ),

        // BLOCS
        Bind.lazySingleton<ClockingEventBloc>(
          (i) => ClockingEventBloc(
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

        Bind.lazySingleton<MenuActionCubit>(
          (i) => MenuActionCubit(
            getPlatformMenusUsecase: i(),
            collectorModuleService: i(),
            platformService: i(),
          ),
          export: true,
        ),
      ];
}
