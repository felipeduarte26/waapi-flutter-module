import '../../../../../senior_platform_authentication_ui.dart';

/// Verifies if the connection to network is working.
class CheckStatusConnectionUsecase implements BaseUsecase<bool, NoParams> {
  late final GetConnectivityStatusUsecase _getConnectivityStatusUsecase;

  CheckStatusConnectionUsecase({
    required GetConnectivityStatusUsecase getConnectivityStatusUsecase,
  }) : _getConnectivityStatusUsecase = getConnectivityStatusUsecase;

  @override
  Future<bool> call(NoParams params) async {
    return _getConnectivityStatusUsecase(params);
  }
}
