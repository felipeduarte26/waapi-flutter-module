import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../core/services/integration_user/infra/repositories/integration_user_repository_impl.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_report_vacation_datasource.dart';

class GetReportVacationDatasourceImpl implements GetReportVacationDatasource {
  final RestService _restService;
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final GetStoredUserUsecase _getStoredUserUsecase;
  final IntegrationUserRepositoryImpl _integrationUserRepositoryImpl;

  const GetReportVacationDatasourceImpl({
    required RestService restService,
    required GetStoredTokenUsecase getStoredTokenUsecase,
    required GetStoredUserUsecase getStoredUserUsecase,
    required IntegrationUserRepositoryImpl integrationUserRepositoryImpl,
  })  : _restService = restService,
        _getStoredTokenUsecase = getStoredTokenUsecase,
        _getStoredUserUsecase = getStoredUserUsecase,
        _integrationUserRepositoryImpl = integrationUserRepositoryImpl;

  @override
  Future<List<int>> call({
    required String reportLink,
  }) async {
    final tokenResult = await _getStoredTokenUsecase.call(const UserName());
    final user = await _getStoredUserUsecase.call(const UserName());

    final reportLinkUri = Uri.parse(reportLink);

    final token = tokenResult.token;

    var firstLinkBase = reportLinkUri.origin + reportLinkUri.path;

    Map<String, dynamic> formData = {
      'token': token!.accessToken,
      'accesstoken': token.accessToken,
    };

    firstLinkBase += '?ACAO=EXESENHA&SIS=FP&NomUsu=${_integrationUserRepositoryImpl.getIntegrationUser() ?? user!.username}&redirectUrl=$reportLink';

    final resultExecSenha = await _restService.post(
      firstLinkBase,
      body: formData,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      skipCertificateVerification: true,
    );

    List<String> cookies = [];
    if (resultExecSenha.cookies != null) {
      for (final cookie in resultExecSenha.cookies!) {
        cookies.add('${cookie.name}=${cookie.value}');
      }
    }

    String cookieHeader = cookies.join('; ');

    final resultFile = await _restService.downloadFile(
      reportLink,
      headers: {
        'Cookie': cookieHeader,
      },
    );

    return resultFile.data!;
  }
}
