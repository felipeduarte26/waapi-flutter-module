import 'package:equatable/equatable.dart';

class VacationsAnalyticsModel extends Equatable {
  final double balance;
  final double proportional;
  final double pastDueBalance;
  final double doubled;

  const VacationsAnalyticsModel({
    required this.balance,
    required this.proportional,
    required this.pastDueBalance,
    required this.doubled,
  });

  @override
  List<Object> get props => [
        balance,
        proportional,
        pastDueBalance,
        doubled,
      ];
}
