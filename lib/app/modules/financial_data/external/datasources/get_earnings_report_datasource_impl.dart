import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../core/services/integration_user/infra/repositories/integration_user_repository_impl.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_earnings_report_datasource.dart';

class GetEarningsReportDatasourceImpl implements GetEarningsReportDatasource {
  final RestService _restService;
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final GetStoredUserUsecase _getStoredUserUsecase;
  final IntegrationUserRepositoryImpl _integrationUserRepositoryImpl;

  const GetEarningsReportDatasourceImpl({
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
    required int year,
    required String registerNumber,
    required int companyNumber,
    required String connector,
  }) async {
    final tokenResult = await _getStoredTokenUsecase.call(const UserName());
    final user = await _getStoredUserUsecase.call(const UserName());

    final token = tokenResult.token;

    String report =
        '$connector?ACAO=EXEREL&SIS=FP&NOME=FPIN001.ANU&LINWEB=&dado_EAnoBase=$year&dado_EDatEnt=00/00/0000&dado_ETipNot=0&dado_ELisAut=1&dado_EConIrf=T&dado_EConLim=N&dado_ERenAci=0&dado_ECon13s=S&dado_EGraTab=N&dado_ENivOrd=0&dado_EEndFon=0&dado_ELisEve=N&dado_ESomTit=S&dado_E13sCpl=A&dado_EDesRee=P&dado_EArqDirfSAVEFILE_TXT=&dado_EAbrEmp=$companyNumber&dado_GRDAbrLote=&dado_EAbrCad=$registerNumber&dado_EAbrFil=&dado_EAbrLoc=&dado_EAbrTco=&dado_EAbrSit=&dado_EAbrVin=&order_Detalhe_1=0';

    String execSenha = '$connector?ACAO=EXESENHA&SIS=FP&NomUsu=${_integrationUserRepositoryImpl.getIntegrationUser() ?? user!.username}&redirectUrl=$report';

    Map<String, dynamic> formData = {
      'token': token!.accessToken,
      'accesstoken': token.accessToken,
    };

    final resultExecSenha = await _restService.post(
      execSenha,
      body: formData,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      skipCertificateVerification: true,
    );

    List<String> cookies = [];
    for (final cookie in resultExecSenha.cookies!) {
      cookies.add('${cookie.name}=${cookie.value}');
    }

    String cookieHeader = cookies.join('; ');

    final resultFile = await _restService.downloadFile(
      report,
      headers: {
        'Cookie': cookieHeader,
      },
    );

    return resultFile.data!;
  }
}
