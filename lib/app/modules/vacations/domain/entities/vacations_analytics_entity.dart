import 'package:equatable/equatable.dart';

class VacationsAnalyticsEntity extends Equatable {
  final double balance;
  final double proportional;
  final double pastDueBalance;
  final double doubled;

  const VacationsAnalyticsEntity({
    required this.balance,
    required this.proportional,
    required this.pastDueBalance,
    required this.doubled,
  });

  @override
  List<Object> get props {
    return [
      balance,
      proportional,
      pastDueBalance,
      doubled,
    ];
  }
}
