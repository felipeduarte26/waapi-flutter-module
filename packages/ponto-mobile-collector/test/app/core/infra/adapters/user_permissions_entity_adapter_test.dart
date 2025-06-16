import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/user_permissions_entity_adapter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/authorization_response_mock.dart';
import '../../../../mocks/user_permissions_entity_mock.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late UserPermissionsEntityAdapter userPermissionsEntityAdapter;

  setUp(() {
    userPermissionsEntityAdapter = UserPermissionsEntityAdapter();
  });

  group('UserPermissionsEntityAdapter', () {
    test('fromModel test', () async {
      UserPermissionsEntity userPermissionsEntity =
          userPermissionsEntityAdapter.fromModel(
        authorizationResponse: authorizationResponseMock,
      );

      expect(userPermissionsEntity, userPermissionsEntityMock);
    });
  });
}
