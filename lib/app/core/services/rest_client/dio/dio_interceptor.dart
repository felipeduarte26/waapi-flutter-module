import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../modules/profile/presenter/blocs/user_role/user_role_bloc.dart';
import '../../../../modules/profile/presenter/blocs/user_role/user_role_state.dart';
import '../../../../routes/routes.dart';

class DioInterceptor extends QueuedInterceptor {
  final Dio _dio;

  DioInterceptor({
    required Dio dio,
  }) : _dio = dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final Token? token = await _getToken();
    options = await _updateHeaderRequest(options, token);
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != null && err.response!.statusCode! == 401) {
      await _handleUnauthorizedError(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<Token?> _getToken() async {
    Token? token;

    try {
      final tokenResult = await GetStoredTokenUsecase().call(const UserName());
      token = tokenResult.token;
    } catch (e) {
      token = null;
    }

    return token;
  }

  Future<RequestOptions> _updateHeaderRequest(
    RequestOptions options,
    Token? token,
  ) async {
    final packageInfo = await PackageInfo.fromPlatform();
    String projectName = packageInfo.appName;
    String projectVersion = packageInfo.version;

    String currentUserAgent = options.headers['User-Agent'] ?? '';
    options.headers['User-Agent'] = '$currentUserAgent $projectName/$projectVersion';
    options.headers['Acess-Token'] = _getPartialToken(token?.accessToken);

    options.headers.addAll({
      'Authorization': 'Bearer ${token?.accessToken}',
      'user-role-active': await _getUserRole(),
    });

    if (options.method == 'DELETE') {
      options.headers.remove('content-type');
    }

    if (options.responseType == ResponseType.bytes) {
      options.headers.remove('Authorization');
    }

    return options;
  }

  String _getPartialToken(String? token) {
    if (token == null || token.isEmpty || token.length < 10) {
      return '';
    }
    return token.substring(0, 5) + token.substring(token.length - 5, token.length);
  }

  Future<String?> _getUserRole() async {
    late final UserRoleBloc? userRoleBloc;

    try {
      userRoleBloc = Modular.get<UserRoleBloc>();
    } catch (e) {
      userRoleBloc = null;
    }

    if (userRoleBloc?.state is LoadedUserRoleState) {
      return (userRoleBloc?.state as LoadedUserRoleState).userRoleId;
    }

    return null;
  }

  Future<void> _handleUnauthorizedError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    if ((requestOptions.headers['Retry-Count'] ?? 0) >= 1) {
      handler.reject(DioException(requestOptions: requestOptions));
      AuthenticationBloc().add(const LogoutOnlineRequested());
      return;
    }

    final refreshToken = await RefreshStoredTokenUsecase().call(const UserName());

    requestOptions.headers['Refresh-Token'] = _getPartialToken(refreshToken?.accessToken);
    requestOptions.headers['Retry-Count'] = 1;

    if (refreshToken != null) {
      _retryRequestRefreshToken(refreshToken, requestOptions, handler);
      return;
    }

    _refreshTokenNull(err, handler);
  }

  void _retryRequestRefreshToken(
    Token token,
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    if (token.accessToken.isEmpty) {}

    Modular.get<AuthenticationBloc>().add(
      ChangeAccessTokenAuthenticationRequested(
        token: token,
      ),
    );

    requestOptions.headers['Retry-Count'] = 1;

    try {
      final response = await _dio.fetch(requestOptions);
      handler.resolve(response);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void _refreshTokenNull(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
    AuthenticationBloc().add(
      const LogoutOnlineRequested(),
    );

    Modular.to.navigate(AuthenticationRoutes.authenticationModuleRoute);
  }
}
