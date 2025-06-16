import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

final class InitialSplashBlocState extends SplashState {}

final class FinishSplashState extends SplashState {}
