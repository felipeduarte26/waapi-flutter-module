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
import '../../../../routes/profile_routes.dart';
import '../../domain/entities/employees_by_year_hire_entity.dart';
import '../blocs/company_birthdays/company_birthdays_bloc.dart';
import '../blocs/company_birthdays/company_birthdays_event.dart';
import '../blocs/company_birthdays/company_birthdays_state.dart';
import 'birthday_employee_card_widget.dart';

class NextCompanyBirthdaysWidget extends StatefulWidget {
  final bool disabled;
  final String employeeId;

  const NextCompanyBirthdaysWidget({
    Key? key,
    required this.employeeId,
    required this.disabled,
  }) : super(key: key);

  @override
  State<NextCompanyBirthdaysWidget> createState() {
    return _NextCompanyBirthdaysWidgetState();
  }
}

class _NextCompanyBirthdaysWidgetState extends State<NextCompanyBirthdaysWidget> {
  late CompanyBirthdaysBloc _companyBirthdaysBloc;
  late ScrollController _scrollController;

  var nextPage = 1;
  var canLoadMore = true;
  var birthdayEmployees = <Widget>[];

  @override
  void initState() {
    super.initState();
    _companyBirthdaysBloc = Modular.get<CompanyBirthdaysBloc>();
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
          key: const Key('corporate-mural-description_next_birthdays_company'),
          title: context.translate.nextCompanyBirthdays,
          icon: FontAwesomeIcons.solidBuilding,
        ),
        BlocConsumer<CompanyBirthdaysBloc, CompanyBirthdaysState>(
          bloc: _companyBirthdaysBloc,
          listener: (_, state) {
            if (state is ErrorLoadingMoreCompanyBirthdaysState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.error(
                  key: const Key('corporate-mural-error_loading_more_birthdays_company'),
                  message: context.translate.errorOnLoadMoreBirthdayCompanyMessage,
                  action: SeniorSnackBarAction(
                    label: context.translate.repeat,
                    onPressed: () => _getNext15DaysBirthdaysCompanyEvent(
                      page: nextPage,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (_, state) {
            if (state is LoadingCompanyBirthdaysState) {
              return const Padding(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: Center(
                  child: WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    key: Key('corporate-mural-company_loading_state_company'),
                  ),
                ),
              );
            }

            if (state is EmptyCompanyBirthdaysState) {
              return StateCardWidget(
                key: const Key('corporate-mural-company_empty_state-card'),
                textButton: context.translate.tryAgain,
                message: context.translate.noCompanyEmployeesFoundMessage,
                iconData: FontAwesomeIcons.solidBuilding,
                disabled: widget.disabled,
              );
            }

            if (state is ErrorCompanyBirthdaysState) {
              return StateCardWidget(
                key: const Key('corporate-mural-company_error_state-card'),
                textButton: context.translate.tryAgain,
                message: context.translate.errorWhenSearchingCompanyBirthdays,
                onTap: _getNext15DaysBirthdaysCompanyEvent,
                showButton: true,
                iconData: FontAwesomeIcons.solidTriangleExclamation,
                disabled: widget.disabled,
              );
            }

            if (state is LoadedCompanyBirthdaysState) {
              nextPage++;
              canLoadMore = true;

              _addBirthdayEmployeesToList(
                employeesByYearHireEntityList: state.employeesByYearHireEntityList,
              );
            }

            if (state is LastPageCompanyBirthdaysState) {
              _addBirthdayEmployeesToList(
                employeesByYearHireEntityList: state.employeesByYearHireEntityList,
              );
            }

            if (state is ReloadCompanyBirthdaysState || state is InitialCompanyBirthdaysState) {
              nextPage = 1;
              canLoadMore = true;

              _getNext15DaysBirthdaysCompanyEvent();
            }

            return Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SizedBox(
                height: 133.0,
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
                        offstage: state is! LoadingMoreCompanyBirthdaysState,
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

  void _getNext15DaysBirthdaysCompanyEvent({
    int page = 1,
  }) {
    _companyBirthdaysBloc.add(
      GetNext15DaysBirthdaysCompanyEvent(
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
      _getNext15DaysBirthdaysCompanyEvent(
        page: nextPage,
      );
    }
  }

  void _addBirthdayEmployeesToList({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) {
    birthdayEmployees = <Widget>[];
    var yearsCount = 0;
    var hireDate = DateTime.now();

    for (final employeesByYearHireEntity in employeesByYearHireEntityList) {
      yearsCount = employeesByYearHireEntity.yearsCount;

      for (final employeesByHireDateEntity in employeesByYearHireEntity.employeesByHireDateEntity) {
        hireDate = employeesByHireDateEntity.hireDate;

        for (final employee in employeesByHireDateEntity.employees) {
          birthdayEmployees.add(
            BirthdayEmployeeCardWidget(
              key: Key('corporate-mural-birthdays-company-card-${employee.employeeId}'),
              disabled: widget.disabled,
              employeeName: employee.firstName,
              birthday: hireDate,
              employeePhotoLink: employee.photoLink,
              yearsCount: yearsCount,
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
}
