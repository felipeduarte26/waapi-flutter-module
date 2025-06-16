import '../../infra/models/vacations_analytics_model.dart';

class VacationsAnalyticsModelMapper {
  VacationsAnalyticsModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return VacationsAnalyticsModel(
      balance: map['balance'].toDouble(),
      proportional: map['proportional'].toDouble(),
      pastDueBalance: map['pastDueBalance'].toDouble(),
      doubled: map['doubled'].toDouble(),
    );
  }
}
