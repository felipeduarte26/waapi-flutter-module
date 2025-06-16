import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import 'employee_dto_mock.dart';

DayInfoModel dayInfoModelMock = DayInfoModel(
  day: DateTime.now(),
  isOdd: false,
  isRemoteness: false,
  isSynchronized: true,
  employee: employeeMockDto,
  times: [],
);
