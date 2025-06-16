import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../core/types/either.dart';
import '../../../g5/domain/usecases/get_g5_connector_usecase.dart';
import '../failures/hyperlink_failure.dart';

abstract class GetHyperlinkPathUsecase {
  Future<Either<HyperlinkFailure, String>> call({
    required String pdfLink,
    required String integrationLink,
  });
}

class GetHyperlinkPathUsecaseImpl implements GetHyperlinkPathUsecase {
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final GetStoredUserUsecase _getStoredUserUsecase;
  final GetG5ConnectorUsecase _getG5ConnectorUsecase;

  const GetHyperlinkPathUsecaseImpl({
    required GetStoredTokenUsecase getStoredTokenUsecase,
    required GetStoredUserUsecase getStoredUserUsecase,
    required GetG5ConnectorUsecase getG5ConnectorUsecase,
  })  : _getStoredTokenUsecase = getStoredTokenUsecase,
        _getStoredUserUsecase = getStoredUserUsecase,
        _getG5ConnectorUsecase = getG5ConnectorUsecase;

  @override
  Future<Either<HyperlinkFailure, String>> call({
    required String pdfLink,
    required String integrationLink,
  }) async {
    if (!isIntegration(pdfLink, integrationLink) && !hasSys(pdfLink)) {
      return right(pdfLink);
    }

    final reportLinkUri = Uri.parse(pdfLink);

    final tokenResult = await _getStoredTokenUsecase.call(const UserName());
    final user = await _getStoredUserUsecase.call(const UserName());

    final token = tokenResult.token;

    if (isIntegration(pdfLink, integrationLink)) {
      final urlRedirect = getUrlRedirect(reportLinkUri, integrationLink);

      final g5ConnectorResult = await _getG5ConnectorUsecase.call();

      final rubyLink = g5ConnectorResult.fold(
        (_) => null,
        (right) => right,
      );

      if (rubyLink == null) {
        return left(const HyperlinkDatasourceFailure());
      }

      final sis = Uri.parse(urlRedirect).queryParameters['SIS'] ?? 'FP';

      return right(
        '$rubyLink?ACAO=EXESENHA&SIS=$sis&NomUsu=${user!.username}&accessToken=${token!.accessToken}&redirectUrl=$urlRedirect',
      );
    }

    var firstLinkBase = reportLinkUri.origin + reportLinkUri.path;

    final sis = reportLinkUri.queryParameters['SIS'];

    firstLinkBase +=
        '?ACAO=EXESENHA&SIS=$sis&NomUsu=${user!.username}&accessToken=${token!.accessToken}&redirectUrl=$pdfLink';

    return right(firstLinkBase);
  }

  bool isIntegration(String pdfLink, String integrationLink) => pdfLink.startsWith(integrationLink);

  bool hasSys(String pdfLink) => pdfLink.contains('SIS=');

  String getUrlRedirect(Uri pdfLinkUri, String integrationLink) {
    return pdfLinkUri.toString().replaceAll('$integrationLink?url=', '').trim();
  }
}
