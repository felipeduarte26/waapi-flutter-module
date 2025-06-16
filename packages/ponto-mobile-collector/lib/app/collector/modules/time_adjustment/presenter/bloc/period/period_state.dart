import '../../../domain/model/day_info_model.dart';

class PeriodState {
  List<DayInfoModel> data;

  PeriodState({this.data = const []});
}

class LoadingDayInfoState extends PeriodState {}

class LoadedDayInfoState extends PeriodState {
  LoadedDayInfoState({required super.data});
}
