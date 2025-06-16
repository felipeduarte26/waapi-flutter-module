import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../blocs/profile_bloc/profile_bloc.dart';
import '../../blocs/profile_bloc/profile_state.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BankAccountScreen> createState() {
    return _BankAccountScreenState();
  }
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = Modular.get<ProfileMenuScreenBloc>().profileBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        builder: (_, state) {
          final bankAccountData = state.profileEntity?.bankAccount;

          return WaapiColorfulHeader(
            titleLabel: context.translate.profileBankInformation,
            hasTopPadding: false,
            body: Scrollbar(
              child: ListView(
                padding: EdgeInsets.zero,
                key: const Key('profile-bank_account_screen-listview'),
                children: [
                  if (bankAccountData != null && bankAccountData.bank != null && bankAccountData.bank!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key('profile-bank_account_screen-bank_account_item-bank_name'),
                      title: context.translate.profileBankName,
                      items: [
                        bankAccountData.bank!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (bankAccountData != null && bankAccountData.agency != null && bankAccountData.agency!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key('profile-bank_account_screen-bank_account_item-branch'),
                      title: context.translate.profileBranch,
                      items: [
                        bankAccountData.agency!,
                      ],
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                    ),
                  if (bankAccountData != null && bankAccountData.account != null && bankAccountData.account!.isNotEmpty)
                    SeniorContactBookItem(
                      key: const Key('profile-bank_account_screen-bank_account_item-account_number'),
                      title: context.translate.profileAccountNumber,
                      items: [
                        bankAccountData.account!,
                      ],
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
