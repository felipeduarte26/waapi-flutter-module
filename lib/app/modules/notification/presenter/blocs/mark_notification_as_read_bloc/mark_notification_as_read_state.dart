import 'package:equatable/equatable.dart';

abstract class MarkNotificationAsReadState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialMarkNotificationAsReadState extends MarkNotificationAsReadState {}

class LoadingMarkNotificationAsReadState extends MarkNotificationAsReadState {}

class SucceedMarkNotificationAsReadState extends MarkNotificationAsReadState {}

class ErrorMarkNotificationAsReadState extends MarkNotificationAsReadState {}
