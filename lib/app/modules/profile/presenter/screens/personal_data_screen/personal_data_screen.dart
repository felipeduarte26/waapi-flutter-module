import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/warning_widget.dart';
import '../../../../../routes/profile_routes.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../enums/personal_request_update_status_enum.dart';
import '../../blocs/dependent_bloc/dependent_bloc.dart';
import '../../blocs/dependent_bloc/dependent_event.dart';
import '../../blocs/dependent_bloc/dependent_state.dart';
import '../../blocs/profile_bloc/profile_bloc.dart';
import '../../blocs/profile_bloc/profile_state.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';
import 'widgets/waapi_person_data_card_widget.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalDataScreen> createState() {
    return _PersonalDataScreenState();
  }
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  late ProfileEntity profileEntity;
  late AuthorizationEntity authorizationEntity;
  late DependentBloc _dependentBloc;

  @override
  void initState() {
    super.initState();
    _dependentBloc = Modular.get<DependentBloc>();

    final profileState = Modular.get<ProfileMenuScreenBloc>().profileBloc.state;
    _dependentBloc.add(GetDependentsEvent(employeeId: profileState.profileEntity!.contract!.employeeId!));
    profileEntity = profileState.profileEntity!;
    final authorizationState = Modular.get<ProfileMenuScreenBloc>().state.authorizationState;
    authorizationEntity = (authorizationState as LoadedAuthorizationState).authorizationEntity;
  }

  @override
  Widget build(BuildContext context) {
    if (_dependentBloc.state is LoadedDependentState) {
      // ignore: unused_local_variable
      final dependents = _dependentBloc.state.dependents;
    }
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.personalData,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: Modular.get<ProfileMenuScreenBloc>().profileBloc,
          builder: (_, __) {
            return isEmpty()
                ? Column(
                    children: [
                      if (profileEntity.personalRequestUpdate != null)
                        WarningWidget(
                          message: personalRequestUpdateMessage(),
                          icon: FontAwesomeIcons.solidTriangleExclamation,
                          iconColor: SeniorColors.manchesterColorOrange400,
                        ),
                      Expanded(
                        child: EmptyStateWidget(
                          title: context.translate.noPersonalDataRegisteredYet,
                          imagePath: AssetsPath.generalEmptyState,
                        ),
                      ),
                      EmployeeBottomSheetWidget(
                        horizontalPadding: true,
                        seniorButtons: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: SeniorSpacing.normal,
                            ),
                            child: SeniorButton(
                              disabled: profileEntity.personalRequestUpdate?.status != null,
                              busy: false,
                              fullWidth: true,
                              label: context.translate.addPersonalData,
                              onPressed: () async {
                                await Modular.to.pushNamed(
                                  ProfileRoutes.editPersonalDataScreenInitialRoute,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      profileEntity.personalRequestUpdate != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: SeniorSpacing.xsmall,
                                right: SeniorSpacing.xsmall,
                                top: SeniorSpacing.normal,
                              ),
                              child: WarningWidget(
                                message: personalRequestUpdateMessage(),
                                icon: FontAwesomeIcons.solidTriangleExclamation,
                                iconColor: SeniorColors.manchesterColorOrange400,
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      WaapiPersonDataCardWidget(
                        profileEntity: profileEntity,
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      authorizationEntity.allowToUpdatePersonalData
                          ? EmployeeBottomSheetWidget(
                              horizontalPadding: true,
                              seniorButtons: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: SeniorSpacing.normal,
                                  ),
                                  child: SeniorButton(
                                    disabled: profileEntity.personalRequestUpdate != null,
                                    busy: false,
                                    fullWidth: true,
                                    label: context.translate.edit,
                                    onPressed: () async {
                                      await Modular.to.pushNamed(
                                        ProfileRoutes.editPersonalDataScreenInitialRoute,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
          },
        ),
      ),
    );
  }

  bool isEmpty() {
    return (profileEntity.personEntity?.birthDate == null) &&
        (profileEntity.personEntity?.ethnicity == null) &&
        (profileEntity.gender == null) &&
        (profileEntity.nationality == null) &&
        (profileEntity.placeOfBirth == null) &&
        (profileEntity.maritalStatus == null) &&
        (profileEntity.educationDegreeName == null);
  }

  String personalRequestUpdateMessage() {
    if (profileEntity.personalRequestUpdate?.status == PersonalRequestUpdateStatusEnum.awaitingReview) {
      return context.translate.theInformationPresentedIsUnderAnalysis;
    }
    return context.translate.theInformationPresentedIsUnderProcessing;
  }
}
