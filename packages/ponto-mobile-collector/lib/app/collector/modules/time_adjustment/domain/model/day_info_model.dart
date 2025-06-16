
import '../../../../core/domain/input_model/employee_dto.dart';
import 'time_info_model.dart';

class DayInfoModel {
  final DateTime day;
  final List<TimeInfoModel> times;
  final bool isSynchronized;
  final bool isOdd;
  final bool isRemoteness;
  EmployeeDto? employee;
  final bool? isOvernight;

  DayInfoModel({
    required this.isOdd,
    required this.day,
    required this.isSynchronized,
    required this.isRemoteness,
    required this.times,
    this.isOvernight = false,
    this.employee,
  });

  List<DateTime> getDateTimes() {
    List<DateTime> dateTimes = [];

    if (times.isNotEmpty) {
      for(TimeInfoModel time in times) {
        dateTimes.add(time.dateTime);
      }
    }

    return dateTimes;
  }
}
