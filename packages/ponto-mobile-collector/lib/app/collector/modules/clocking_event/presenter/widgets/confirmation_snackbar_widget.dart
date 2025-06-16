import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../domain/usecase/get_receipt_usecase.dart';
import '../../domain/usecase/show_bottom_sheet_usecase.dart';

class ConfirmationSnackbarWidget {
  final IUtils _utils;
  final GetReceiptUsecase _getReceiptUsecase;
  final ShowBottomSheetUsecase _showBottomSheetUsecase;
  final BuildContext _context;

  ConfirmationSnackbarWidget({
    required IUtils utils,
    required GetReceiptUsecase getReceiptUsecase,
    required BuildContext context,
    required ShowBottomSheetUsecase showBottomSheetUsecase,
  })  : _utils = utils,
        _getReceiptUsecase = getReceiptUsecase,
        _context = context,
        _showBottomSheetUsecase = showBottomSheetUsecase;

  Future<void> show({
    required ClockingEvent clockingEvent,
    bool hideActionButton = false,
    Duration? duration,
  }) async {
    ShowSnackbarMessageState message = ShowSnackbarMessageState(
      clockingEvent: clockingEvent,
      content: generateSuccessMessage(
        clockingEvent: clockingEvent,
        context: _context,
        utils: _utils,
      ),
    );

    await showSnackbarMessage(
      messageState: message,
      hideActionButton: hideActionButton,
      duration: duration,
    );
  }

  Future<void> showSnackbarMessage({
    required ShowSnackbarMessageState messageState,
    bool hideActionButton = false,
    Duration? duration,
  }) async {
    ScaffoldMessenger.of(_context).showSnackBar(
      SeniorSnackBar.success(
        duration: duration,
        message: messageState.content,
        action: hideActionButton
            ? null
            : SeniorSnackBarAction(
                label: CollectorLocalizations.of(_context).toView,
                onPressed: () {
                  _showBottomSheetUsecase.call(
                    context: _context,
                    content: [
                      ClockingEventReceiptWidget(
                        receipt: _getReceiptUsecase.call(
                          clockingEvent: messageState.clockingEvent,
                          locale:
                              CollectorLocalizations.of(_context).localeName,
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  String generateSuccessMessage({
    required ClockingEvent clockingEvent,
    required BuildContext context,
    required IUtils utils,
  }) {
    final localeName = CollectorLocalizations.of(context).localeName;
    String confirmationMessage =
        CollectorLocalizations.of(context).successClockingEvent(
      utils.formatTime(
        dateTime: clockingEvent.getDateTimeEvent(),
        locale: localeName,
      ),
      DateFormat.yMd(localeName).format(clockingEvent.getDateTimeEvent()),
      clockingEvent.employeeName,
    );
    return confirmationMessage;
  }
}
