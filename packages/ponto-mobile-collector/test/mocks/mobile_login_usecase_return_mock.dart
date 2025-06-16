import 'package:ponto_mobile_collector/app/collector/core/domain/entities/mobile_login_usecase_return.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/hlb_time_dto.dart';

import 'activation_dto_mock.dart';
import 'configuration_dto_mock.dart';
import 'employee_dto_mock.dart';

MobileLoginUsecaseReturn mobileLoginUsecaseReturnMock = MobileLoginUsecaseReturn(
  hlbTimeLocal: HlbTimeDto(hlbTime: 1722522960000), // 01/08/2024 11:36:00
  success: true,
  activationLocal: activationDtoMock,
  configurationLocal: configurationDTOMock,
  employeeLocal: employeeMockDto,
);
