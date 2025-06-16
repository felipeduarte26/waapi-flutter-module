import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/collector_camera/collector_camera_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/enums/face_registration_status_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_registration/face_registration_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/face_registration_screen.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/feedback_screen.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_pt.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockFaceRegistrationCubit extends MockBloc<FaceRegistrationCubit, FaceRegistrationState>
    implements FaceRegistrationCubit {}

class MockCollectorCameraCubit extends MockBloc<CollectorCameraCubit, CollectorCameraState>
    implements CollectorCameraCubit {}

class BottomSheetServiceMock extends Mock implements IBottomSheetService {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockNavigatorService extends Mock implements NavigatorService {}

void main() {
  String? employeeIdSelected;
  String tHomePath = '/homePath';
  String tHomeScreen = 'tHomeScreen';
  String tFacialRecognitionScreen = 'tFacialRecognitionScreen';
  String contentScreen = 'contentScreen';
  late FaceRegistrationCubit faceRegistrationCubit;
  late CollectorCameraCubit collectorCameraCubit;
  late IBottomSheetService bottomSheetService;
  late Widget widget;
  late NavigatorService navigatorService;

  CollectorLocalizationsPt localizationsPt = CollectorLocalizationsPt();

  Widget getWidget(Widget widget, {bool isCustom = false}) {
    return SeniorDesignSystem(
      theme: isCustom
          ? SENIOR_LIGHT_THEME.copyWith(themeType: ThemeType.custom, primaryColor: Colors.red)
          : SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        routes: {
          '/${FacialRecognitionRoutes.registrationFull}': (context) => Text(tFacialRecognitionScreen),
          tHomePath: (context) => Text(tHomeScreen),
        },
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  setUp(() {
    faceRegistrationCubit = MockFaceRegistrationCubit();
    collectorCameraCubit = MockCollectorCameraCubit();
    bottomSheetService = BottomSheetServiceMock();
    navigatorService = MockNavigatorService();

    when(
      () => faceRegistrationCubit.checkInformation(employeeIdSelected),
    ).thenAnswer((_) async => {});

    when(() => collectorCameraCubit.camera).thenReturn(0);

    widget = getWidget(
      FaceRegistrationScreen(
        faceRegistrationCubit: faceRegistrationCubit,
        navigatorService: navigatorService,
        collectorCameraCubit: collectorCameraCubit,
        content: Text(contentScreen),
        bottomSheetService: bottomSheetService,
        homePath: tHomePath,
        test: true,
      ),
    );
  });

  group('FaceRegistrationScreen', () {
    testWidgets('pop test', (tester) async {
      registerFallbackValue(FakeBuildContext());
      registerFallbackValue([const Text('data')]);

      when(() => faceRegistrationCubit.state).thenReturn(FaceCaptureInProgress());

      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());

      when(
        () => bottomSheetService.show(
          context: any(named: 'context'),
          content: any(named: 'content'),
        ),
      ).thenAnswer((_) async => {});

      final widgetTest = getWidget(
        widget,
      );

      await tester.pumpWidget(widgetTest);

      Finder iconFinder = find.byIcon(FontAwesomeIcons.angleLeft);
      expect(iconFinder, findsOneWidget);
      await tester.tap(iconFinder);
      await tester.pumpAndSettle();

      expect(find.byIcon(FontAwesomeIcons.angleLeft), findsNothing);
    });

    testWidgets('show loading check information test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(FaceRegistrationCheckingInformationInProgress());

      await tester.pumpWidget(widget);
      final loadingFinder = find.byType(LoadingWidget);
      expect(loadingFinder, findsOneWidget);
    });

    testWidgets('show offline error test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(FaceRegistrationOffline());

      final widget = getWidget(
        FaceRegistrationScreen(
          navigatorService: navigatorService,
          faceRegistrationCubit: faceRegistrationCubit,
          collectorCameraCubit: collectorCameraCubit,
          bottomSheetService: bottomSheetService,
          homePath: tHomePath,
        ),
      );

      await tester.pumpWidget(widget);
      final feedbackScreenFinder = find.byType(FeedbackScreen);
      expect(feedbackScreenFinder, findsOneWidget);
      expect(find.text('Sem conexão com a internet'), findsOneWidget);
    });

    testWidgets('show content success test', (tester) async {
      String contentScreen = 'contentScreen';
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(FaceRegistrationInitial());

      final widget = getWidget(
        FaceRegistrationScreen(
          navigatorService: navigatorService,
          faceRegistrationCubit: faceRegistrationCubit,
          collectorCameraCubit: collectorCameraCubit,
          content: Text(contentScreen),
          bottomSheetService: bottomSheetService,
          homePath: tHomePath,
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text(contentScreen), findsOneWidget);
    });

    testWidgets('show content success test with custom theme', (tester) async {
      String contentScreen = 'contentScreen';
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(FaceRegistrationInitial());

      final widget = getWidget(
        FaceRegistrationScreen(
          navigatorService: navigatorService,
          faceRegistrationCubit: faceRegistrationCubit,
          collectorCameraCubit: collectorCameraCubit,
          content: Text(contentScreen),
          bottomSheetService: bottomSheetService,
          homePath: tHomePath,
        ),
        isCustom: true,
      );

      await tester.pumpWidget(widget);
      expect(find.text(contentScreen), findsOneWidget);
    });

    testWidgets('show person exists on facial recognition platform test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(PersonExistsOnFacialRecognitionPlatform());

      await tester.pumpWidget(widget);
      final feedbackScreenFinder = find.text('Rosto já cadastrado!');
      final buttonFinder = find.text('Voltar ao início');
      expect(feedbackScreenFinder, findsOneWidget);

      await tester.tap(buttonFinder);
    });

    testWidgets('show person non exists on facial recognition platform test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(PersonNotExistsOnFacialRecognitionPlatform());

      await tester.pumpWidget(widget);
      final feedbackScreenFinder = find.byType(InstructionsScreen);
      expect(feedbackScreenFinder, findsOneWidget);
    });

    testWidgets('show face registrarion success test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(FaceRegistrationSuccess());

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle(const Duration(seconds: 100));
      expect(find.text('Cadastro realizado com sucesso!'), findsOneWidget);

      final buttonFinder = find.text('Voltar ao início');
      await tester.tap(buttonFinder);
      expect(find.text('Voltar ao início'), findsOneWidget);
    });

