import 'package:equatable/equatable.dart';

abstract class GetCurrentVersionEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class RequestGetCurrentVersionEvent extends GetCurrentVersionEvent {}
