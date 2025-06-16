import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';

class MockBottomSheetService extends Mock implements IBottomSheetService {}

class MockBuildContext extends Mock implements BuildContext {}

class FakeLoginConfigurationDTO extends Fake
    implements auth.LoginConfigurationDTO {
  @override
  final bool takePhoto;

  FakeLoginConfigurationDTO({required this.takePhoto});
}

void main() {
  late IBottomSheetService bottomSheetService;

  setUp(
    () {
      bottomSheetService = MockBottomSheetService();
    },
  );

  group(
    'ShowBottomSheetUsecase',
    () {
      test(
        'call test.',
        () async {
          IShowBottomSheetUsecase takePhotoConfigUsecase =
              ShowBottomSheetUsecase(
            bottomSheetService: bottomSheetService,
          );

          BuildContext context = MockBuildContext();
          List<Widget> content = [const Text('data')];
          Future<dynamic> showFuture = Future.value(true);

          when(
            () => bottomSheetService.show(
              content: content,
              context: context,
              userRootContext: false,
            ),
          ).thenAnswer((invocation) => showFuture);

          final res = takePhotoConfigUsecase.call(
            content: content,
            context: context,
            userRootContext: false,
          );
          expect(res, showFuture);

          verify(
            () => bottomSheetService.show(
              content: content,
              context: context,
              userRootContext: false,
            ),
          ).called(1);

          verifyNoMoreInteractions(bottomSheetService);
        },
      );
    },
  );
}
