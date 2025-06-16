import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/profile_routes.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../blocs/person_bloc/person_bloc.dart';
import '../../blocs/person_bloc/person_state.dart';
import '../../blocs/profile_bloc/profile_bloc.dart';
import '../../blocs/profile_bloc/profile_event.dart';
import '../../blocs/profile_bloc/profile_state.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';
import 'widgets/emergencial_contacts_card_widget.dart';

class EmergencialContactsScreen extends StatefulWidget {
  const EmergencialContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmergencialContactsScreen> createState() {
    return _EmergencialContactsScreenState();
  }
}

class _EmergencialContactsScreenState extends State<EmergencialContactsScreen> {
  final PersonBloc _personBloc = Modular.get<PersonBloc>();
  final ActiveContractBloc _activeContractBloc = Modular.get<ActiveContractBloc>();
  final ProfileBloc _profileBloc = Modular.get<ProfileBloc>();
  late AuthorizationEntity authorizationEntity;

  @override
  void initState() {
    super.initState();

    final authorizationState = Modular.get<ProfileMenuScreenBloc>().state.authorizationState;
    authorizationEntity = (authorizationState as LoadedAuthorizationState).authorizationEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.emergencyContacts,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (_, state) {
            if (state is LoadedProfileState) {
              return state.profileEntity?.emergencialContacts == null
                  ? EmptyStateWidget(
                      title: context.translate.thereAreNoEmergencyContactsRegisteredYet,
                      imagePath: AssetsPath.generalEmptyState,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                            left: SeniorSpacing.normal,
                            right: SeniorSpacing.normal,
                          ),
                          child: SeniorButton(
                            disabled: false,
                            busy: false,
                            fullWidth: true,
                            label: context.translate.addContact,
                            onPressed: () async {
                              await emergencialContactDetails();
                            },
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                bottom: context.bottomSize,
                              ),
                              itemCount: state.profileEntity!.emergencialContacts!.length,
                              itemBuilder: (_, index) {
                                return EmergencialContactsCardWidget(
                                  index: index,
                                  emergencialContactEntity: state.profileEntity!.emergencialContacts![index],
                                );
                              },
                            ),
                          ),
                        ),
                        authorizationEntity.allowToUpdateEmergencyContact
                            ? EmployeeBottomSheetWidget(
                                horizontalPadding: true,
                                seniorButtons: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: SeniorSpacing.normal,
                                    ),
                                    child: SeniorButton(
                                      disabled: false,
                                      busy: false,
                                      fullWidth: true,
                                      label: context.translate.addContact,
                                      onPressed: () async {
                                        await emergencialContactDetails();
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
            }
            return const Center(
              child: WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> emergencialContactDetails() async {
    final isRequested = await Modular.to.pushNamed<bool>(
      ProfileRoutes.emergencialContactsDetailsInitialRoute,
      arguments: {
        'emergencialContactEntity': null,
      },
    );
    if (isRequested != null && isRequested) {
      setState(() {
        final String personId = (_personBloc.state as LoadedPersonState).personId;
        final String employeeId =
            (_activeContractBloc.state as LoadedActiveContractState).activeContractEntity.employeeId;
        Modular.get<ProfileBloc>().add(
          GetProfileEvent(
            personId: personId,
            employeeId: employeeId,
          ),
        );
      });
    }
  }
}
