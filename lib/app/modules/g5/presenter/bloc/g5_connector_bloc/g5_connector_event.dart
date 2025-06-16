import 'package:equatable/equatable.dart';

abstract class G5ConnectorEvent extends Equatable {
  const G5ConnectorEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetG5ConnectorEvent extends G5ConnectorEvent {}
