// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/presenter/widgets/collector_camera/collector_camera_widget.dart';
import '../../domain/enums/face_registration_status_enum.dart';
import '../cubit/face_registration/face_registration_cubit.dart';
import '../widgets/instructions_bottom_sheet.dart';
import 'feedback_screen.dart';

class TitleSubtitle {
  final String title;
  final String subtitle;

  TitleSubtitle({
    required this.title,
    required this.subtitle,
  });
}

class FaceRegistrationScreen extends StatefulWidget {
  final bool test;
  final Widget? content;
  final CollectorCameraCubit _collectorCameraCubit;
  final FaceRegistrationCubit _faceRegistrationCubit;
  final IBottomSheetService bottomSheetService;
  final NavigatorService _navigatorService;
  final String homePath;
  final String? employeeIdSelected;

  const FaceRegistrationScreen({
    this.test = false,
    this.content,
    required CollectorCameraCubit collectorCameraCubit,
    required NavigatorService navigatorService,
    required FaceRegistrationCubit faceRegistrationCubit,
    required this.bottomSheetService,
    required this.homePath,
    super.key,
    this.employeeIdSelected,
  })  : _collectorCameraCubit = collectorCameraCubit,
        _faceRegistrationCubit = faceRegistrationCubit,
        _navigatorService = navigatorService;

  @override
  State<FaceRegistrationScreen> createState() => _FaceRegistrationScreenState();
}

