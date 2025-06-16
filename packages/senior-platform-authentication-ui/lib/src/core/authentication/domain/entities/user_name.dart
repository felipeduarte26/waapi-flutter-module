import 'package:equatable/equatable.dart';

class UserName extends Equatable {
  final String? currentUsername;

  const UserName({
    this.currentUsername,
  });

  UserName copyWith({
    String? currentUsername,
  }) {
    return UserName(currentUsername: currentUsername);
  }

  @override
  List<Object?> get props => [
        currentUsername,
      ];
}