    testWidgets('show face registration in progress test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(FaceRegistrationInProgress());

      await tester.pumpWidget(widget);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('show face registration face isnt visible test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.facesNotFoundInTheImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Rosto não detectado'), findsOneWidget);
      expect(
        find.text(
          'Nenhum rosto foi encontrado com aparecimento suficiente na imagem. Tente novamente.',
        ),
        findsOneWidget,
      );
    });
    testWidgets('show face registration low quality image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.poorQualityImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Imagem com baixa qualidade'), findsOneWidget);
      expect(
        find.text(
          'A imagem tem baixa resolução, ruído ou iluminação inadequada.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('show face registration VeryBlurryImage image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.veryBlurryImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusVeryBlurryImage),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusVeryBlurryImage),
        findsOneWidget,
      );
    });

    testWidgets('show face registration moreThanOneFaceFoundInTheImage image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.moreThanOneFaceFoundInTheImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusMoreThanOneFaceFoundInTheImage),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusMoreThanOneFaceFoundInTheImage),
        findsOneWidget,
      );
    });

    testWidgets('show face registration verySmallFaceInTheImage image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.verySmallFaceInTheImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusVerySmallFaceInTheImage),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusVerySmallFaceInTheImage),
        findsOneWidget,
      );
    });

    testWidgets('show face registration faceTooCloseToTheEdgeOfTheImage image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.faceTooCloseToTheEdgeOfTheImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusFaceTooCloseToTheEdgeOfTheImage),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusFaceTooCloseToTheEdgeOfTheImage),
        findsOneWidget,
      );
    });

    testWidgets('show face registration evidenceOfFraud image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.evidenceOfFraud,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusEvidenceOfFraud),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusEvidenceOfFraud),
        findsOneWidget,
      );
    });

    testWidgets('show face registration idsWithCloseImagesWereFound image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.idsWithCloseImagesWereFound,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusIdsWithCloseImagesWereFound),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusIdsWithCloseImagesWereFound),
        findsOneWidget,
      );
    });

    testWidgets('show face registration glassesDetectedOrTooMuchEyeShadow image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.glassesDetectedOrTooMuchEyeShadow,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusGlassesDetectedOrTooMuchEyeShadow),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusGlassesDetectedOrTooMuchEyeShadow),
        findsOneWidget,
      );
    });

    testWidgets('show face registration lowConfidenceFaceDetection image', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationAlert(
          FaceRegistrationStatusEnum.lowConfidenceFaceDetection,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text(localizationsPt.facialTitleStatusLowConfidenceFaceDetection),
        findsOneWidget,
      );
      expect(
        find.text(localizationsPt.facialMsgStatusLowConfidenceFaceDetection),
        findsOneWidget,
      );
    });

    testWidgets('show face registration failure test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationFailure(
          FaceRegistrationStatusEnum.errorReadingTheImage,
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Não foi possível analisar a foto'), findsOneWidget);
    });

    testWidgets(
        'show face registration failure'
        ' and go back to configuration test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationFailure(
          FaceRegistrationStatusEnum.externalIdIsAlreadyInUse,
        ),
      );

      when(
        () => faceRegistrationCubit.startFaceCapture(),
      ).thenAnswer((_) => Future(() => null));

      await tester.pumpWidget(widget);
      Finder buttonFinder = find.text('Tentar novamente');
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      verify(() => faceRegistrationCubit.startFaceCapture()).called(1);
    });

    testWidgets(
        'show face registration FaceRegistrationLowQualityPhoto'
        ' and go back to configuration test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationFailure(
          FaceRegistrationStatusEnum.poorQualityImage,
        ),
      );

      when(
        () => faceRegistrationCubit.startFaceCapture(),
      ).thenAnswer((_) => Future(() => null));

      await tester.pumpWidget(widget);
      Finder buttonFinder = find.text('Tentar novamente');
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      verify(() => faceRegistrationCubit.startFaceCapture()).called(1);
    });

    testWidgets(
        'show face registration FaceRegistrationFaceIsntVisible'
        ' and go back to configuration test', (tester) async {
      when(
        () => faceRegistrationCubit.state,
      ).thenReturn(
        FaceRegistrationFailure(
          FaceRegistrationStatusEnum.nonFrontalFace,
        ),
      );

      when(
        () => faceRegistrationCubit.startFaceCapture(),
      ).thenAnswer((_) => Future(() => null));

      await tester.pumpWidget(widget);
      Finder buttonFinder = find.text('Tentar novamente');
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      verify(() => faceRegistrationCubit.startFaceCapture()).called(1);
    });

    testWidgets('show face capture in progress test', (tester) async {
      registerFallbackValue(FakeBuildContext());
      registerFallbackValue([const Text('data')]);

      when(() => faceRegistrationCubit.state).thenReturn(FaceCaptureInProgress());

      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());

      when(
        () => bottomSheetService.show(
          context: any(named: 'context'),
          content: any(named: 'content'),
        ),
      ).thenAnswer((_) async => {});

      final widgetTest = getWidget(
        widget,
      );

      await tester.pumpWidget(widgetTest);
      expect(find.byType(CollectorCameraWidget), findsOneWidget);

      Finder infoIconFinder = find.byIcon(FontAwesomeIcons.circleInfo);
      expect(infoIconFinder, findsOneWidget);

      // await tester.tap(infoIconFinder);

      // verify(
      //   () => bottomSheetService.show(
      //     context: any(named: 'context'),
      //     content: any(named: 'content'),
      //   ),
      // );
    });

    testWidgets('show face capture in progress test facialTipsFacialRecognition ', (tester) async {
      when(() => faceRegistrationCubit.state).thenReturn(FaceCaptureInProgress());

      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());

      final widgetTest = getWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(410, 0)),
          child: widget,
        ),
      );

      await tester.pumpWidget(widgetTest);

      var circleInfoIconButton = find.byKey(const Key('circleInfoIconButton'));
      expect(circleInfoIconButton, findsOneWidget);
    });

    testWidgets('CapturedImage', (tester) async {
      when(() => faceRegistrationCubit.state).thenReturn(FaceCaptureInProgress());

      when(() => collectorCameraCubit.state).thenReturn(CapturedImage());

      when(() => collectorCameraCubit.image).thenReturn(List.empty());

      final widgetTest = getWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(410, 0)),
          child: widget,
        ),
      );

      await tester.pumpWidget(widgetTest);

      var circleInfoIconButton = find.byKey(const Key('circleInfoIconButton'));
      expect(circleInfoIconButton, findsOneWidget);
    });

    testWidgets('FaceRegistrationNoPermission ', (tester) async {
      when(() => faceRegistrationCubit.state).thenReturn(FaceRegistrationNoPermission());

      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());

      final widgetTest = getWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(410, 0)),
          child: widget,
        ),
      );

      await tester.pumpWidget(widgetTest);

      final feedbackScreenFinder = find.byType(FeedbackScreen);
      expect(feedbackScreenFinder, findsOneWidget);
      expect(
        find.text(
          'Por favor, contate o RH para verificar a permissão do seu usuário.',
        ),
        findsOneWidget,
      );
    });
  });
}
