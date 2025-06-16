import '../../domain/entities/vacations_analytics_entity.dart';
import '../models/vacations_analytics_model.dart';

class VacationsAnalyticsEntityAdapter {
  VacationsAnalyticsEntity fromModel({
    required VacationsAnalyticsModel vacationsAnalyticsModel,
  }) {
    return VacationsAnalyticsEntity(
      balance: vacationsAnalyticsModel.balance,
      doubled: vacationsAnalyticsModel.doubled,
      pastDueBalance: vacationsAnalyticsModel.pastDueBalance,
      proportional: vacationsAnalyticsModel.proportional,
    );
  }
}
