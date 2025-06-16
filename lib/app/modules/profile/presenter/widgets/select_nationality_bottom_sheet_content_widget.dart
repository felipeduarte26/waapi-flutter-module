import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/extension/translate_extension.dart';
import '../blocs/search_nationality/search_nationality_bloc.dart';
import '../blocs/search_nationality/search_nationality_event.dart';
import '../blocs/search_nationality/search_nationality_state.dart';
import 'nationality_search_list_view_widget.dart';

class SelectNationalityBottomSheetContentWidget extends StatefulWidget {
  final SearchNationalityBloc searchNationalityBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const SelectNationalityBottomSheetContentWidget({
    Key? key,
    required this.searchNationalityBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  State<SelectNationalityBottomSheetContentWidget> createState() {
    return _SelectNationalityBottomSheetContentWidgetState();
  }
}

class _SelectNationalityBottomSheetContentWidgetState extends State<SelectNationalityBottomSheetContentWidget> {
  late final GlobalKey<FormState> _formKey;
  var lastSearch = '';

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Scaffold(
      backgroundColor: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
      body: BlocConsumer<SearchNationalityBloc, SearchNationalityState>(
        bloc: widget.searchNationalityBloc,
        listener: (_, state) {
          final searchNationalityBlocState = state;

          if (searchNationalityBlocState is ErrorSearchNationalityState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                message: context.translate.searchEmployeeErrorText,
                action: SeniorSnackBarAction(
                  onPressed: () => widget.searchNationalityBloc.add(
                    SearchNationalityProfileEvent(
                      search: searchNationalityBlocState.search,
                    ),
                  ),
                  label: context.translate.repeat,
                ),
              ),
            );
          }
        },
        listenWhen: (oldState, newState) => oldState != newState,
        buildWhen: (oldState, newState) => oldState != newState,
        builder: (_, __) {
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
                      child: SeniorTextField(
                        key: const Key('profile-select_nationality_bottom_sheet-text_field'),
                        label: context.translate.nationality,
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
                            widget.searchNationalityBloc.add(
                              SearchNationalityProfileEvent(
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
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: SeniorSpacing.medium,
                      ),
                    ),
                    NationalitySearchListViewWidget(
                      key: const Key('profile-select_nationality_bottom_sheet-nationality_search_list'),
                      searchNationalityBloc: widget.searchNationalityBloc,
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
