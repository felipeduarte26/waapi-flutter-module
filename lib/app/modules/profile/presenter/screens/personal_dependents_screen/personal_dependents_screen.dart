import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../routes/profile_routes.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../blocs/dependent_bloc/dependent_event.dart';
import '../../blocs/dependent_bloc/dependent_state.dart';
import 'bloc/personal_dependents_screen_bloc.dart';
import 'bloc/personal_dependents_screen_state.dart';
import 'widgets/personal_dependents_card_widget.dart';

class PersonalDependentsScreen extends StatefulWidget {
  const PersonalDependentsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDependentsScreen> createState() => _PersonalDependentsScreenState();
}

class _PersonalDependentsScreenState extends State<PersonalDependentsScreen> {
  late final PersonalDependentsScreenBloc personalDependentsScreenBloc;

  @override
  void initState() {
    super.initState();
    personalDependentsScreenBloc = Modular.get<PersonalDependentsScreenBloc>();
    personalDependentsScreenBloc.dependentBloc.add(
      GetDependentsEvent(
        employeeId: personalDependentsScreenBloc.state.profileState.profileEntity!.contract!.employeeId!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.myDependents,
        body: BlocBuilder<PersonalDependentsScreenBloc, PersonalDependentsScreenState>(
          bloc: personalDependentsScreenBloc,
          builder: (context, state) {
            if (state.dependentState is LoadingDependentState) {
              return const Center(
                child: WaapiLoadingWidget(
                  waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                ),
              );
            }

            final isAllowedToUpdate = (state.authorizationState as LoadedAuthorizationState)
                .authorizationEntity
                .allowToUpdatePersonalDependents;

            if (state.dependentState is EmptyStateDependentState || state.dependentState is ErrorDependentState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                  vertical: SeniorSpacing.normal,
                ),
                child: EmptyStateWidget(
                  title: context.translate.noDataRegisteredYet,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  imagePath: AssetsPath.generalEmptyState,
                  imageHeight: 180,
                  actions: [
                    if (isAllowedToUpdate)
                      SeniorButton(
                        label: context.translate.addDependent,
                        fullWidth: true,
                        onPressed: () async {
                          _addDependent(
                            cpfHolder: personalDependentsScreenBloc.state.profileState.profileEntity!.cpf ?? '',
                            nameHolder: personalDependentsScreenBloc.state.profileState.profileEntity!.name,
                          );
                        },
                      ),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.normal,
                    right: SeniorSpacing.normal,
                    top: SeniorSpacing.normal,
                  ),
                  child: SeniorText.cta(
                    context.translate.myDependents,
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      itemCount: state.dependentState.dependents.length,
                      itemBuilder: (context, index) {
                        return PersonalDependentsCardWidget(
                          index: index,
                          dependent: state.dependentState.dependents[index],
                          onEditPressed: () async {
                            final edited = await Modular.to.pushNamed(
                              ProfileRoutes.editPersonalDependentsScreenInitialRoute,
                              arguments: {
                                'dependentEntity': state.dependentState.dependents[index],
                                'cpfHolder': state.profileState.profileEntity!.cpf ?? '',
                                'nameHolder': state.profileState.profileEntity!.name,
                              },
                            ) as bool?;

                            if (edited ?? false) {
                              personalDependentsScreenBloc.dependentBloc.add(
                                GetDependentsEvent(
                                  employeeId: personalDependentsScreenBloc
                                      .state.profileState.profileEntity!.contract!.employeeId!,
                                ),
                              );
                            }
                          },
                          isAllowedToUpdate: isAllowedToUpdate,
                        );
                      },
                    ),
                  ),
                ),
                if (isAllowedToUpdate)
                  EmployeeBottomSheetWidget(
                    seniorButtons: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: SeniorSpacing.normal,
                        ),
                        child: SeniorButton(
                          disabled: false,
                          busy: false,
                          fullWidth: true,
                          label: context.translate.addDependent,
                          onPressed: () async {
                            _addDependent(
                              cpfHolder: personalDependentsScreenBloc.state.profileState.profileEntity!.cpf ?? '',
                              nameHolder: personalDependentsScreenBloc.state.profileState.profileEntity!.name,
                            );
                          },
                        ),
                      ),
                    ],
                    horizontalPadding: true,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _addDependent({
    required String cpfHolder,
    required String nameHolder,
  }) async {
    final added = await Modular.to.pushNamed(
      ProfileRoutes.editPersonalDependentsScreenInitialRoute,
      arguments: {
        'dependentEntity': null,
        'cpfHolder': cpfHolder,
        'nameHolder': nameHolder,
      },
    ) as bool?;

    if (added ?? false) {
      personalDependentsScreenBloc.dependentBloc.add(
        GetDependentsEvent(
          employeeId: personalDependentsScreenBloc.state.profileState.profileEntity!.contract!.employeeId!,
        ),
      );
    }
  }
}
