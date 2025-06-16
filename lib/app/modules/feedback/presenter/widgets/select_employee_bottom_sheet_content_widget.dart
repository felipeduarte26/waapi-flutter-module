import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../blocs/search_employee_bloc/search_employee_bloc.dart';
import '../blocs/search_employee_bloc/search_employee_event.dart';
import '../blocs/search_employee_bloc/search_employee_state.dart';
import 'employees_search_list_view_widget.dart';

class SelectEmployeeBottomSheetContentWidget extends StatefulWidget {
  final SearchEmployeeBloc searchEmployeeBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const SelectEmployeeBottomSheetContentWidget({
    Key? key,
    required this.searchEmployeeBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  State<SelectEmployeeBottomSheetContentWidget> createState() {
    return _SelectEmployeeBottomSheetContentWidgetState();
  }
}

class _SelectEmployeeBottomSheetContentWidgetState extends State<SelectEmployeeBottomSheetContentWidget> {
  late final GlobalKey<FormState> _formKey;
  var lastSearch = '';

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeRepository>(context, listen: false).theme.backdropTheme!.style!.bodyColor,
      body: BlocConsumer<SearchEmployeeBloc, SearchEmployeeState>(
        bloc: widget.searchEmployeeBloc,
        listener: (_, state) {
          final searchEmployeeBlocState = state;

          if (searchEmployeeBlocState is ErrorSearchEmployeeState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                message: context.translate.searchEmployeeErrorText,
                action: SeniorSnackBarAction(
                  onPressed: () => widget.searchEmployeeBloc.add(
                    SearchEmployeeToWriteFeedbackEvent(
                      search: searchEmployeeBlocState.search,
                    ),
                  ),
                  label: context.translate.repeat,
                ),
              ),
            );
          }

          if (searchEmployeeBlocState is LoadedSelectEmployeeState) {
            Modular.to.pop();
          }
        },
        listenWhen: (oldState, newState) => oldState != newState,
        buildWhen: (oldState, newState) => oldState != newState,
        builder: (_, searchEmployeeState) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.normal,
              ),
              child: Scrollbar(
                child: CustomScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SeniorSpacing.normal,
                        ),
                        child: SeniorTextField(
                          key: const Key('feedback-select_employee_bottom_sheet-text_field'),
                          label: context.translate.coworker,
                          helper: context.translate.searchEmployeeTextFieldHint,
                          autofocus: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          onChanged: (search) {
                            // Condition added because when the user dismisses keyboard
                            // using back button on changed was called and triggering a new event,
                            // and therefore a new search has been made.
                            if (lastSearch != search) {
                              lastSearch = search;
                              _formKey.currentState!.validate();
                              widget.searchEmployeeBloc.add(
                                SearchEmployeeToWriteFeedbackEvent(
                                  search: search,
                                ),
                              );
                            }
                          },
                          validator: (value) {
                            if (value != null && value.trim().length < 3) {
                              return context.translate.searchEmployeeTextFieldHint;
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: SeniorSpacing.medium,
                      ),
                    ),
                    EmployeesSearchListViewWidget(
                      key: const Key('feedback-select_employee_bottom_sheet-employee_search_list'),
                      searchEmployeeBloc: widget.searchEmployeeBloc,
                      initialTitle: widget.initialTitle,
                      initialSubtitle: widget.initialSubtitle,
                      noFoundTitle: widget.noFoundTitle,
                      noFoundSubtitle: widget.noFoundSubtitle,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
