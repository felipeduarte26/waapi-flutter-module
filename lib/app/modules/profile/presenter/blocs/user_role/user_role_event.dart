import 'package:equatable/equatable.dart';

abstract class UserRoleEvent extends Equatable {
  const UserRoleEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetUserRoleIdEvent extends UserRoleEvent {
  const GetUserRoleIdEvent();

  @override
  List<Object> get props {
    return [
      ...super.props,
    ];
  }
}
