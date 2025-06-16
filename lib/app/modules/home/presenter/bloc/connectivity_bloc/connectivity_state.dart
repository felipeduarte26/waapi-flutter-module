import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialConnectivityState extends ConnectivityState {}

class OnlineConnectivityState extends ConnectivityState {}

class OfflineConnectivityState extends ConnectivityState {}
