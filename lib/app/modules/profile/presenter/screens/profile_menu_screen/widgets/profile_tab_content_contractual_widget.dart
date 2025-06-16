import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/profile_entity.dart';
import '../bloc/profile_menu_screen_bloc.dart';

class ProfileTabContentContractualWidget extends StatefulWidget {
  const ProfileTabContentContractualWidget({
    super.key,
  });

  @override
  State<ProfileTabContentContractualWidget> createState() {
    return _ProfileTabContentContractualWidgetState();
  }
}

class _ProfileTabContentContractualWidgetState extends State<ProfileTabContentContractualWidget> {
  late final ProfileEntity _profileEntity;
  late final AuthorizationEntity _authorizationEntity;

  @override
  void initState() {
    super.initState();
    _profileEntity = Modular.get<ProfileMenuScreenBloc>().profileBloc.state.profileEntity!;
    _authorizationEntity = (Modular.get<AuthorizationBloc>().state as LoadedAuthorizationState).authorizationEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _authorizationEntity.allowToViewWorkContract,
              child: SeniorMenuItemList(
                leftPadding: SeniorSpacing.normal,
                rightPadding: SeniorSpacing.normal,
                leading: const SeniorIcon(
                  icon: FontAwesomeIcons.solidFileContract,
                  size: SeniorSpacing.medium,
                ),
                title: context.translate.profileEmploymentContract,
                onTap: () => Modular.to.pushNamed(
                  ProfileRoutes.employmentContractInitialRoute,
                  arguments: _profileEntity,
                ),
              ),
            ),
            Visibility(
              visible: _authorizationEntity.allowToViewWorkContract,
              child: SeniorMenuItemList(
                leftPadding: SeniorSpacing.normal,
                rightPadding: SeniorSpacing.normal,
                leading: const SeniorIcon(
                  icon: FontAwesomeIcons.solidFileLines,
                  size: SeniorSpacing.medium,
                ),
                title: context.translate.profileEmployerInformation,
                onTap: () => Modular.to.pushNamed(ProfileRoutes.employerInformationInitialRoute),
              ),
            ),
            Visibility(
              visible: _authorizationEntity.allowToViewWorkContract,
              child: SeniorMenuItemList(
                leftPadding: SeniorSpacing.normal,
                rightPadding: SeniorSpacing.normal,
                leading: const SeniorIcon(
                  icon: FontAwesomeIcons.solidClipboardList,
                  size: SeniorSpacing.medium,
                ),
                title: context.translate.profileSalaryInformation,
                onTap: () => Modular.to.pushNamed(ProfileRoutes.salaryInformationScreenRouteInitialRoute),
              ),
            ),
            Offstage(
              offstage: !_hasVisibleBankAccount(),
              child: SeniorMenuItemList(
                leftPadding: SeniorSpacing.normal,
                rightPadding: SeniorSpacing.normal,
                leading: const SeniorIcon(
                  icon: FontAwesomeIcons.buildingColumns,
                  size: SeniorSpacing.medium,
                ),
                title: context.translate.profileBankInformation,
                onTap: () => Modular.to.pushNamed(ProfileRoutes.bankAccountScreenRouteInitialRoute),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasVisibleBankAccount() {
    return _profileEntity.bankAccount != null;
  }
}
