import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../modules/routes/application_key_routes.dart';
import '../../../../domain/enums/token_type.dart';
import '../../../../domain/services/navigator/navigator_service.dart';
import '../../../../domain/services/platform/iplatform_service.dart';
import '../../../../domain/usecases/get_access_token_usecase.dart';
import '../../configuration/collector_module_service.dart';

class TokenInterceptor implements InterceptorContract {
  final ClearStoredDataUsecase _clearStoredDataUsecase;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final NavigatorService _navigatorService;
  final IPlatformService _platformService;

  const TokenInterceptor({
    required ClearStoredDataUsecase clearStoredDataUsecase,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required NavigatorService navigatorService,
    required IPlatformService platformService,
  })  : _clearStoredDataUsecase = clearStoredDataUsecase,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _navigatorService = navigatorService,
        _platformService = platformService;

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    log('TokenInterceptor: request - ${request.url.toString()}');

    TokenType tokenType = TokenType.first;
    String? tokenTypeValue = request.headers['Token-Type'];

    if (tokenTypeValue != null && tokenTypeValue.isNotEmpty && tokenTypeValue != 'null') {
      tokenType = TokenType.build(value: tokenTypeValue);
    }

    String? accessToken =
        await _getAccessTokenUsecase.call(tokenType: tokenType);

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    PackageInfo info = await _platformService.getPackageinfo();
    String currentUserAgent = request.headers['User-Agent'] ?? '';
    request.headers['User-Agent'] =
        '$currentUserAgent Collector/${info.appName}/${info.version}';

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    log('TokenInterceptor: response - ${response.statusCode} - ${response.request?.url.toString()}');
    if (response.statusCode == 401) {
      log('TokenInterceptor: response - ${response.reasonPhrase} - ${response.headers.toString()}');
      String? keyToken =
          await _getAccessTokenUsecase.call(tokenType: TokenType.key);
      if (keyToken != null) {
        _navigatorService.navigate(
          route: ApplicationKeyRoutes.failedAuthenticationKeyFull,
        );
      } else {
        String? userToken =
            await _getAccessTokenUsecase.call(tokenType: TokenType.user);
        if (userToken != null) {
          await _clearStoredDataUsecase.call(const UserName());
          _navigatorService.navigate(route: CollectorModuleService.loginPath);
        }
      }
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}
