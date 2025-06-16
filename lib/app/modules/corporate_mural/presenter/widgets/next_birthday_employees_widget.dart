import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/scroll_helper.dart';
import '../../../../core/helper/snackbar_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/widgets/icon_header_widget.dart';
import '../../../../core/widgets/state_card_widget.dart';
import '../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../routes/routes.dart';
import '../../domain/entities/employees_by_birthday_entity.dart';
import '../blocs/birthday_employees/birthday_employees_bloc.dart';
import '../blocs/birthday_employees/birthday_employees_event.dart';
import '../blocs/birthday_employees/birthday_employees_state.dart';
import 'birthday_employee_card_widget.dart';

class NextBirthdayEmployeesWidget extends StatefulWidget {
  final bool disabled;
  final String employeeId;

  const NextBirthdayEmployeesWidget({
    Key? key,
    required this.employeeId,
    required this.disabled,
  }) : super(key: key);

  @override
  State<NextBirthdayEmployeesWidget> createState() {
    return _NextBirthdayEmployeesWidgetState();
  }
}

class _NextBirthdayEmployeesWidgetState extends State<NextBirthdayEmployeesWidget> {
  late BirthdayEmployeesBloc _birthdayEmployeesBloc;
  late ScrollController _scrollController;

  var nextPage = 1;
  var canLoadMore = true;
  var birthdayEmployees = <Widget>[];

  @override
  void initState() {
    super.initState();
    _birthdayEmployeesBloc = Modular.get<BirthdayEmployeesBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconHeaderWidget(
          key: const Key('corporate-mural-description_next_birthdays'),
          title: context.translate.nextBirthdays,
          icon: FontAwesomeIcons.solidCakeCandles,
        ),
        BlocConsumer<BirthdayEmployeesBloc, BirthdayEmployeesState>(
          bloc: _birthdayEmployeesBloc,
          listener: (_, state) {
            if (state is ErrorLoadingMoreBirthdayEmployeesState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  key: const Key('corporate-mural-error_loading_more_birthdays'),
                  message: context.translate.errorOnLoadMoreBirthdayEmployeesMessage,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => _getNext15DaysBirthdayEmployeesEvent(
                      page: nextPage,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (_, state) {
            if (state is LoadingBirthdayEmployeesState) {
              return const Padding(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: Center(
                  child: WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    key: Key('corporate-mural-loading_state'),
                  ),
                ),
              );
            }

            if (state is EmptyBirthdayEmployeesState) {
              return StateCardWidget(
                key: const Key('corporate-mural-empty_state-card'),
                textButton: context.translate.tryAgain,
                message: context.translate.noBirthdayEmployeesFoundMessage,
                iconData: FontAwesomeIcons.solidCakeCandles,
                disabled: widget.disabled,
              );
            }

            if (state is ErrorBirthdayEmployeesState) {
              return StateCardWidget(
                key: const Key('corporate-mural-error_state-card'),
                textButton: context.translate.tryAgain,
                message: context.translate.errorOnLoadBirthdayEmployees,
                onTap: _getNext15DaysBirthdayEmployeesEvent,
                showButton: true,
                iconData: FontAwesomeIcons.solidTriangleExclamation,
                disabled: widget.disabled,
              );
            }

            if (state is LoadedBirthdayEmployeesState) {
              nextPage++;
              canLoadMore = true;

              _addBirthdayEmployeesToList(
                employeesByBirthday: state.birthdayEmployees,
              );
            }

            if (state is LastPageBirthdayEmployeesState) {
              _addBirthdayEmployeesToList(
                employeesByBirthday: state.birthdayEmployees,
              );
            }

            if (state is ReloadBirthdayEmployeesState || state is InitialBirthdayEmployeesState) {
              nextPage = 1;
              canLoadMore = true;

              _getNext15DaysBirthdayEmployeesEvent();
            }

            return Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SizedBox(
                height: 119.0,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.normal,
                    right: SeniorSpacing.normal,
                    top: SeniorSpacing.xxxsmall,
                    bottom: SeniorSpacing.xxxsmall,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: birthdayEmployees.length + 1,
                  itemBuilder: (_, index) {
                    if (index == birthdayEmployees.length) {
                      return Offstage(
                        offstage: state is! LoadingMoreBirthdayEmployeesState,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SeniorSpacing.normal,
                            ),
                            child: WaapiLoadingWidget(
                              waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                            ),
                          ),
                        ),
                      );
                    }

                    return birthdayEmployees[index];
                  },
                  separatorBuilder: (_, index) {
                    if (index == birthdayEmployees.length - 1) {
                      return const SizedBox.shrink();
                    }

                    return const SizedBox(
                      width: SeniorSpacing.normal,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _getNext15DaysBirthdayEmployeesEvent({
    int page = 1,
  }) {
    _birthdayEmployeesBloc.add(
      GetNext15DaysBirthdayEmployeesEvent(
        paginationRequirements: PaginationRequirements(
          page: page,
        ),
        currentDate: DateTime.now(),
        employeeId: widget.employeeId,
      ),
    );
  }

  void _onScroll() {
    final scrollHasReachedTheEnd = ScrollHelper.reachedListEnd(
      scrollController: _scrollController,
    );

    if (scrollHasReachedTheEnd && canLoadMore) {
      canLoadMore = false;
      _getNext15DaysBirthdayEmployeesEvent(
        page: nextPage,
      );
    }
  }

  //TODO: Refactor Remove helper method for widgets
  void _addBirthdayEmployeesToList({
    required List<EmployeesByBirthdayEntity> employeesByBirthday,
  }) {
    birthdayEmployees = <Widget>[];

    for (final birthdayEmployee in employeesByBirthday) {
      for (final employee in birthdayEmployee.employees) {
        birthdayEmployees.add(
          BirthdayEmployeeCardWidget(
            key: Key('corporate-mural-birthday-card-${employee.employeeId}'),
            disabled: widget.disabled,
            employeeName: employee.firstName,
            birthday: birthdayEmployee.birthday,
            employeePhotoLink: employee.photoLink,
            onTap: () {
              if (widget.disabled) {
                SnackbarHelper.showSnackbar(
                  context: context,
                  message: context.translate.featureIsNotAvailableOffline,
                );
              } else {
                Modular.to.pushNamed(
                  ProfileRoutes.publicProfileScreenInitialRoute,
                  arguments: employee.username,
                );
              }
            },
          ),
        );
      }
    }
  }
}
