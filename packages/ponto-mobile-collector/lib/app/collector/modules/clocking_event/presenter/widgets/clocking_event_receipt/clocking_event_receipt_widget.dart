import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/presenter/widgets/clocking_event_receipt/employee_bottom_sheet_widget.dart';
import '../../../domain/model/clocking_event_receipt_model.dart';
import 'card_receipt_widget.dart';

/// Use this widget inside a SeniorBottomSheet
class ClockingEventReceiptWidget extends StatelessWidget {
  final ClockingEventReceiptModel receipt;
  final VoidCallback? onTapShareButton;

  const ClockingEventReceiptWidget({
    super.key,
    required this.receipt,
    this.onTapShareButton,
  });

  @override
  Widget build(BuildContext context) {
    return _getWidget(
      context,
    );
  }

  Widget _getWidget(
    BuildContext context,
  ) {
    return Column(
      children: [
        _getCard(receipt),
        EmployeeBottomSheetWidget(
          seniorButtons: [
            _getButtons(
              context,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getCard(
    ClockingEventReceiptModel clockingEventDto,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          CardReceiptWidget(
            receipt: clockingEventDto,
          ),
        ],
      ),
    );
  }

  Widget _getButtons(
    BuildContext context,
  ) {
    return Column(
      children: [
        SeniorButton.ghost(
          fullWidth: true,
          label: CollectorLocalizations.of(context).close,
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
