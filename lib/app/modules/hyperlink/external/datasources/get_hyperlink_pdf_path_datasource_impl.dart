import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_hyperlink_pdf_path_datasource.dart';

class GetHyperlinkPdfPathDatasourceImpl implements GetHyperlinkPdfPathDatasource {
  final RestService _restService;
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final GetStoredUserUsecase _getStoredUserUsecase;

  const GetHyperlinkPdfPathDatasourceImpl({
    required RestService restService,
    required GetStoredTokenUsecase getStoredTokenUsecase,
    required GetStoredUserUsecase getStoredUserUsecase,
  })  : _restService = restService,
        _getStoredTokenUsecase = getStoredTokenUsecase,
        _getStoredUserUsecase = getStoredUserUsecase;

  @override
  Future<List<int>> call({
    required String pdfLink,
  }) async {
    final tokenResult = await _getStoredTokenUsecase.call(const UserName());
    final user = await _getStoredUserUsecase.call(const UserName());

    final token = tokenResult.token;


    if (pdfLink.contains('EXESENHA')) {
      pdfLink = getUrlRedirect(pdfLink);
    }

    final reportLinkUri = Uri.parse(pdfLink);

    var firstLinkBase = reportLinkUri.origin + reportLinkUri.path;

    firstLinkBase +=
        '?ACAO=EXESENHA&SIS=FP&NomUsu=${user!.username}&accessToken=${token!.accessToken}&redirectUrl=$pdfLink';

    final resultExecSenha = await _restService.get(firstLinkBase);

    final connectionCookie = resultExecSenha.cookies!.firstWhere((element) => element.name == 'CONNECTION');

    pdfLink += '&CONNECTION=${connectionCookie.value}&USER=${user.username}';

    final resultFile = await _restService.downloadFile(pdfLink);

    return resultFile.data!;
  }  

  String getUrlRedirect(String pdfLinkUri) {
    final urlRegExp = RegExp(r'redirectUrl=([^]+)');

    final urlMatches = urlRegExp.firstMatch(pdfLinkUri);

    if (urlMatches != null) {
      return urlMatches.group(1)!;
    }

    return pdfLinkUri;
  }
}
