import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/collector_camera/request_camera_permissions_modal_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_button/components/components.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

class MockPermissionService extends Mock implements IPermissionService {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockIFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

void main() {
  late IPermissionService permissionService;
  late NavigatorService navigatorService;
  late RequestCameraPermissionsModalWidget requestCameraPermissionsModalWidget;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  bool clickReturn = false;

  setUp(() {
    navigatorService = MockNavigatorService();
    permissionService = MockPermissionService();
    faceRecognitionSdkAuthenticationService =
        MockIFaceRecognitionSdkAuthenticationService();

    requestCameraPermissionsModalWidget = RequestCameraPermissionsModalWidget(
      permissionService: permissionService,
      navigatorService: navigatorService,
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
    );
  });

  Widget getWidget() {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return SeniorButtonPrimary(
                  label: 'showDialog',
                  onPressed: () async {
                    requestCameraPermissionsModalWidget.setContext(
                      context,
                    );
                    clickReturn = await requestCameraPermissionsModalWidget
                        .checkPermission();
                    log('$clickReturn');
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  group('EmployeeItemWidget', () {
    test('Permission isGranted after request', () async {
      when(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.granted);

      var checkPermission =
          await requestCameraPermissionsModalWidget.checkPermission();

      expect(checkPermission, true);
    });

    test('Permission permanentlyDenied after request', () async {
      when(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.denied);

      when(
        () =>
            permissionService.request(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

      var checkPermission =
          await requestCameraPermissionsModalWidget.checkPermission();

      expect(checkPermission, false);
    });

     testWidgets('show camera message permission test', (tester) async {
      when(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

      when(
        () => faceRecognitionSdkAuthenticationService.initialize(),
      ).thenAnswer((_) async => {});

      await tester.binding.setSurfaceSize(const Size(1000, 1600));
      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Para utilizar o reconhecimento facial e captura de foto após marcação, é necessário permitir acesso à câmera do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.',
        ),
        findsOneWidget,
      );
      expect(find.text('Permissões'), findsOneWidget);

      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();

      verify(() => navigatorService.pop()).called(1);
      verify(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).called(2);
    });

    testWidgets('Open system settings test', (tester) async {
      when(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

      when(() => permissionService.openSystemAppSettings())
          .thenAnswer((_) async => true);

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Permissões'));

      verify(() => permissionService.openSystemAppSettings()).called(1);
    });
  });
}
