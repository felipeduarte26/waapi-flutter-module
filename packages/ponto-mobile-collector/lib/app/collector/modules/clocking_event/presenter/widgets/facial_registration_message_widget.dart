import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../routes/collector_routes.dart';
import '../../domain/usecase/show_face_registration_message_usecase.dart';

class FacialRegistrationMessageWidget {
  final NavigatorService _navigatorService;
  final BuildContext _context;
  final ShowFaceRegistrationMessageUsecase _showFaceRegistrationMessageUsecase;

  FacialRegistrationMessageWidget({
    required NavigatorService navigatorService,
    required BuildContext context,
    required ShowFaceRegistrationMessageUsecase
        showFaceRegistrationMessageUsecase,
  })  : _navigatorService = navigatorService,
        _context = context,
        _showFaceRegistrationMessageUsecase =
            showFaceRegistrationMessageUsecase;

  Future<void> show({String? clockingEventUse}) async {
    final bool showFacialRegistrationMessage =
        await _showFaceRegistrationMessageUsecase.call(clockingEventUse);

    if (!showFacialRegistrationMessage) {
      return;
    }

    SeniorModal modal = SeniorModal(
      title: CollectorLocalizations.of(_context)
          .facialRecognitionRegistrationQuestion,
      content: CollectorLocalizations.of(_context)
          .facialRecognitionRegistrationInformation,
      otherAction: SeniorModalAction(
        label: CollectorLocalizations.of(_context).facialRegisterNow,
        action: () {
          _navigatorService.popAndPushNamed(
            route:
                '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}',
          );
        },
      ),
      defaultAction: SeniorModalAction(
        label: CollectorLocalizations.of(_context).close,
        action: () {
          _navigatorService.pop();
        },
      ),
    );

    await showDialog(
      context: _context,
      builder: (context) {
        return modal;
      },
    );
  }
}
