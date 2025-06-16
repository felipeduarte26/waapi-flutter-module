import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/platform_user_dto.dart';

clock.PlatformUserEmployeeDto platformUserDtoMock = clock.PlatformUserEmployeeDto(
  username: 'username',
  id: '123456789',
);

auth.PlatformUserEmployeeDTO platformUserEmployeeDtoMock = auth.PlatformUserEmployeeDTO(
  username: 'username',
  id: '123456789',
);

PlatformUserDto platformUserMockDto = PlatformUserDto(
  username: 'username',
  id: '123456789',
);

PlatformUserDto platformUserMockDto2 = PlatformUserDto(
  username: 'username',
  id: '2',
);