class _FaceRegistrationScreenState extends State<FaceRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    widget._faceRegistrationCubit.setContext(context);
    widget._faceRegistrationCubit.checkInformation(widget.employeeIdSelected);
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();

    return BlocConsumer<FaceRegistrationCubit, FaceRegistrationState>(
      bloc: widget._faceRegistrationCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FaceRegistrationCheckingInformationInProgress) {
          return getLoadingWidget(
            CollectorLocalizations.of(context).facialCheckingInformation,
          );
        }

        if (state is FaceRegistrationNoPermission) {
          return FeedbackScreen(
            navigatorService: widget._navigatorService,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () => widget._faceRegistrationCubit.checkInformation(
                  widget.employeeIdSelected,
                ),
                fullWidth: true,
                style: SeniorButtonStyle(
                  backgroundColor: themeRepository.isCustomTheme()
                      ? themeRepository.theme.primaryColor
                      : SeniorColors.primaryColor600,
                ),
              ),
            ],
            feedbackType: FeedbackTypeEnum.alert,
            subtitle: CollectorLocalizations.of(context)
                .facialUserNoPermissionMessage,
            title:
                CollectorLocalizations.of(context).facialUserNoPermissionTitle,
          );
        }

        if (state is FaceRegistrationOffline) {
          return FeedbackScreen(
            navigatorService: widget._navigatorService,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () => widget._faceRegistrationCubit.checkInformation(
                  widget.employeeIdSelected,
                ),
                fullWidth: true,
                style: SeniorButtonStyle(
                  backgroundColor: themeRepository.isCustomTheme()
                      ? themeRepository.theme.primaryColor
                      : SeniorColors.primaryColor600,
                ),
              ),
            ],
            feedbackType: FeedbackTypeEnum.alert,
            subtitle: CollectorLocalizations.of(context)
                .facialRegistrationOnlineCheckConnection,
            title: CollectorLocalizations.of(context).facialLooksLikeAreOffline,
          );
        }

        if (state is PersonExistsOnFacialRecognitionPlatform) {
          return FeedbackScreen(
            navigatorService: widget._navigatorService,
            feedbackType: FeedbackTypeEnum.success,
            title:
                CollectorLocalizations.of(context).facialFaceAlreadyRegistered,
            subtitle: CollectorLocalizations.of(context)
                .facialRecognitionRegistrationAvailable,
            buttons: [ SeniorButton(
              label: CollectorLocalizations.of(context).facialBackStart,
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                widget.homePath,
                (route) => false,
              ),
              fullWidth: true,
              style: SeniorButtonStyle(
                backgroundColor: themeRepository.isCustomTheme()
                    ? themeRepository.theme.primaryColor
                    : SeniorColors.primaryColor600,
              ),
            ),
            ],
            buttonLabelAdditional:
                CollectorLocalizations.of(context).reRegister,
            onPressedAdditional: () =>
                widget._faceRegistrationCubit.restartRegistrationProcess(),
          );
        }

        if (state is PersonNotExistsOnFacialRecognitionPlatform) {
          return InstructionsScreen(
            startReconnaissanceCall: () =>
                widget._faceRegistrationCubit.startFaceCapture(),
          );
        }

        if (state is FaceRegistrationSuccess) {
          return FeedbackScreen(
            navigatorService: widget._navigatorService,
            feedbackType: FeedbackTypeEnum.success,
            title: CollectorLocalizations.of(context)
                .facialRegistrationCompletedSuccessfully,
            subtitle: CollectorLocalizations.of(context)
                .facialRecognitionRegistrationSoonAvailable,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialBackStart,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  widget.homePath,
                  (route) => false,
                ),
                fullWidth: true,
                style: SeniorButtonStyle(
                  backgroundColor: themeRepository.isCustomTheme()
                      ? themeRepository.theme.primaryColor
                      : SeniorColors.primaryColor600,
                ),
              ),
            ],
          );
        }

        if (state is FaceRegistrationInProgress) {
          return getLoadingWidget(
            CollectorLocalizations.of(context).facialPerformingPhotoAnalysis,
          );
        }

        if (state is FaceRegistrationFailure) {
          TitleSubtitle titleSubtitle =
              getSubtitleByCode(state.faceRegistrationStatusEnum);

          return FeedbackScreen(
            navigatorService: widget._navigatorService,
            feedbackType: FeedbackTypeEnum.error,
            title: titleSubtitle.title,
            subtitle: titleSubtitle.subtitle,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () =>
                    widget._faceRegistrationCubit.startFaceCapture(),
                fullWidth: true,
                style: SeniorButtonStyle(
                  backgroundColor: themeRepository.isCustomTheme()
                      ? themeRepository.theme.primaryColor
                      : SeniorColors.primaryColor600,
                ),
              ),
            ],
          );
        }

        if (state is FaceRegistrationAlert) {
          TitleSubtitle titleSubtitle =
              getSubtitleByCode(state.faceRegistrationStatusEnum);

          return FeedbackScreen(
            navigatorService: widget._navigatorService,
            feedbackType: FeedbackTypeEnum.alert,
            title: titleSubtitle.title,
            subtitle: titleSubtitle.subtitle,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () =>
                    widget._faceRegistrationCubit.startFaceCapture(),
                fullWidth: true,
                style: SeniorButtonStyle(
                  backgroundColor: themeRepository.isCustomTheme()
                      ? themeRepository.theme.primaryColor
                      : SeniorColors.primaryColor600,
                ),
              ),
            ],
          );
        }

        if (state is FaceCaptureInProgress) {
          return SeniorColorfulHeaderStructure(
            hasTopPadding: false,
            actions: [
              IconButton(
                key: const Key('circleInfoIconButton'),
                onPressed: () {
                  widget.bottomSheetService.show(
                    context: context,
                    content: [
                      const InstructionsBottonSheet(),
                    ],
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.circleInfo,
                  size: SeniorIconSize.small,
                  color:
                      isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
                ),
              ),
            ],
            title: SeniorText.label(
              CollectorLocalizations.of(context).facialPhotoCapture,
              color: Colors.white,
              darkColor: SeniorColors.grayscale5,
            ),
            leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.angleLeft,
                color:
                    isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
              ),
              iconSize: SeniorSpacing.small,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            body: BlocConsumer<CollectorCameraCubit, CollectorCameraState>(
              bloc: widget._collectorCameraCubit,
              listener: (context, state) {
                if (state is CapturedImage &&
                    widget._collectorCameraCubit.image != null) {
                  String imageBase64 =
                      base64Encode(widget._collectorCameraCubit.image!);
                  widget._faceRegistrationCubit.registerFace(imageBase64);
                }
              },
              builder: (context, state) {
                return CameraOverlayWidget(
                  enableToggleFlash: widget._collectorCameraCubit.camera == 0,
                  onToggleFlash: () =>
                      widget._collectorCameraCubit.changeLight(),
                  onToggleCamera: () =>
                      widget._collectorCameraCubit.changeCamera(),
                  onCaptureImage: () =>
                      widget._collectorCameraCubit.captureImage(),
                  uiState: CameraOverlayState.initial,
                  ellipseHeightCenterPosition: 0.9,
                  cameraType: CameraType.photoCapture,
                  child: CollectorCameraWidget(
                    isMockForTest: widget.test,
                    imagePreviewTest: widget.test
                        ? SeniorText.label(
                            CollectorLocalizations.of(context).appTitle,
                          )
                        : null,
                    cameraCubit: widget._collectorCameraCubit,
                  ),
                );
              },
            ),
          );
        }

        return SeniorColorfulHeaderStructure(
          hideLeading: false,
          hasTopPadding: false,
          title: const SizedBox(),
          body: widget.content ?? const SizedBox(),
        );
      },
    );
  }

  TitleSubtitle getSubtitleByCode(
    FaceRegistrationStatusEnum faceRegistrationStatusEnum,
  ) {
    switch (faceRegistrationStatusEnum) {
      case FaceRegistrationStatusEnum.veryBlurryImage:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusVeryBlurryImage,
          subtitle:
              CollectorLocalizations.of(context).facialMsgStatusVeryBlurryImage,
        );
      case FaceRegistrationStatusEnum.moreThanOneFaceFoundInTheImage:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusMoreThanOneFaceFoundInTheImage,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusMoreThanOneFaceFoundInTheImage,
        );
      case FaceRegistrationStatusEnum.facesNotFoundInTheImage:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusFacesNotFoundInTheImage,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusFacesNotFoundInTheImage,
        );
      case FaceRegistrationStatusEnum.nonFrontalFace:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusNonFrontalFace,
          subtitle:
              CollectorLocalizations.of(context).facialMsgStatusNonFrontalFace,
        );
      case FaceRegistrationStatusEnum.poorQualityImage:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusPoorQualityImage,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusPoorQualityImage,
        );
      case FaceRegistrationStatusEnum.verySmallFaceInTheImage:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusVerySmallFaceInTheImage,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusVerySmallFaceInTheImage,
        );
      case FaceRegistrationStatusEnum.faceTooCloseToTheEdgeOfTheImage:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusFaceTooCloseToTheEdgeOfTheImage,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusFaceTooCloseToTheEdgeOfTheImage,
        );
      case FaceRegistrationStatusEnum.evidenceOfFraud:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusEvidenceOfFraud,
          subtitle:
              CollectorLocalizations.of(context).facialMsgStatusEvidenceOfFraud,
        );
      case FaceRegistrationStatusEnum.idsWithCloseImagesWereFound:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusIdsWithCloseImagesWereFound,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusIdsWithCloseImagesWereFound,
        );
      case FaceRegistrationStatusEnum.glassesDetectedOrTooMuchEyeShadow:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusGlassesDetectedOrTooMuchEyeShadow,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusGlassesDetectedOrTooMuchEyeShadow,
        );
      case FaceRegistrationStatusEnum.lowConfidenceFaceDetection:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context)
              .facialTitleStatusLowConfidenceFaceDetection,
          subtitle: CollectorLocalizations.of(context)
              .facialMsgStatusLowConfidenceFaceDetection,
        );
      case FaceRegistrationStatusEnum.errorReadingTheImage:
      case FaceRegistrationStatusEnum.externalIdCannotContainSpecialCharacters:
      case FaceRegistrationStatusEnum.personNotFound:
      case FaceRegistrationStatusEnum.imageNotFound:
      case FaceRegistrationStatusEnum.errorWhenDeletingThePerson:
      case FaceRegistrationStatusEnum.imageTooLarge:
      case FaceRegistrationStatusEnum.externalIdIsAlreadyInUse:
      case FaceRegistrationStatusEnum.unknownError:
        return TitleSubtitle(
          title: CollectorLocalizations.of(context).facialCouldNotanalyzePhoto,
          subtitle: CollectorLocalizations.of(context).facialTryAgainLater,
        );
    }
  }

  Widget getLoadingWidget(String message) {
    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        hideLeading: true,
        title: const SizedBox(),
        body: LoadingWidget(bottomLabel: message),
      ),
    );
  }
}
