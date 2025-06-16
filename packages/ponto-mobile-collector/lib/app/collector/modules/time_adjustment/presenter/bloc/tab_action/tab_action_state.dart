import '../../../domain/model/day_info_model.dart';

abstract class TabState {}

class DayModelSelectedTabState extends TabState {}
class TabActionState extends TabState {
  final int tabIndex;
  final DayInfoModel? lastDaySelected;

  TabActionState({
    required this.tabIndex,
    this.lastDaySelected,
  });
}

final tabActionInitialState = TabActionState(
  tabIndex: 0,
);
