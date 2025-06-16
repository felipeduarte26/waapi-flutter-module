import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../enums/enum_status_vacation_staff_calendar.dart';
import 'vacation_status_widget.dart';

class VacationInformationStatus extends StatelessWidget {
  const VacationInformationStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
          right: SeniorSpacing.normal,
          bottom: SeniorSpacing.normal,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.h4(
                context.translate.staffVacationProgramming,
                color: SeniorColors.neutralColor800,
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorText.label(
                context.translate.displaysTheDaysWhenYourStaffProgrammingVacationsItIsDividedIntoFourCategories,
                color: SeniorColors.neutralColor800,
              ),
              const SizedBox(
                height: SeniorSpacing.xmedium,
              ),
              VacationStatusWidget(
                statusTitle: context.translate.pendingWithTheManager,
                statusVacation: EnumStatusVacationStaffCalendar.leaderReview,
                padding: EdgeInsets.zero,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: SeniorText.body(
                  context.translate.theEmployeeHasRequestedManagerApproval,
                  color: SeniorColors.neutralColor600,
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.xmedium,
              ),
              VacationStatusWidget(
                statusTitle: context.translate.pendingWithHR,
                statusVacation: EnumStatusVacationStaffCalendar.hrReview,
                padding: EdgeInsets.zero,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: SeniorText.body(
                  context.translate.theEmployeeHasRequestedCompanyHRApproval,
                  color: SeniorColors.neutralColor600,
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.xmedium,
              ),
              VacationStatusWidget(
                statusTitle: context.translate.scheduled,
                statusVacation: EnumStatusVacationStaffCalendar.scheduled,
                padding: EdgeInsets.zero,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: SeniorText.body(
                  context.translate.vacationRequestedAndApprovedButCalculationPaymentIsPending,
                  color: SeniorColors.neutralColor600,
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.xmedium,
              ),
              VacationStatusWidget(
                statusTitle: context.translate.calculated,
                statusVacation: EnumStatusVacationStaffCalendar.calculated,
                padding: EdgeInsets.zero,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: SeniorText.body(
                  context.translate.vacationHasBeenApprovedPaymentScheduledTheReceiptAvailableVerification,
                  color: SeniorColors.neutralColor600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
