import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../senior_platform_authentication_ui.dart';
import '../../domain/entities/key_authentication_data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// Authentication business logic component.
///
/// Manages authentication status based on initialize configuration.
/// This instance must be a singleton and must be initialized closest to
/// the root of your application's widget tree.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUserUsecase _getUserUsecase;
  final StoreAuthenticationDataUsecase _storeAuthenticationDataUsecase;
  final CheckStoredTokenUsecase _checkStoredTokenUsecase;
  final LogoutUsecase _logoutUsecase;
  final ClearStoredDataUsecase _clearStoredDataUsecase;
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final RefreshStoredTokenUsecase _refreshStoredTokenUsecase;
  final CheckStatusConnectionUsecase _checkStatusConnectionUsecase;
  final StoreKeyAuthenticationDataUsecase _storeKeyAuthenticationDataUsecase;
  final CheckKeyStoredTokenUsecase _checkKeyStoredTokenUsecase;
  final RefreshKeyStoredTokenUsecase _refreshKeyStoredTokenUsecase;
  final GetStoredKeyTokenUsecase _getStoredKeyTokenUsecase;
  final ClearKeyStoredDataUsecase _clearKeyStoredDataUsecase;
  final GetStoredKeyUsecase _getStoredKeyUsecase;
  final BiometricAuthenticateUsecase _biometricAuthAuthenticateUsecase;
  final BiometricCanCheckUseCase _biometricAuthCanAuthenticateUseCase;
  final GetStoredUserUsecase _getStoredUserUsecase;

  /// Internal constructor, should not be exposed.
  AuthenticationBloc._internal({
    required GetUserUsecase getUserUsecase,
    required StoreAuthenticationDataUsecase storeAuthenticationDataUsecase,
    required CheckStoredTokenUsecase checkStoredTokenUsecase,
    required LogoutUsecase logoutUsecase,
    required ClearStoredDataUsecase clearStoredDataUsecase,
    required GetStoredTokenUsecase getStoredTokenUsecase,
    required RefreshStoredTokenUsecase refreshStoredTokenUsecase,
    required CheckStatusConnectionUsecase checkStatusConnectionUsecase,
    required StoreKeyAuthenticationDataUsecase
        storeAppKeyAuthenticationDataUsecase,
    required CheckKeyStoredTokenUsecase checkKeyStoredTokenUsecase,
    required RefreshKeyStoredTokenUsecase refreshKeyStoredTokenUsecase,
    required GetStoredKeyTokenUsecase getStoredKeyTokenUsecase,
    required ClearKeyStoredDataUsecase clearKeyStoredDataUsecase,
    required GetStoredKeyUsecase getStoredKeyUsecase,
    required BiometricAuthenticateUsecase biometricAuthAuthenticateUsecase,
    required BiometricCanCheckUseCase biometricAuthCanAuthenticateUsecase,
    required GetStoredUserUsecase getStoredUserUsecase,
    required SecureStorageRepository secureStorageRepository,
  })  : _getUserUsecase = getUserUsecase,
        _storeAuthenticationDataUsecase = storeAuthenticationDataUsecase,
        _checkStoredTokenUsecase = checkStoredTokenUsecase,
        _logoutUsecase = logoutUsecase,
        _clearStoredDataUsecase = clearStoredDataUsecase,
        _getStoredTokenUsecase = getStoredTokenUsecase,
        _refreshStoredTokenUsecase = refreshStoredTokenUsecase,
        _checkStatusConnectionUsecase = checkStatusConnectionUsecase,
        _storeKeyAuthenticationDataUsecase =
            storeAppKeyAuthenticationDataUsecase,
        _checkKeyStoredTokenUsecase = checkKeyStoredTokenUsecase,
        _refreshKeyStoredTokenUsecase = refreshKeyStoredTokenUsecase,
        _getStoredKeyTokenUsecase = getStoredKeyTokenUsecase,
        _clearKeyStoredDataUsecase = clearKeyStoredDataUsecase,
        _getStoredKeyUsecase = getStoredKeyUsecase,
        _biometricAuthAuthenticateUsecase = biometricAuthAuthenticateUsecase,
        _biometricAuthCanAuthenticateUseCase =
            biometricAuthCanAuthenticateUsecase,
        _getStoredUserUsecase = getStoredUserUsecase,
        super(const AuthenticationState.unknown()) {
    on<AuthenticateKey>(_onAuthenticateKey);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<LogoutOnlineRequested>(_onLogoutOnlineRequested);
    on<CheckAuthenticationRequested>(_onCheckAuthenticationRequested);
    on<LogoutOfflineRequested>(_onLogoutOfflineRequested);
    on<ErrorAuthentication>(_onErrorAuthentication);
    on<ChangeAccessTokenAuthenticationRequested>(
        _changeAccessTokenAuthenticationRequested);
    on<CheckBiometricAuthenticationRequested>(_onCheckBiometricAuthentication);
  }

  /// Singleton instance for production environment.
  static final AuthenticationBloc _instance = AuthenticationBloc._internal(
    getUserUsecase: GetUserUsecase(),
    storeAuthenticationDataUsecase: StoreAuthenticationDataUsecase(),
    checkStoredTokenUsecase: CheckStoredTokenUsecase(
      getUserUsecase: GetUserUsecase(),
      checkStatusConnectionUsecase: CheckStatusConnectionUsecase(
          getConnectivityStatusUsecase: GetConnectivityStatusUsecase()),
    ),
    logoutUsecase: LogoutUsecase(),
    clearStoredDataUsecase: ClearStoredDataUsecase(),
    getStoredTokenUsecase: GetStoredTokenUsecase(),
    refreshStoredTokenUsecase: RefreshStoredTokenUsecase(
      getUserUsecase: GetUserUsecase(),
      refreshTokenUsecase: RefreshTokenUsecase(),
      storeAuthenticationDataUsecase: StoreAuthenticationDataUsecase(),
      clearStoredDataUsecase: ClearStoredDataUsecase(),
    ),
    checkStatusConnectionUsecase: CheckStatusConnectionUsecase(
        getConnectivityStatusUsecase: GetConnectivityStatusUsecase()),
    storeAppKeyAuthenticationDataUsecase: StoreKeyAuthenticationDataUsecase(),
    checkKeyStoredTokenUsecase: CheckKeyStoredTokenUsecase(),
    refreshKeyStoredTokenUsecase: RefreshKeyStoredTokenUsecase(),
    getStoredKeyTokenUsecase: GetStoredKeyTokenUsecase(),
    clearKeyStoredDataUsecase: ClearKeyStoredDataUsecase(),
    getStoredKeyUsecase: GetStoredKeyUsecase(),
    biometricAuthAuthenticateUsecase: BiometricAuthenticateUsecase(),
    biometricAuthCanAuthenticateUsecase: BiometricCanCheckUseCase(),
    getStoredUserUsecase: GetStoredUserUsecase(),
    secureStorageRepository: SecureStorageRepositoryImpl(),
  );

  /// Factory exposed constructor.
  factory AuthenticationBloc() => _instance;

  /// Factory mocked exposed constructor. Should only be used for tests.
  factory AuthenticationBloc.mocked({
    required GetUserUsecase getUserUsecase,
    required StoreAuthenticationDataUsecase storeAuthenticationDataUsecase,
    required CheckStoredTokenUsecase checkStoredTokenUsecase,
    required LogoutUsecase logoutOnlineUsecase,
    required ClearStoredDataUsecase clearStoredDataUsecase,
    required GetStoredTokenUsecase getStoredTokenUsecase,
    required RefreshStoredTokenUsecase refreshStoredTokenUsecase,
    required CheckStatusConnectionUsecase checkStatusConnectionUsecase,
    required StoreKeyAuthenticationDataUsecase
        storeAppKeyAuthenticationDataUsecase,
    required CheckKeyStoredTokenUsecase checkKeyStoredTokenUsecase,
    required RefreshKeyStoredTokenUsecase refreshKeyStoredTokenUsecase,
    required GetStoredKeyTokenUsecase getStoredKeyTokenUsecase,
    required ClearKeyStoredDataUsecase clearKeyStoredDataUsecase,
    required GetStoredKeyUsecase getStoredKeyUsecase,
    required BiometricAuthenticateUsecase biometricAuthAuthenticateUseCase,
    required BiometricCanCheckUseCase biometricAuthCanAuthenticateUseCase,
    required GetStoredUserUsecase getStoredUserUsecase,
    required SecureStorageRepository secureStorageRepository,
  }) {
    return AuthenticationBloc._internal(
      getUserUsecase: getUserUsecase,
      storeAuthenticationDataUsecase: storeAuthenticationDataUsecase,
      checkStoredTokenUsecase: checkStoredTokenUsecase,
      logoutUsecase: logoutOnlineUsecase,
      clearStoredDataUsecase: clearStoredDataUsecase,
      getStoredTokenUsecase: getStoredTokenUsecase,
      refreshStoredTokenUsecase: refreshStoredTokenUsecase,
      checkStatusConnectionUsecase: checkStatusConnectionUsecase,
      storeAppKeyAuthenticationDataUsecase:
          storeAppKeyAuthenticationDataUsecase,
      checkKeyStoredTokenUsecase: checkKeyStoredTokenUsecase,
      refreshKeyStoredTokenUsecase: refreshKeyStoredTokenUsecase,
      getStoredKeyTokenUsecase: getStoredKeyTokenUsecase,
      clearKeyStoredDataUsecase: clearKeyStoredDataUsecase,
      getStoredKeyUsecase: getStoredKeyUsecase,
      biometricAuthAuthenticateUsecase: biometricAuthAuthenticateUseCase,
      biometricAuthCanAuthenticateUsecase: biometricAuthCanAuthenticateUseCase,
      getStoredUserUsecase: getStoredUserUsecase,
      secureStorageRepository: secureStorageRepository,
    );
  }

  // Authenticate pre-configured keys
  Future<void> _onAuthenticateKey(
    AuthenticateKey event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.authenticationResponse.token == null) {
      return emit(AuthenticationState.unauthenticated(
        token: state.token,
      ));
    }

    final stored = await _storeKeyAuthenticationDataUsecase(
      KeyAuthenticationData(
        loginWithKey: event.authenticationResponse.loginWithKey,
        token: event.authenticationResponse.token,
      ),
    );

    return emit(
      stored
          ? AuthenticationState.authenticated(
              keyToken: event.authenticationResponse.token,
              token: state.token,
              biometryStatus: state.biometryStatus,
            )
          : AuthenticationState.unauthenticated(
              token: state.token,
              biometryStatus: state.biometryStatus,
            ),
    );
  }

  // Handle user authentication status changes
  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState.unauthenticated(
          biometryStatus: event.biometryStatus,
          keyToken: state.keyToken,
        ));
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser(
          GetUserInput(
            accessToken: event.authenticationResponse?.token?.accessToken ?? '',
            includePhoto: SeniorAuthentication.includePhoto,
          ),
          biometricEnabled: event.biometryStatus == BiometryStatus.success,
        );

        final stored = await _storeAuthenticationDataUsecase(
          AuthenticationData(
            user: user,
            token: event.authenticationResponse?.token,
          ),
        );

        final bool biometricEnabled =
            event.biometryStatus == BiometryStatus.success;
        if (biometricEnabled && stored) {
          if (biometricEnabled) {
            return emit(AuthenticationState.authenticated(
              token: event.authenticationResponse!.token!,
              username: event.authenticationResponse?.token?.username,
              keyToken: state.keyToken,
              biometryStatus: state.biometryStatus,
              integrationUser: user?.integration?.integrationName,
            ));
          } else {
            const username = UserName();
            await _clearStoredDataUsecase(username);
            return emit(
              AuthenticationState.unauthenticated(
                biometryStatus: event.biometryStatus,
                keyToken: state.keyToken,
              ),
            );
          }
        }

        return emit(
          stored
              ? AuthenticationState.authenticated(
                  username: event.authenticationResponse?.token?.username,
                  token: event.authenticationResponse!.token!,
                  keyToken: state.keyToken,
                  biometryStatus: state.biometryStatus,
                  integrationUser: user?.integration?.integrationName,
                )
              : AuthenticationState.unauthenticated(
                  keyToken: state.keyToken,
                  biometryStatus: state.biometryStatus,
                ),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
      case AuthenticationStatus.offline:
        return emit(
          AuthenticationState.offline(
            event.authenticationResponse?.token?.username ?? '',
            biometryStatus: state.biometryStatus,
            keyToken: state.keyToken,
            token: event.authenticationResponse?.token,
          ),
        );
    }
  }

  void _onLogoutOnlineRequested(
    LogoutOnlineRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    const username = UserName();

    try {
      final isOnline = await _checkStatusConnectionUsecase(NoParams());

      if (isOnline) {
        if (event.eraseUserToken) {
          final tokenResult = await _getStoredTokenUsecase(username);

          final token = tokenResult.token;

          if (token != null) {
            await _logoutUsecase(token.accessToken);
          }

          await _clearStoredDataUsecase(username);
        }
        if (event.eraseKeyToken) {
          ApplicationKey? key = await _getStoredKeyUsecase(null);
          if (key != null) {
            final keyTokenResult =
                await _getStoredKeyTokenUsecase(key.accessKey);
            if (keyTokenResult != null) {
              await _logoutUsecase(keyTokenResult.accessToken);
            }
            await _clearKeyStoredDataUsecase(key.accessKey);
          }
        }
      }
    } catch (err) {
      log(err.toString());
    }

    return emit(
      AuthenticationState.unauthenticated(
        biometryStatus: state.biometryStatus,
        token: event.eraseUserToken ? null : state.token,
        keyToken: event.eraseKeyToken ? null : state.keyToken,
      ),
    );
  }

  void _onLogoutOfflineRequested(
    LogoutOfflineRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final username = UserName(currentUsername: event.username);

    if (state.token != null) {
      await _clearStoredDataUsecase(username, onlyLastUser: true);
    }

    if (event.eraseKeyToken && state.keyToken != null) {
      await _clearKeyStoredDataUsecase(state.keyToken!.accessToken);
    }

    emit(AuthenticationState.unauthenticated(
      token: event.eraseUserToken ? null : state.token,
      keyToken: event.eraseKeyToken ? null : state.keyToken,
      biometryStatus: state.biometryStatus,
    ));
  }

  Future<void> _onCheckAuthenticationRequested(
    CheckAuthenticationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.checkKeyToken) {
      final isTokenValid = await _checkKeyStoredTokenUsecase(event.accesskey);

      if (!isTokenValid) {
        final keyToken =
            await _refreshKeyStoredTokenUsecase.call(event.accesskey);

        return emit(
          keyToken != null
              ? AuthenticationState.authenticated(
                  keyToken: keyToken,
                  token: state.token,
                  biometryStatus: state.biometryStatus,
                  username: event.username,
                  timestamp: event.timestamp,
                )
              : AuthenticationState.unauthenticated(
                  token: state.token,
                  biometryStatus: state.biometryStatus,
                  timestamp: event.timestamp,
                ),
        );
      } else {
        Token? keyToken;
        if (state.keyToken != null) {
          keyToken = state.keyToken;
        } else {
          keyToken = await _getStoredKeyTokenUsecase(event.accesskey);
        }

        return emit(
          AuthenticationState.authenticated(
            username: event.username,
            biometryStatus: state.biometryStatus,
            token: state.token,
            keyToken: keyToken,
            timestamp: event.timestamp,
          ),
        );
      }
    } else {
      final username = UserName(currentUsername: event.username);
      final isTokenValid = await _checkStoredTokenUsecase(
        username,
        checkOnline: event.checkOnline,
      );
      final storedUser = await _getStoredUserUsecase(username);

      Token? token;

      if (state.token != null) {
        token = state.token;
      } else {
        final storedTokenResult = await _getStoredTokenUsecase(username);
        token = storedTokenResult.token;
      }

      BiometryStatus biometryStatus = BiometryStatus.unknown;

      if (!isTokenValid) {
        token = await _refreshStoredTokenUsecase(username);
        if (token == null) {
          return emit(AuthenticationState.unauthenticated(
            keyToken: state.keyToken,
            biometryStatus: state.biometryStatus,
            timestamp: event.timestamp,
          ));
        }
      }
      if (storedUser != null) {
        if (SeniorAuthentication.enableBiometry && storedUser.activeBiometry) {
          biometryStatus = await onAuthenticationBiometricAuthRequested();

          if (biometryStatus == BiometryStatus.error ||
              biometryStatus == BiometryStatus.canceled) {
            return emit(
              AuthenticationState.unauthenticated(
                biometryStatus: biometryStatus,
                keyToken: state.keyToken,
                timestamp: event.timestamp,
              ),
            );
          }
        }
      }

      return emit(
        AuthenticationState.authenticated(
          username: event.username,
          biometryStatus: biometryStatus,
          token: token!,
          keyToken: state.keyToken,
          timestamp: event.timestamp,
          integrationUser: storedUser?.integration?.integrationName,
        ),
      );
    }
  }

  Future<User?> _tryGetUser(
    GetUserInput getUserInput, {
    required bool biometricEnabled,
  }) async {
    try {
      User user = await _getUserUsecase(getUserInput);
      user = user.copyWith(
        activeBiometry: biometricEnabled,
      );
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<void> _onErrorAuthentication(
    ErrorAuthentication event,
    Emitter<AuthenticationState> emit,
  ) async {
    const username = UserName();
    await _clearStoredDataUsecase(username);
    return emit(
      const AuthenticationState.unauthenticated(),
    );
  }

  Future<void> _changeAccessTokenAuthenticationRequested(
    ChangeAccessTokenAuthenticationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      AuthenticationState.authenticated(
        username: state.username,
        biometryStatus: state.biometryStatus,
        token: event.token,
      ),
    );
  }

  // Method that calls biometrics
  Future<BiometryStatus> onAuthenticationBiometricAuthRequested() async {
    try {
      BiometryStatus biometryStatus = BiometryStatus.unknown;
      final canAuthenticate =
          await _biometricAuthCanAuthenticateUseCase(NoParams());
      if (canAuthenticate) {
        biometryStatus = await _biometricAuthAuthenticateUsecase(
          NoParams(),
        );
      } else {
        biometryStatus = BiometryStatus.canceled;
      }
      return biometryStatus;
    } catch (e) {
      return BiometryStatus.error;
    }
  }

  Future<void> _onCheckBiometricAuthentication(
    CheckBiometricAuthenticationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final username = UserName(currentUsername: event.username);
    final storedUser = await _getStoredUserUsecase(username);

    if (storedUser == null) {
      return emit(
        AuthenticationState.unauthenticated(
          keyToken: state.keyToken,
          token: state.token,
        ),
      );
    }

    if (SeniorAuthentication.enableBiometry && storedUser.activeBiometry) {
      final biometryStatus = await onAuthenticationBiometricAuthRequested();

      if (biometryStatus == BiometryStatus.error ||
          biometryStatus == BiometryStatus.canceled) {
        return emit(
          AuthenticationState.unauthenticated(
            biometryStatus: biometryStatus,
            keyToken: state.keyToken,
            token: state.token,
          ),
        );
      }
      return emit(
        AuthenticationState.authenticated(
          username: event.username,
          biometryStatus: biometryStatus,
          token: state.token,
          keyToken: state.keyToken,
        ),
      );
    }

    emit(
      AuthenticationState.authenticated(
        username: event.username,
        token: state.token,
        keyToken: state.keyToken,
      ),
    );
  }
}
