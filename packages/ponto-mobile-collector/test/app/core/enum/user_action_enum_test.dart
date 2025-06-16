import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';

void main() {
  test(
    'UserActionEnum test.',
    () {
      expect(
        UserActionEnum.build(action: UserActionEnum.allow.action),
        UserActionEnum.allow,
      );

      expect(
        UserActionEnum.build(action: UserActionEnum.edit.action),
        UserActionEnum.edit,
      );

      expect(
        UserActionEnum.build(action: UserActionEnum.delete.action),
        UserActionEnum.delete,
      );

      expect(
        UserActionEnum.build(action: UserActionEnum.include.action),
        UserActionEnum.include,
      );

      expect(
        UserActionEnum.build(action: UserActionEnum.view.action),
        UserActionEnum.view,
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
