import 'package:intl/intl.dart';

import '../../../../core/domain/entities/overnight_entity.dart';
import '../../../../core/domain/enums/clocking_event_origin.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/repositories/database/iemployee_repository.dart';
import '../../../../core/external/mappers/employee_mapper.dart';
import '../../domain/model/day_info_model.dart';
import '../../domain/model/time_info_model.dart';
import '../../domain/service/iday_info_service.dart';

/// Converts a Clocking Event list to a DayInfoModel to be displayed in the screen listing.
class DayInfoService implements IDayInfoService {
  final IEmployeeRepository _employeeRepository;

  DayInfoService({
    required IEmployeeRepository employeeRepository,
  }) : _employeeRepository = employeeRepository;

  @override
  Future<List<DayInfoModel>> generate({
    required List<ClockingEventDto> clockingEvents,
    required DateTime initialDate,
    required DateTime finalDate,
    List<OvernightEntity>? overnights,
    String? journeyId,
  }) async {
    List<DayInfoModel> dayInfoList = [];

    initialDate =
        DateTime(initialDate.year, initialDate.month, initialDate.day, 0, 0, 0);
    finalDate = DateTime(
      finalDate.year,
      finalDate.month,
      finalDate.day,
      23,
      59,
      59,
      999,
    );

    DateTime currentDay = DateTime(
      initialDate.year,
      initialDate.month,
      initialDate.day,
      0,
      0,
      0,
    );

    DateFormat formatter = DateFormat('yyyy-MM-dd');

    while (currentDay.isBefore(finalDate)) {
      String dayToFind = formatter.format(currentDay);
      List<ClockingEventDto> dayClockingEvents = [];

      if (journeyId != null) {
        dayClockingEvents = clockingEvents;
      } else {
        dayClockingEvents = clockingEvents
            .where((clock) => dayToFind == clock.dateEvent)
            .toList();
      }

      if (dayClockingEvents.isEmpty) {
        DayInfoModel dayinfo = DayInfoModel(
          day: currentDay,
          isOdd: _verifyIsOdd(dayClockingEvents),
          isSynchronized: _verifyIsSynchronized(dayClockingEvents),
          isRemoteness: _verifyIsRemoteness(dayClockingEvents),
          times: _getTimes(dayClockingEvents, currentDay),
          employee: null,
          isOvernight: overnights != null && overnights.isNotEmpty
              ? overnights.any(
                  (element) => element.date.day == currentDay.day,
                )
              : false,
        );

        dayInfoList.add(dayinfo);
        currentDay = currentDay.add(const Duration(days: 1));
        continue;
      }

      while (dayClockingEvents.isNotEmpty) {
        var dto = dayClockingEvents.first;

        var dayClockingEventsByEmployee = dayClockingEvents
            .where((clock) => clock.employeeDto!.id == dto.employeeDto!.id)
            .toList();

        dayClockingEvents.removeWhere(
            (clock) => clock.employeeDto!.id == dto.employeeDto!.id,);

        dayClockingEventsByEmployee.sort(
          (a, b) => a.getDateTimeEvent().compareTo(b.getDateTimeEvent()),
        );

        DayInfoModel dayinfo = DayInfoModel(
          day: currentDay,
          isOdd: _verifyIsOdd(dayClockingEventsByEmployee),
          isSynchronized: _verifyIsSynchronized(dayClockingEventsByEmployee),
          isRemoteness: _verifyIsRemoteness(dayClockingEventsByEmployee),
          times: _getTimes(dayClockingEventsByEmployee, currentDay),
          employee: await findByEmployeeId(dto.employeeDto!.id),
          isOvernight: overnights != null && overnights.isNotEmpty
              ? overnights.any(
                  (element) => element.date.day == currentDay.day,
                )
              : false,
        );

        dayInfoList.add(dayinfo);
      }

      currentDay = currentDay.add(const Duration(days: 1));
    }

    return dayInfoList;
  }

  bool _verifyIsSynchronized(List<ClockingEventDto> clockingEvents) {
    if (clockingEvents.isNotEmpty) {
      for (ClockingEventDto dto in clockingEvents) {
        if (!dto.isSynchronized) {
          return false;
        }
      }
    }
    return true;
  }

  bool _verifyIsRemoteness(List<ClockingEventDto> clockingEvents) {
    return false;
  }

  bool _verifyIsOdd(List<ClockingEventDto> clockingEvents) {
    if (clockingEvents.isNotEmpty) {
      return (clockingEvents.length % 2) == 1 ? true : false;
    }

    return false;
  }

  List<TimeInfoModel> _getTimes(
    List<ClockingEventDto> clockingEvents,
    DateTime dateTime,
  ) {
    List<TimeInfoModel> times = [];
    if (clockingEvents.isNotEmpty) {
      for (ClockingEventDto dto in clockingEvents) {
        bool isSynchronized = dto.isSynchronized;
        bool isManual = false;
        bool isRemoteness = false;

        times.add(
          TimeInfoModel(
            clockingEventId: dto.clockingEventId,
            dateTime: dto.getDateTimeEvent(),
            isBold: !isSynchronized || isManual || isRemoteness,
            isSynchronized: isSynchronized,
            isManual: isManual,
            isRemoteness: isRemoteness,
            isPhoneOrigin: dto.origin != null &&
                dto.origin == ClockingEventOriginEnum.mobile,
            isPlatformOrigin: dto.origin != null &&
                (dto.origin == ClockingEventOriginEnum.web ||
                    dto.origin == ClockingEventOriginEnum.client),
            use: int.parse(dto.use),
            isMealBreak: dto.isMealBreak!,
          ),
        );
      }

      return times;
    }

    return times;
  }

  Future<EmployeeDto?> findByEmployeeId(String employeeId) async {
    var entitiy = await _employeeRepository.findById(id: employeeId);
    return EmployeeMapper.fromEntityToDtoCollector(entitiy);
  }
}
