import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/profile_entity.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../bloc/profile_menu_screen_bloc.dart';
import '../bloc/profile_menu_screen_state.dart';

class ProfileTabContentPersonalWidget extends StatefulWidget {
  const ProfileTabContentPersonalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileTabContentPersonalWidget> createState() {
    return _ProfileTabContentPersonalWidgetState();
  }
}

class _ProfileTabContentPersonalWidgetState extends State<ProfileTabContentPersonalWidget> {
  late final ProfileEntity profileEntity;
  late final AuthorizationEntity authorizationEntity;
  late final String personId;

  @override
  void initState() {
    super.initState();
    profileEntity = Modular.get<ProfileMenuScreenBloc>().profileBloc.state.profileEntity!;
    personId = (Modular.get<ProfileMenuScreenBloc>().personBloc.state as LoadedPersonState).personId;
    authorizationEntity =
        (Modular.get<ProfileMenuScreenBloc>().authorizationBloc.state as LoadedAuthorizationState).authorizationEntity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileMenuScreenBloc, ProfileMenuScreenState>(
      bloc: Modular.get<ProfileMenuScreenBloc>(),
      builder: (context, state) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SeniorMenuItemList(
                  leftPadding: SeniorSpacing.normal,
                  rightPadding: SeniorSpacing.normal,
                  leading: const SeniorIcon(
                    icon: FontAwesomeIcons.solidUser,
                    size: SeniorSpacing.medium,
                  ),
                  title: context.translate.personalData,
                  onTap: () => Modular.to.pushNamed(ProfileRoutes.personalDataScreenInitialRoute),
                ),
                if (authorizationEntity.allowToViewDiversity)
                  SeniorMenuItemList(
                    leftPadding: SeniorSpacing.normal,
                    rightPadding: SeniorSpacing.normal,
                    leading: const SeniorIcon(
                      icon: FontAwesomeIcons.solidPerson,
                      size: SeniorSpacing.medium,
                    ),
                    title: context.translate.selfDeclaration,
                    onTap: () => Modular.to.pushNamed(
                      ProfileRoutes.editPersonalDiversityScreenRouteInitialRoute,
                      arguments: {
                        'personId': personId,
                      },
                    ),
                  ),
                SeniorMenuItemList(
                  leftPadding: SeniorSpacing.normal,
                  rightPadding: SeniorSpacing.normal,
                  leading: const SeniorIcon(
                    icon: FontAwesomeIcons.solidSquarePhone,
                    size: SeniorSpacing.medium,
                  ),
                  title: context.translate.contacts,
                  onTap: () => Modular.to.pushNamed(ProfileRoutes.personalContactInitialRoute),
                ),
                SeniorMenuItemList(
                  leftPadding: SeniorSpacing.normal,
                  rightPadding: SeniorSpacing.normal,
                  leading: const SeniorIcon(
                    icon: FontAwesomeIcons.solidUserCheck,
                    size: SeniorSpacing.medium,
                  ),
                  title: context.translate.emergencyContacts,
                  onTap: () => Modular.to.pushNamed(ProfileRoutes.emergencialContactsInitialRoute),
                ),
                Offstage(
                  offstage:
                      !(state.authorizationState as LoadedAuthorizationState).authorizationEntity.allowToViewDependents,
                  child: SeniorMenuItemList(
                    leftPadding: SeniorSpacing.normal,
                    rightPadding: SeniorSpacing.normal,
                    leading: const SeniorIcon(
                      icon: FontAwesomeIcons.solidUsers,
                      size: SeniorSpacing.medium,
                    ),
                    title: context.translate.myDependents,
                    onTap: () => Modular.to.pushNamed(
                      ProfileRoutes.personalDependentsScreenInitialRoute,
                    ),
                  ),
                ),
                Offstage(
                  offstage: !_hasVisibleCurrentAddress(
                    profileEntity: state.profileState.profileEntity!,
                  ),
                  child: SeniorMenuItemList(
                    leftPadding: SeniorSpacing.normal,
                    rightPadding: SeniorSpacing.normal,
                    leading: const SeniorIcon(
                      icon: FontAwesomeIcons.solidHouse,
                      size: SeniorSpacing.medium,
                    ),
                    title: context.translate.personalAddress,
                    onTap: () => Modular.to.pushNamed(ProfileRoutes.personalAddressScreenRouteInitialRoute),
                  ),
                ),
                Offstage(
                  offstage: !_hasVisiblePersonalDocuments(),
                  child: SeniorMenuItemList(
                    leftPadding: SeniorSpacing.normal,
                    rightPadding: SeniorSpacing.normal,
                    leading: const SeniorIcon(
                      icon: FontAwesomeIcons.solidClipboardList,
                      size: SeniorSpacing.medium,
                    ),
                    title: context.translate.personalDocuments,
                    onTap: () => Modular.to.pushNamed(ProfileRoutes.profilePersonalDocumentsInitialRoute),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _hasVisibleCurrentAddress({
    required ProfileEntity profileEntity,
  }) {
    return profileEntity.currentAddress?.address?.length != null && profileEntity.currentAddress!.address!.isNotEmpty;
  }

  bool _hasVisiblePersonalDocuments() {
    return _hasVisibleCPF() ||
        _hasVisibleRG() ||
        _hasVisibleVoter() ||
        _hasVisibleCTPS() ||
        _hasVisibleCNH() ||
        _hasVisiblePassport() ||
        _hasVisibleRNE() ||
        _hasVisibleRIC() ||
        _hasVisibleNIS() ||
        _hasVisibleReservist() ||
        _hasVisibleVisa() ||
        _hasVisibleReservist() ||
        _hasVisibleCNS() ||
        _hasVisibleCivilCertificates();
  }

  bool _hasVisibleCPF() {
    return (profileEntity.cpf != null && profileEntity.cpf!.isNotEmpty);
  }

  bool _hasVisibleRG() {
    return (profileEntity.rg?.number != null && profileEntity.rg!.number!.isNotEmpty);
  }

  bool _hasVisibleVoter() {
    return (profileEntity.voterRegistration?.number != null && profileEntity.voterRegistration!.number!.isNotEmpty);
  }

  bool _hasVisibleCTPS() {
    return (profileEntity.ctps?.number != null && profileEntity.ctps!.number!.isNotEmpty);
  }

  bool _hasVisibleCNH() {
    return (profileEntity.cnh?.number != null && profileEntity.cnh!.number!.isNotEmpty);
  }

  bool _hasVisiblePassport() {
    return (profileEntity.passport?.number != null && profileEntity.passport!.number!.isNotEmpty);
  }

  bool _hasVisibleRNE() {
    return (profileEntity.rne?.number != null && profileEntity.rne!.number!.isNotEmpty);
  }

  bool _hasVisibleRIC() {
    return (profileEntity.ric?.number != null &&
        profileEntity.ric!.number!.isNotEmpty &&
        profileEntity.ric!.number! != '0');
  }

  bool _hasVisibleNIS() {
    return (profileEntity.nis?.number != null && profileEntity.nis!.number!.isNotEmpty);
  }

  bool _hasVisibleReservist() {
    return (profileEntity.reservistCertificate?.number != null &&
        profileEntity.reservistCertificate!.number!.isNotEmpty);
  }

  bool _hasVisibleVisa() {
    return (profileEntity.visa?.number != null && profileEntity.visa!.number!.isNotEmpty);
  }

  bool _hasVisibleCNS() {
    return profileEntity.liveBirthDeclaration != null && profileEntity.liveBirthDeclaration!.isNotEmpty;
  }

  bool _hasVisibleCivilCertificates() {
    if (profileEntity.civilCertificates?.length == null || profileEntity.civilCertificates!.isEmpty) {
      return false;
    }

    for (final civilCertificate in profileEntity.civilCertificates!) {
      if (civilCertificate.enrollment != null && civilCertificate.enrollment!.isNotEmpty) {
        return true;
      }
    }

    return false;
  }
}
