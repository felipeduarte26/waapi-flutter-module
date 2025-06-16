import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/extension/translate_extension.dart';
import '../blocs/search_country_bloc/search_country_bloc.dart';
import '../blocs/search_country_bloc/search_country_event.dart';
import '../blocs/search_country_bloc/search_country_state.dart';
import 'country_search_list_view_widget.dart';

class SelectCountryBottomSheetContentWidget extends StatefulWidget {
  final SearchCountryBloc searchCountryBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;

  const SelectCountryBottomSheetContentWidget({
    Key? key,
    required this.searchCountryBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
  }) : super(key: key);

  @override
  State<SelectCountryBottomSheetContentWidget> createState() {
    return _SelectCountryBottomSheetContentWidgetState();
  }
}

class _SelectCountryBottomSheetContentWidgetState extends State<SelectCountryBottomSheetContentWidget> {
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
      body: BlocConsumer<SearchCountryBloc, SearchCountryState>(
        bloc: widget.searchCountryBloc,
        listener: (_, state) {
          final searchCountryBlocState = state;

          if (searchCountryBlocState is ErrorSearchCountryState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                message: context.translate.searchEmployeeErrorText,
                action: SeniorSnackBarAction(
                  onPressed: () => widget.searchCountryBloc.add(
                    SearchCountryProfileEvent(
                      search: searchCountryBlocState.search,
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
                        key: const Key('profile-select_country_bottom_sheet-text_field'),
                        label: context.translate.addressCountry,
                        helper: context.translate.searchEmployeeTextFieldHint,
                        maxLines: 1,
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        onChanged: (search) {
                          // Condition added because when the user dismisses keyboard
                          // using back button on changed was called and triggering a new event,
                          // and therefore a new search has been made.
                          if (lastSearch != search) {
                            lastSearch = search;
                            _formKey.currentState!.validate();
                            widget.searchCountryBloc.add(
                              SearchCountryProfileEvent(
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
                    CountrySearchListViewWidget(
                      key: const Key('profile-select_country_bottom_sheet-country_search_list'),
                      searchCountryBloc: widget.searchCountryBloc,
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
