import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';

void main() {
  test(
    'UserActionEnum test.',
    () {
      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.entityPerimeter.resource,
        ),
        UserResourceEnum.entityPerimeter,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.entityOvernight.resource,
        ),
        UserResourceEnum.entityOvernight,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.pushNotification.resource,
        ),
        UserResourceEnum.pushNotification,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.clockEventList.resource,
        ),
        UserResourceEnum.clockEventList,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.clockingEvent.resource,
        ),
        UserResourceEnum.clockingEvent,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.qrcodeconfig.resource,
        ),
        UserResourceEnum.qrcodeconfig,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.facialAuth.resource,
        ),
        UserResourceEnum.facialAuth,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.employeesQrCode.resource,
        ),
        UserResourceEnum.employeesQrCode,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.employee.resource,
        ),
        UserResourceEnum.employee,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.manager.resource,
        ),
        UserResourceEnum.manager,
      );

      expect(
        UserResourceEnum.build(
          resource: UserResourceEnum.admin.resource,
        ),
        UserResourceEnum.admin,
      );

      expect(
        () => EnvironmentEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
