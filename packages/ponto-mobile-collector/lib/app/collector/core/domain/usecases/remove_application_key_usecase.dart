import 'dart:developer';

import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../ponto_mobile_collector.dart';
import '../repositories/database/iemployee_platform_user_repository.dart';
import '../repositories/database/imanager_employee_repository.dart';
import '../repositories/database/imanager_repository.dart';
import '../repositories/database/iplatform_user_repository.dart';

abstract class RemoveApplicationKeyUsecase {
  Future<void> call();
}

class RemoveApplicationKeyUsecaseImpl implements RemoveApplicationKeyUsecase {
  final IEmployeePlatformUserRepository _employeePlatformUserRepository;
  final IEmployeeFenceRepository _employeeFenceRepository;
  final IEmployeeRepository _employeeRepository;
  final ICompanyRepository _companyRepository;
  final IManagerPlatformUserRepository _managerPlatformUserRepository;
  final IManagerEmployeeRepository _managerEmployeeRepository;
  final IManagerRepository _managerRepository;
  final IPlatformUserRepository _platformUserRepository;
  final IClockingEventRepository _clockingEventRepository;
  final ISharedPreferencesService _sharedPreferencesService;
  final ISessionService _sessionService;
  final GetStoredKeyUsecase _getStoredKeyUsecase;
  final ClearKeyStoredDataUsecase _clearKeyStoredDataUsecase;
  final ClearStoredDataUsecase _clearStoredDataUsecase;
  final AuthenticationBloc _authenticationBloc;

  const RemoveApplicationKeyUsecaseImpl({
    required IEmployeePlatformUserRepository employeePlatformUserRepository,
    required IEmployeeFenceRepository employeeFenceRepository,
    required IEmployeeRepository employeeRepository,
    required ICompanyRepository companyRepository,
    required IManagerPlatformUserRepository managerPlatformUserRepository,
    required IManagerEmployeeRepository managerEmployeeRepository,
    required IManagerRepository managerRepository,
    required IPlatformUserRepository platformUserRepository,
    required IClockingEventRepository clockingEventRepository,
    required ISharedPreferencesService sharedPreferencesService,
    required ISessionService sessionService,
    required GetStoredKeyUsecase getStoredKeyUsecase,
    required ClearKeyStoredDataUsecase clearKeyStoredDataUsecase,
    required ClearStoredDataUsecase clearStoredDataUsecase,
    required AuthenticationBloc authenticationBloc,
  })  : _employeePlatformUserRepository = employeePlatformUserRepository,
        _employeeFenceRepository = employeeFenceRepository,
        _employeeRepository = employeeRepository,
        _companyRepository = companyRepository,
        _managerPlatformUserRepository = managerPlatformUserRepository,
        _managerEmployeeRepository = managerEmployeeRepository,
        _managerRepository = managerRepository,
        _platformUserRepository = platformUserRepository,
        _clockingEventRepository = clockingEventRepository,
        _sharedPreferencesService = sharedPreferencesService,
        _sessionService = sessionService,
        _getStoredKeyUsecase = getStoredKeyUsecase,
        _clearKeyStoredDataUsecase = clearKeyStoredDataUsecase,
        _clearStoredDataUsecase = clearStoredDataUsecase,
        _authenticationBloc = authenticationBloc;

  @override
  Future<void> call() async {
    try {
      await _employeePlatformUserRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Employee Platform User');
      log(e.toString());
      rethrow;
    }

    try {
      await _employeeFenceRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Employee Fence');
      log(e.toString());
      rethrow;
    }

    try {
      await _employeeRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Employee');
      log(e.toString());
      rethrow;
    }

    try {
      await _companyRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Company');
      log(e.toString());
      rethrow;
    }

    try {
      await _managerPlatformUserRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Manager Platform User');
      log(e.toString());
      rethrow;
    }

    try {
      await _managerEmployeeRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Manager Employee');
      log(e.toString());
      rethrow;
    }

    try {
      await _managerRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Manager');
      log(e.toString());
      rethrow;
    }

    try {
      await _platformUserRepository.deleteAll();
    } catch (e) {
      log('Exception on delete Platform User');
      log(e.toString());
      rethrow;
    }

    try {
      await _clockingEventRepository.deleteAllSynced();
    } catch (e) {
      log('Exception on delete Clocking Events');
      log(e.toString());
      rethrow;
    }

    try {
      await _sharedPreferencesService.clearAll();
    } catch (e) {
      log('Exception on clear Shared Preferences');
      log(e.toString());
      rethrow;
    }

    try {
      ApplicationKey? applicationKey = await _getStoredKeyUsecase.call(null);

      if (applicationKey != null) {
        _clearKeyStoredDataUsecase.call(applicationKey.accessKey);
      }

      await _sessionService.clean();
      await _clearStoredDataUsecase.call(const UserName());
      _authenticationBloc.add(
        const LogoutOfflineRequested(
          username: '',
          eraseKeyToken: true,
          eraseUserToken: true,
        ),
      );
    } catch (e) {
      log('Exception on Deauthenticate User');
      log(e.toString());
      rethrow;
    }
  }
}
