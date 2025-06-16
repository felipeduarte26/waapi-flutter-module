import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../profile/presenter/screens/personal_documents_screen/widgets/title_card_widget.dart';
import '../../../../enums/enum_status_vacation_staff_calendar.dart';

class VacationStatusWidget extends StatelessWidget {
  final String statusTitle;
  final EnumStatusVacationStaffCalendar statusVacation;
  final Map<String, String>? vacationDetails;
  final EdgeInsets? padding;

  const VacationStatusWidget({
    super.key,
    required this.statusTitle,
    required this.statusVacation,
    this.vacationDetails,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: SeniorSpacing.normal,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleCardWidget(
            seniorTypography: SeniorTypography.label(
              color: SeniorColors.neutralColor800,
            ),
            isCopyButtonVisible: false,
            cardTitle: statusTitle,
            leftIconBuild: SeniorClipPatch(
              form: _getForm(
                statusVacation: statusVacation,
              ),
              heightSize: SeniorSpacing.normal,
              widthSize: SeniorSpacing.normal,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final nameEmployeer = vacationDetails!.keys.elementAt(index);
              final dateVacation = vacationDetails!.values.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SeniorText.body(
                    nameEmployeer,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xxsmall,
                  ),
                  SeniorText.small(
                    dateVacation,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xsmall,
                  ),
                ],
              );
            },
            itemCount: vacationDetails?.length ?? 0,
          ),
        ],
      ),
    );
  }

  SeniorFormsEnum _getForm({required EnumStatusVacationStaffCalendar statusVacation}) {
    switch (statusVacation) {
      case EnumStatusVacationStaffCalendar.hrReview:
        return SeniorFormsEnum.TRIANGLE;
      case EnumStatusVacationStaffCalendar.scheduled:
        return SeniorFormsEnum.TRIANGLE_DOWN;
      case EnumStatusVacationStaffCalendar.calculated:
        return SeniorFormsEnum.CIRCLE;
      case EnumStatusVacationStaffCalendar.leaderReview:
        return SeniorFormsEnum.SQUARE;
    }
  }
}
