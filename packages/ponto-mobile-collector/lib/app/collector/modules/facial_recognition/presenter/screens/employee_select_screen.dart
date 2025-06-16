import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../../../routes/collector_routes.dart';
import '../../../routes/facial_recognition_routes.dart';
import '../cubit/employee_search/employee_search_cubit.dart';
import '../cubit/employee_search/employee_search_state.dart';
import 'employee_item_widget.dart';
import 'feedback_screen.dart';

class EmployeeSelectScreen extends StatefulWidget {
  final EmployeeSearchCubit employeeSearchCubit;
  final NavigatorService navigatorService;
  final IUtils utils;

  const EmployeeSelectScreen({
    required this.employeeSearchCubit,
    required this.navigatorService,
    required this.utils,
    super.key,
  });

  @override
  EmployeeSelectScreenState createState() => EmployeeSelectScreenState();
}

class EmployeeSelectScreenState extends State<EmployeeSelectScreen> {
  final ScrollController _scrollController = ScrollController();
  int notSelectedValue = -1;
  int selectedEmployee = -1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          widget.employeeSearchCubit.loadMore();
        }
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return BlocBuilder<EmployeeSearchCubit, EmployeeSearchState>(
      bloc: widget.employeeSearchCubit,
      builder: (context, state) {
        if (state is EmployeeSearchNotPermission) {
          return FeedbackScreen(
            navigatorService: widget.navigatorService,
            feedbackType: FeedbackTypeEnum.error,
            title: CollectorLocalizations.of(context).userWithoutPermission,
            subtitle: CollectorLocalizations.of(context)
                .userWithoutPermissionDescription,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                style: const SeniorButtonStyle(
                  backgroundColor: SeniorColors.primaryColor600,
                ),
                onPressed: () => widget.employeeSearchCubit.init(),
                fullWidth: true,
              ),
            ],
          );
        }

        if (state is EmployeeSearchOffline) {
          return FeedbackScreen(
            navigatorService: widget.navigatorService,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () => widget.employeeSearchCubit.init(),
                fullWidth: true,
                style: const SeniorButtonStyle(
                  backgroundColor: SeniorColors.primaryColor600,
                ),
              ),
            ],
            feedbackType: FeedbackTypeEnum.error,
            subtitle: CollectorLocalizations.of(context)
                .facialRegistrationOnlineCheckConnection,
            title: CollectorLocalizations.of(context).facialLooksLikeAreOffline,
          );
        }

        if (state is EmployeeSearchFailure) {
          return FeedbackScreen(
            navigatorService: widget.navigatorService,
            feedbackType: FeedbackTypeEnum.alert,
            title: CollectorLocalizations.of(context).unresponsiveService,
            subtitle: CollectorLocalizations.of(context)
                .unresponsiveServiceDescription,
            buttons: [
              SeniorButton(
                label: CollectorLocalizations.of(context).facialTryAgain,
                onPressed: () => widget.employeeSearchCubit.init(),
                fullWidth: true,
                style: const SeniorButtonStyle(
                  backgroundColor: SeniorColors.primaryColor600,
                ),
              ),
            ],
          );
        }

        return Scaffold(
          body: SeniorColorfulHeaderStructure(
            hasTopPadding: false,
            title: SeniorText.label(
              CollectorLocalizations.of(context)
                  .facialRecognitionRegistrationEmployee,
              color: SeniorColors.pureWhite,
              darkColor: SeniorColors.pureWhite,
            ),
            leading: IconButton(
              icon: const Icon(
                FontAwesomeIcons.angleLeft,
                color: SeniorColors.pureWhite,
              ),
              iconSize: SeniorSpacing.small,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            body: state is EmployeeSearchInitial
                ? const LoadingWidget(bottomLabel: '')
                : Padding(
                    padding: const EdgeInsets.all(SeniorSpacing.normal),
                    child: Column(
                      children: [
                        SeniorText.label(
                          CollectorLocalizations.of(context)
                              .facialSelectEmployeeTitle,
                        ),
                        const SizedBox(
                          height: SeniorSpacing.xsmall,
                        ),
                        SeniorTextField(
                          disabled: widget.employeeSearchCubit.state
                              is EmployeeSearchInProgress,
                          label:
                              CollectorLocalizations.of(context).collaborator,
                          hintText: CollectorLocalizations.of(context)
                              .enterRrSearchForTheCollaborator,
                          suffixWidget: IconButton(
                            color: isDark
                                ? SeniorColors.pureWhite
                                : SeniorColors.neutralColor800,
                            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                            iconSize: SeniorSpacing.small,
                            onPressed: () {
                              selectedEmployee = notSelectedValue;
                              widget.employeeSearchCubit.search();
                            },
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (p0) {
                            widget.employeeSearchCubit.changeNameSearch(p0);
                          },
                          onEditingComplete: () {
                            selectedEmployee = notSelectedValue;
                            widget.employeeSearchCubit.search();
                          },
                        ),
                        Row(
                          children: [
                            SeniorText.small(
                              CollectorLocalizations.of(context).employeeList,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (state is EmployeeSearchSuccess ||
                                  state is EmployeeSearchLoadMoreInProgress) {
                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: widget
                                      .employeeSearchCubit.employees.length,
                                  itemBuilder: (context, index) {
                                    return EmployeeItemWidget(
                                      selected: index == selectedEmployee,
                                      index: index,
                                      onTap: () => {
                                        setState(() {
                                          selectedEmployee = index;
                                        }),
                                      },
                                      name: widget.employeeSearchCubit
                                          .employees[index].name,
                                      identifier: widget.utils.maskCPF(
                                        cpf: widget.employeeSearchCubit
                                            .employees[index].identifier,
                                      ),
                                    );
                                  },
                                );
                              }

                              return const LoadingWidget(
                                bottomLabel: '',
                              );
                            },
                          ),
                        ),
                        if (state is EmployeeSearchLoadMoreInProgress) ...[
                          const Padding(
                            padding: EdgeInsets.all(SeniorSpacing.xxsmall),
                            child: SeniorLoading(),
                          ),
                        ],
                        const SizedBox(height: SeniorSpacing.normal),
                        SeniorButton(
                          disabled: selectedEmployee == notSelectedValue,
                          fullWidth: true,
                          label:
                              CollectorLocalizations.of(context).continueText,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}'
                                  .replaceAll(
                                ':id',
                                widget.employeeSearchCubit
                                    .employees[selectedEmployee].id
                                    .toString(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
