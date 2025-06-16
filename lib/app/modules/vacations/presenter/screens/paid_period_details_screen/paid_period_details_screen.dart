import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_date_period_card_widget.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/vacations_routes.dart';
import '../../blocs/vacations_bloc/vacations_bloc.dart';
import '../../blocs/vacations_bloc/vacations_state.dart';
import '../../widgets/vacation_receipt_card_widget.dart';

class PaidPeriodDetailsScreen extends StatefulWidget {
  final String vacationPeriodId;
  final String employeeId;

  const PaidPeriodDetailsScreen({
    Key? key,
    required this.vacationPeriodId,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<PaidPeriodDetailsScreen> createState() {
    return _PaidPeriodDetailsScreenState();
  }
}

class _PaidPeriodDetailsScreenState extends State<PaidPeriodDetailsScreen> {
  late VacationsBloc _vacationsBloc;

  @override
  void initState() {
    super.initState();
    _vacationsBloc = Modular.get<VacationsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.paidPeriodDetails,
        body: BlocBuilder<VacationsBloc, VacationsState>(
          bloc: _vacationsBloc,
          builder: (_, state) {
            if (state is LoadingVacationsState) {
              return Container(
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
                alignment: Alignment.topCenter,
                child: const WaapiLoadingWidget(
                  key: Key('vacations-paid_periods_details-loading_indicator'),
                ),
              );
            }

            final vacation = state.vacations!.firstWhere(
              (vacation) => vacation.vacationPeriodId == widget.vacationPeriodId,
            );

            if (vacation.vacationReceipts == null || vacation.vacationReceipts!.isEmpty) {
              return EmptyStateWidget(
                key: const Key('vacations-paid_periods_details-error_state'),
                title: context.translate.errorGetVacationReceipt,
                subTitle: context.translate.errorGetVacationReceiptDescription,
                imagePath: AssetsPath.vacationErrorState,
              );
            }

            var listItemIndex = 0;
            var vacationDetails = <Widget>[];

            vacationDetails.add(
              WaapiDatePeriodCardWidget(
                key: const Key('vacations-paid_periods_details-header'),
                startDate: vacation.startDate!,
                endDate: vacation.endDate!,
                title: context.translate.vacationReceiptPeriod,
                padding: const EdgeInsets.only(
                  top: SeniorSpacing.normal,
                ),
              ),
            );

            if (vacation.vacationReceipts != null && vacation.vacationReceipts!.isNotEmpty) {
              final vacationReceipts = vacation.vacationReceipts!.map(
                (vacationReceipt) {
                  return VacationReceiptCardWidget(
                    key: Key('vacations-paid_periods_details-card-$listItemIndex++'),
                    vacationReceiptEntity: vacationReceipt,
                    showActionIcon: true,
                    onTap: () {
                      Modular.to.pushNamed(
                        VacationsRoutes.requestVacationDetailsScreenInitialRoute,
                        arguments: {
                          'vacationDetails': vacationReceipt,
                          'employeeId': widget.employeeId,
                        },
                      );
                    },
                  );
                },
              ).toList();
              vacationDetails.addAll(vacationReceipts);
            }

            return Scrollbar(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal + context.bottomSize,
                ),
                separatorBuilder: (_, __) => const SizedBox(
                  height: SeniorSpacing.normal,
                ),
                key: const Key('vacations-paid_periods_details-list'),
                itemCount: vacationDetails.length,
                itemBuilder: (_, index) => vacationDetails[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
