import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/cnpj_formatter.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../../blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../string_formatters/address_formatter.dart';
import '../../string_formatters/enum_address_string_formatter.dart';
import '../../string_formatters/enum_company_type_string_formatter.dart';
import '../../string_formatters/zip_code_formatter.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';

class EmployerInformationScreen extends StatefulWidget {
  const EmployerInformationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmployerInformationScreen> createState() {
    return _EmployerInformationScreenState();
  }
}

class _EmployerInformationScreenState extends State<EmployerInformationScreen> {
  late ContractEmployeeBloc _contractEmployeeBloc;

  @override
  void initState() {
    super.initState();
    _contractEmployeeBloc = Modular.get<ProfileMenuScreenBloc>().contractEmployeeBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContractEmployeeBloc, ContractEmployeeState>(
        bloc: _contractEmployeeBloc,
        builder: (_, state) {
          final employer = state.contractEmployeeEntity!.employer;

          return WaapiColorfulHeader(
            titleLabel: context.translate.profileEmployerInformation,
            hasTopPadding: false,
            body: Scrollbar(
              child: ListView(
                key: const Key('profile-employer_information_screen-listview'),
                padding: EdgeInsets.zero,
                children: [
                  if (employer != null && employer.name != null && employer.name!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key('profile-employer_information_screen-text-company_corporate_name'),
                      title: context.translate.companyCorporateName,
                      items: [
                        employer.name!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (employer != null && employer.tradingName != null && employer.tradingName!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key('profile-employer_information_screen-text-company_trade_name'),
                      title: context.translate.companyTradeName,
                      items: [
                        employer.tradingName!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (employer?.type != null)
                    SeniorContactBookItem(
                      key: const Key('profile-employer_information_screen-text-establishment_type'),
                      title: context.translate.establishmentType,
                      items: [
                        EnumCompanyTypeStringFormatter.getCompanyTypeEnumString(
                          companyTypeEnum: employer!.type!,
                          appLocalizations: context.translate,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (employer != null && employer.cnpj != null && employer.cnpj!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key('profile-employer_information_screen-text-national_register_of_legal_entities'),
                      title: context.translate.nationalRegisterOfLegalEntities,
                      items: [
                        CnpjFormatter.cnpjFormatter(
                          cnpj: employer.cnpj!,
                        ),
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (employer != null && employer.cnae != null && employer.cnae!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key(
                        'profile-employer_information_screen-text-national_classification_of_economic_activities',
                      ),
                      title: context.translate.nationalClassificationOfEconomicActivities,
                      items: [
                        employer.cnae!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (employer?.address?.address != null)
                    SeniorContactBookItem(
                      key: const Key('profile-employer_information_screen-text-address'),
                      title: context.translate.address,
                      items: employer?.address != null
                          ? [
                              AddressFormatter.getAddressFormatted(
                                address: employer!.address!,
                                appLocalizations: context.translate,
                                enumAddressStringFormatter: EnumAddressStringFormatter(),
                                zipCodeFormatter: ZipCodeFormatter(),
                              ),
                            ]
                          : null,
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  SizedBox(
                    height: context.bottomSize,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
