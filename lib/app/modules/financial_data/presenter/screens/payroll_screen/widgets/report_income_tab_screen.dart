import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/file_helper.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/attachment_routes.dart';
import '../../../bloc/earnings_report_bloc/earnings_report_bloc.dart';
import '../../../bloc/earnings_report_bloc/earnings_report_event.dart';
import '../../../bloc/earnings_report_bloc/earnings_report_state.dart';
import 'report_income_card_widget.dart';

class ReportIncomeTabScreen extends StatefulWidget {
  final String employerName;
  final String registerNumber;
  final int companyNumber;

  const ReportIncomeTabScreen({
    super.key,
    required this.employerName,
    required this.registerNumber,
    required this.companyNumber,
  });

  @override
  State<ReportIncomeTabScreen> createState() => _ReportIncomeTabScreenState();
}

class _ReportIncomeTabScreenState extends State<ReportIncomeTabScreen> {
  late final EarningsReportBloc _earningsReportBloc;

  @override
  void initState() {
    super.initState();
    _earningsReportBloc = Modular.get<EarningsReportBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return BlocConsumer<EarningsReportBloc, EarningsReportState>(
      bloc: _earningsReportBloc,
      listener: (context, state) async {
        if (state is LoadedEarningsReportState) {
          final fileName = context.translate.earningsReport;

          final fileToShare = await FileHelper.bytesToFile(
            bytes: state.pdf,
            fileName: '${fileName.replaceAll('/', '-')}.pdf',
          );

          await Modular.to.pushNamed(
            AttachmentRoutes.attachmentPdfScreenInitialRoute,
            arguments: {
              'filePath': fileToShare.path,
              'title': fileName,
              'pdfErrorAnalytics': AnalyticsEventEnum.earningsReportError,
              'pdfSharedAnalytics': AnalyticsEventEnum.earningsReportShared,
            },
          );
        }
      },
      builder: (context, state) {
        var selectedYear = 0;
        if (state is LoadingEarningsReportState) {
          return const WaapiLoadingWidget();
        }

        if (state is ErrorEarningsReportState) {
          return EmptyStateWidget(
            title: context.translate.incomeReportErrorTitle,
            subTitle: context.translate.financialDataErrorDescription,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  label: context.translate.tryAgain,
                  fullWidth: true,
                  onPressed: () {
                    getEarningsReport(
                      year: selectedYear,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SeniorSpacing.normal),
                child: SeniorButton.ghost(
                  label: context.translate.back,
                  fullWidth: true,
                  onPressed: () {
                    _earningsReportBloc.add(
                      ResetEarningsReportEvent(),
                    );
                  },
                ),
              ),
            ],
            imagePath: AssetsPath.generalErrorState,
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: SeniorText.cta(
                context.translate.earningsReport,
                color: SeniorColors.neutralColor800,
              ),
            ),
            SeniorText.label(
              context.translate.currentStatement,
              color: SeniorColors.neutralColor800,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.xsmall,
                bottom: SeniorSpacing.normal,
              ),
              child: ReportIncomeCardWidget(
                year: year - 1,
                employerName: widget.employerName,
                onTap: () {
                  selectedYear = year - 1;
                  getEarningsReport(
                    year: selectedYear,
                  );
                },
              ),
            ),
            SeniorText.label(
              context.translate.previousStatements,
              color: SeniorColors.neutralColor800,
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            ReportIncomeCardWidget(
              year: year - 2,
              employerName: widget.employerName,
              onTap: () {
                selectedYear = year - 2;
                getEarningsReport(
                  year: selectedYear,
                );
              },
            ),
            const SizedBox(
              height: SeniorSpacing.normal,
            ),
            ReportIncomeCardWidget(
              year: year - 3,
              employerName: widget.employerName,
              onTap: () {
                selectedYear = year - 3;
                getEarningsReport(
                  year: selectedYear,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void getEarningsReport({required int year}) {
    _earningsReportBloc.add(
      GetEarningsReportEvent(
        registerNumber: widget.registerNumber,
        companyNumber: widget.companyNumber,
        year: year,
      ),
    );
  }
}
