import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../../blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../string_formatters/enum_salary_type_string_formatter.dart';
import '../../string_formatters/salary_data_formatter.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SalaryScreen> createState() {
    return _SalaryScreenState();
  }
}

class _SalaryScreenState extends State<SalaryScreen> {
  late ContractEmployeeBloc _contractEmployeeBloc;

  @override
  void initState() {
    super.initState();
    _contractEmployeeBloc = Modular.get<ProfileMenuScreenBloc>().contractEmployeeBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.profileSalaryInformation,
        hasTopPadding: false,
        body: BlocBuilder<ContractEmployeeBloc, ContractEmployeeState>(
          bloc: _contractEmployeeBloc,
          builder: (_, state) {
            final salaryData = state.contractEmployeeEntity!.salary;

            return Scrollbar(
              child: ListView(
                padding: EdgeInsets.zero,
                key: const Key('profile-salary_screen-listview'),
                children: [
                  if (salaryData != null && salaryData.salaryValue != null)
                    SeniorContactBookItem(
                      key: const Key('profile-salary_screen-salary_item-salary_value'),
                      title: context.translate.salaryCurrent,
                      items: [
                        SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: salaryData.currencyType,
                          salary: salaryData.salaryValue!,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (salaryData != null && salaryData.spendingMoney != null)
                    SeniorContactBookItem(
                      key: const Key('profile-salary_screen-salary_item-spending_money'),
                      title: context.translate.salaryComplement,
                      items: [
                        SalaryDataFormatter.salaryFormatter(
                          currencyTypeEnum: salaryData.currencyType,
                          salary: salaryData.spendingMoney!,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (salaryData != null && salaryData.salaryType != null)
                    SeniorContactBookItem(
                      key: const Key('profile-salary_screen-salary_item-salary_type'),
                      title: context.translate.salaryType,
                      items: [
                        EnumSalaryTypeStringFormatter.getEnumSalaryTypeString(
                          salaryTypeEnum: salaryData.salaryType!,
                          appLocalizations: context.translate,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (salaryData != null && salaryData.salaryUpdateDate != null)
                    SeniorContactBookItem(
                      key: const Key('profile-salary_screen-salary_item-salary_update_date'),
                      title: context.translate.salaryLastAdjustmentDate,
                      items: [
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: salaryData.salaryUpdateDate!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (salaryData != null && salaryData.insalubrityPremium != null)
                    SeniorContactBookItem(
                      key: const Key('profile-salary_screen-salary_item-insalubrity_premium'),
                      title: context.translate.salaryInsalubrityPercentage,
                      items: [
                        SalaryDataFormatter.percentageFormat(
                          value: salaryData.insalubrityPremium!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (salaryData != null && salaryData.riskPremium != null)
                    SeniorContactBookItem(
                      key: const Key('profile-salary_screen-salary_item-risk_premium'),
                      title: context.translate.salaryHazardPercent,
                      items: [
                        SalaryDataFormatter.percentageFormat(
                          value: salaryData.riskPremium!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  SizedBox(
                    height: context.bottomSize,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
