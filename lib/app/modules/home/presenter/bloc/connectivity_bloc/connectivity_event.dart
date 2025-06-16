import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {}

class SetOnlineConnectivityEvent extends ConnectivityEvent {
  @override
  List<Object?> get props {
    return [];
  }
}

class SetOfflineConnectivityEvent extends ConnectivityEvent {
  @override
  List<Object?> get props {
    return [];
  }
}
