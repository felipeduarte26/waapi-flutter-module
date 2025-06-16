import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

class AuthenticationData extends Equatable {
  final User? user;
  final Token? token;

  const AuthenticationData({
    required this.user,
    required this.token,
  });

  AuthenticationData copyWith({
    User? user,
    Token? token,
  }) {
    return AuthenticationData(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        user,
        token,
      ];
}
