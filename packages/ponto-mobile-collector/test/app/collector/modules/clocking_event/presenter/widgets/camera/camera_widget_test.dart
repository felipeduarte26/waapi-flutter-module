import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/collector_camera/collector_camera_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockCollectorCameraCubit
    extends MockBloc<CollectorCameraCubit, CollectorCameraState>
    implements CollectorCameraCubit {}

class MockSessionService extends Mock implements ISessionService {}

class MockUtils extends Mock implements IUtils {}

class MockNavigatorService extends Mock implements NavigatorService {}

class FakeXFile extends Mock implements XFile {}

void main() {
  late Widget widget;
  late CollectorCameraCubit cameraCubit;
  late ISessionService sessionService;
  late IUtils utils;
  late NavigatorService navigatorService;
  late XFile file = FakeXFile();
  const String tEmployeeId = 'tEmployeeId';

  Widget getWidget(Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          locale: const Locale('pt'),
          delegates: const [
            CollectorLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: widget,
        ),
      ),
    );
  }

  setUp(() {
    cameraCubit = MockCollectorCameraCubit();
    sessionService = MockSessionService();
    utils = MockUtils();
    navigatorService = MockNavigatorService();

    widget = CameraWidget(
      test: true,
      cameraCubit: cameraCubit,
      sessionService: sessionService,
      utils: utils,
      navigatorService: navigatorService,
    );

    when(() => cameraCubit.state).thenReturn(ReadyCamera());
    when(() => cameraCubit.camera).thenReturn(0);
    when(() => cameraCubit.imageFile).thenReturn(file);
    when(() => cameraCubit.closeCamera()).thenAnswer((_) async => {});
    when(() => file.name).thenReturn('image_name');
    when(() => file.saveTo(any())).thenAnswer((_) async => {});
    when(() => sessionService.getEmployeeId()).thenReturn(tEmployeeId);
    when(
      () => utils.createPhotoPath(
        employeeId: any(named: 'employeeId'),
        photoName: any(named: 'photoName'),
        createDirectory: true,
      ),
    ).thenAnswer((_) async => 'photoPath');
  });

  testWidgets('show Modal when user try to exit screen', (tester) async {
    final widgetTest = getWidget(widget);
    await tester.pumpWidget(widgetTest);

    Finder iconFinder = find.byIcon(FontAwesomeIcons.angleLeft);
    await tester.tap(iconFinder);
    await tester.pump();
    Finder modalFinder = find.byType(SeniorModal);

    expect(iconFinder, findsOneWidget);
    expect(
      modalFinder,
      findsOneWidget,
    );
  });

  testWidgets('show Camera widget in screen', (tester) async {
    final widgetTest = getWidget(widget);
    await tester.pumpWidget(widgetTest);

    Finder screenTitleFinder = find.text('Captura de foto');
    Finder cameraOverlayFinder = find.byType(CameraOverlayWidget);
    Finder cameraFinder = find.byType(CollectorCameraWidget);

    expect(screenTitleFinder, findsOneWidget);
    expect(cameraOverlayFinder, findsOneWidget);
    expect(cameraFinder, findsOneWidget);
  });

  testWidgets('user capture image test', (tester) async {
    whenListen(
      cameraCubit,
      Stream.fromIterable([
        CapturedImage(),
      ]),
    );

    final widgetTest = getWidget(widget);
    await tester.pumpWidget(widgetTest);

    verify(() => cameraCubit.imageFile).called(2);
    verify(() => file.name).called(2);
    verify(() => file.saveTo(any())).called(1);
    verify(() => sessionService.getEmployeeId()).called(1);
    verify(
      () => utils.createPhotoPath(
        employeeId: any(named: 'employeeId'),
        photoName: any(named: 'photoName'),
        createDirectory: true,
      ),
    ).called(1);

    verifyNoMoreInteractions(file);
    verifyNoMoreInteractions(sessionService);
    verifyNoMoreInteractions(utils);
  });
}
