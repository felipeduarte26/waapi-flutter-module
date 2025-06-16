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
import '../../string_formatters/address_formatter.dart';
import '../../string_formatters/enum_address_string_formatter.dart';
import '../../string_formatters/enum_employee_situation_string_formatter.dart';
import '../../string_formatters/enum_employment_relationship_string_formatter.dart';
import '../../string_formatters/enum_relationship_string_formatter.dart';
import '../../string_formatters/enum_stability_type_string_formatter.dart';
import '../../string_formatters/zip_code_formatter.dart';

class EmploymentContractScreen extends StatefulWidget {
  const EmploymentContractScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmploymentContractScreen> createState() {
    return _EmploymentContractScreenState();
  }
}

class _EmploymentContractScreenState extends State<EmploymentContractScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.profileEmploymentContract,
        body: BlocBuilder<ContractEmployeeBloc, ContractEmployeeState>(
          bloc: Modular.get<ContractEmployeeBloc>(),
          builder: (_, state) {
            final contractEmployee = state.contractEmployeeEntity!;

            return Scrollbar(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  if (contractEmployee.situation != null)
                    SeniorContactBookItem(
                      title: context.translate.contractSituation,
                      items: [
                        EnumEmployeeSituationStringFormatter.getEmployeeSituation(
                          employeeSituationEnum: contractEmployee.situation!,
                          appLocalizations: context.translate,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.employeeType != null && contractEmployee.relationshipType != null)
                    SeniorContactBookItem(
                      title: context.translate.contractType,
                      items: [
                        '${contractEmployee.employeeType} - ${EnumRelationshipStringFormatter.getRelationshipString(
                          relationshipTypeEnum: contractEmployee.relationshipType!,
                          appLocalizations: context.translate,
                        )}',
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.leaveReason != null)
                    SeniorContactBookItem(
                      title: context.translate.reason,
                      items: [
                        contractEmployee.leaveReason!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.leaveEstimatedEndDate != null)
                    SeniorContactBookItem(
                      title: context.translate.expectedEndDate,
                      items: [
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: contractEmployee.leaveEstimatedEndDate!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.hireDate != null)
                    SeniorContactBookItem(
                      title: context.translate.admissionDate,
                      items: [
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: contractEmployee.hireDate!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.registerNumber != null && contractEmployee.registerNumber!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.register,
                      items: [
                        contractEmployee.registerNumber!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.registrationNumber != null && contractEmployee.registrationNumber! > 0)
                    SeniorContactBookItem(
                      title: context.translate.registerForm,
                      items: [
                        contractEmployee.registrationNumber!.toString(),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.stabilityReason != null)
                    SeniorContactBookItem(
                      title: context.translate.temporaryStability,
                      items: [
                        EnumStabilityTypeStringFormatter.getStabilityType(
                          stabilityTypeEnum: contractEmployee.stabilityReason!,
                          appLocalizations: context.translate,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.stabilityEndDate != null)
                    SeniorContactBookItem(
                      title: context.translate.stabilityEndDate,
                      items: [
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: contractEmployee.stabilityEndDate!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.jobPositionName != null && contractEmployee.jobPositionName!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.job,
                      items: [
                        contractEmployee.jobPositionName!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.cboCode != null && contractEmployee.cboCode!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.cboJobCode,
                      items: [
                        contractEmployee.cboCode!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.departmentName != null && contractEmployee.departmentName!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.department,
                      items: [
                        contractEmployee.departmentName!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.costCenterName != null && contractEmployee.costCenterName!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.costCenter,
                      items: [
                        contractEmployee.costCenterName!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.workshiftName != null && contractEmployee.workshiftName!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.workSchedule,
                      items: [
                        contractEmployee.workshiftName!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.employmentRelationship != null)
                    SeniorContactBookItem(
                      title: context.translate.employmentRelationship,
                      items: [
                        EnumEmploymentRelationshipStringFormatter.getEmploymentRelationship(
                          employmentRelationshipEnum: contractEmployee.employmentRelationship!,
                          appLocalizations: context.translate,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.workstationName != null && contractEmployee.workstationName!.isNotEmpty)
                    SeniorContactBookItem(
                      title: context.translate.jobPosition,
                      items: [
                        contractEmployee.workstationName!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (contractEmployee.employeeAddress != null)
                    SeniorContactBookItem(
                      title: context.translate.address,
                      items: [
                        AddressFormatter.getAddressFormatted(
                          address: contractEmployee.employeeAddress!,
                          appLocalizations: context.translate,
                          enumAddressStringFormatter: EnumAddressStringFormatter(),
                          zipCodeFormatter: ZipCodeFormatter(),
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
