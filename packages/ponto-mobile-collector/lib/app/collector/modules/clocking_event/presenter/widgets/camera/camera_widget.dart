import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/domain/enums/camera_type.dart';
import '../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../core/domain/services/session/isession_service.dart';
import '../../../../../core/infra/utils/iutils.dart';
import '../../../../../core/presenter/widgets/collector_camera/camera_overlay_widget.dart';
import '../../../../../core/presenter/widgets/collector_camera/collector_camera_widget.dart';
import '../../../../../core/presenter/widgets/collector_camera/cubit/collector_camera_cubit.dart';
import '../../../../../core/presenter/widgets/collector_camera/cubit/collector_camera_state.dart';

class CameraWidget extends StatefulWidget {
  final bool test;
  final CollectorCameraCubit _collectorCameraCubit;
  final ISessionService _sessionService;
  final IUtils _utils;
  final NavigatorService _navigatorService;

  const CameraWidget({
    super.key,
    this.test = false,
    required CollectorCameraCubit cameraCubit,
    required ISessionService sessionService,
    required IUtils utils,
    required NavigatorService navigatorService,
  })  : _sessionService = sessionService,
        _utils = utils,
        _collectorCameraCubit = cameraCubit,
        _navigatorService = navigatorService;

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  void dispose() {
    widget._collectorCameraCubit.closeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final String modalTitle =
        CollectorLocalizations.of(context).registerWithoutConfirm;
    final String modalContent =
        CollectorLocalizations.of(context).willRegisterWithoutPhoto;
    final String actionText =
        CollectorLocalizations.of(context).facialModalAlertBackButton;
    final String otherActionText =
        CollectorLocalizations.of(context).registerWithoutPhoto;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _showModal(
            modalTitle,
            modalContent,
            actionText,
            otherActionText,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SeniorColorfulHeaderStructure(
          hasTopPadding: false,
          title: SeniorText.label(
            CollectorLocalizations.of(context).facialPhotoCapture,
            color: Colors.white,
            darkColor: SeniorColors.grayscale5,
          ),
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
            ),
            iconSize: SeniorSpacing.small,
            onPressed: () => _showModal(
              modalTitle,
              modalContent,
              actionText,
              otherActionText,
            ),
          ),
          body: BlocConsumer<CollectorCameraCubit, CollectorCameraState>(
            bloc: widget._collectorCameraCubit,
            listener: (context, state) {
              if (state is CapturedImage) {
                if (widget._collectorCameraCubit.imageFile != null) {
                  _getImagePath(widget._collectorCameraCubit.imageFile!).then(
                    (value) {
                      widget._navigatorService.pop(value: value);
                    },
                  );
                } else {
                  return;
                }
              }
            },
            builder: (context, state) {
              return CameraOverlayWidget(
                enableToggleFlash: widget._collectorCameraCubit.camera == 0,
                onToggleFlash: () => widget._collectorCameraCubit.changeLight(),
                onToggleCamera: () =>
                    widget._collectorCameraCubit.changeCamera(),
                onCaptureImage: () async {
                  await widget._collectorCameraCubit.captureImage();
                },
                uiState: CameraOverlayState.initial,
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
        ),
      ),
    );
  }

  Future<bool> _showModal(
    String modalTitle,
    String modalContent,
    String actionText,
    String otherActionText,
  ) async {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: modalTitle,
          content: modalContent,
          defaultAction: SeniorModalAction(
            label: actionText,
            action: () {
              widget._navigatorService.pop();
            },
          ),
          otherAction: SeniorModalAction(
            label: otherActionText,
            action: () {
              widget._navigatorService.pop();
              widget._navigatorService.pop(value: '');
            },
          ),
        );
      },
    );
    return true;
  }

  Future<String> _getImagePath(XFile image) async {
    final String employeeId = widget._collectorCameraCubit.employeeId ??
        widget._sessionService.getEmployeeId();

    widget._collectorCameraCubit.employeeId = null;

    String filePath = await widget._utils.createPhotoPath(
      employeeId: employeeId,
      photoName: image.name,
      createDirectory: true,
    );

    await image.saveTo(filePath);

    log('CameraWidget: Foto capturada e salva em $filePath');
    return image.name;
  }
}
