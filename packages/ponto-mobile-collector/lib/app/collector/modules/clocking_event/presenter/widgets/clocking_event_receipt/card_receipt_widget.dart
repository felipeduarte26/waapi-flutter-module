import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../domain/model/clocking_event_receipt_model.dart';
import 'item_text_widget.dart';

class CardReceiptWidget extends StatelessWidget {
  final ClockingEventReceiptModel receipt;

  const CardReceiptWidget({
    super.key,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    SizedBox spaceBox = const SizedBox(
      height: 8,
    );

    return Column(
      children: [
        Row(
          children: [
            SeniorText.cta(
              color: SeniorColors.neutralColor800,
              CollectorLocalizations.of(context).appointmentReceipt,
            ),
          ],
        ),
        Container(
          height: SeniorSpacing.xsmall,
        ),
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            color: isDark ? SeniorColors.grayscale70 : SeniorColors.manchesterColorYellow100,
            padding: const EdgeInsets.all(SeniorSpacing.normal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemTextWidget(
                      title: CollectorLocalizations.of(context).cardReceiptData,
                      content: receipt.date,
                    ),
                    ItemTextWidget(
                      title: CollectorLocalizations.of(context).cardReceiptTime,
                      content: receipt.time,
                    ),
                    ItemTextWidget(
                      title: CollectorLocalizations.of(context).cardReceiptZone,
                      content: receipt.timeZone,
                    ),
                  ],
                ),
                spaceBox,
                ItemTextWidget(
                  title: CollectorLocalizations.of(context).cardReceiptEmployeeName,
                  content: receipt.employeeName,
                ),
                spaceBox,
                Row(
                  children: [
                    ItemTextWidget(
                      title: CollectorLocalizations.of(context).cardReceiptEmployeeCPF,
                      content: receipt.cpf,
                    ),
                  ],
                ),
                spaceBox,
                ItemTextWidget(
                  title: CollectorLocalizations.of(context).cardReceiptCompanyName,
                  content: receipt.companyName,
                ),
                spaceBox,
                Row(
                  children: [
                    ItemTextWidget(
                      title: CollectorLocalizations.of(context).cardReceiptCompanyCNPJ,
                      content: receipt.cnpj,
                    ),
                  ],
                ),
                spaceBox,
                ItemTextWidget(
                  title: CollectorLocalizations.of(context).cardReceiptIdentification,
                  content: receipt.receiptIdentifier,
                ),
                spaceBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'packages/ponto_mobile_collector/assets/icons/senior_label_ico.svg',
                      semanticsLabel: 'Senior',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    int clipHeight = 6;
    double curXPos = 0.0;
    double curYPos = 0.0;
    double increment = size.width / 60;
    bool key = false;

    path.lineTo(0, 0);

    while (curXPos < size.width) {
      key = !key;
      curXPos += increment;
      curYPos = key ? curYPos + clipHeight : curYPos - clipHeight;
      path.lineTo(curXPos, curYPos);
    }

    curXPos = size.width;
    curYPos = size.height;
    path.lineTo(curXPos, curYPos);
    key = true;

    while (curXPos > 0) {
      key = !key;
      curXPos -= increment;
      curYPos = key ? curYPos + clipHeight : curYPos - clipHeight;
      path.lineTo(curXPos, curYPos);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
