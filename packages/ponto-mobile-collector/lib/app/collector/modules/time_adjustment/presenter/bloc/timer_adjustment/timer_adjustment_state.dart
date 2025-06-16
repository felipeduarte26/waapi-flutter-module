import '../../../../clocking_event/domain/model/clocking_event_receipt_model.dart';
import '../../../domain/model/day_info_model.dart';

abstract class TimerAdjustmentState {
  final DateTime? day;

  TimerAdjustmentState({this.day});
}

class InitialTimerAdjustmentState extends TimerAdjustmentState {}

class ReceiptTimerAdjustmentState extends TimerAdjustmentState {
  ClockingEventReceiptModel receiptModel;

  ReceiptTimerAdjustmentState({
    required this.receiptModel,
  });
}

class LoadingTimerAdjustmentState extends TimerAdjustmentState {}

class LoadedTimerAdjustmentState extends TimerAdjustmentState {
  final DayInfoModel dayInfoModel;
  final bool showAddOvernightButton;

  LoadedTimerAdjustmentState({
    required this.dayInfoModel,
    required this.showAddOvernightButton,
  });
}

class AddOvernightSuccessState extends TimerAdjustmentState {
  final bool showAddOvernightButton;
  AddOvernightSuccessState({required this.showAddOvernightButton});
}

class AddOvernightErrorState extends TimerAdjustmentState {}
