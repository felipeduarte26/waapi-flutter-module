import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../blocs/search_naturality/search_naturality_bloc.dart';
import '../blocs/search_naturality/search_naturality_event.dart';
import '../blocs/search_naturality/search_naturality_state.dart';
import 'naturality_search_list_view_widget.dart';

class SelectNaturalityBottomSheetContentWidget extends StatefulWidget {
  final SearchNaturalityBloc searchNaturalityBloc;
  final String initialTitle;
  final String initialSubtitle;
  final String noFoundTitle;
  final String noFoundSubtitle;
  final String textFieldLabel;
  final bool isNaturality;

  const SelectNaturalityBottomSheetContentWidget({
    Key? key,
    required this.searchNaturalityBloc,
    required this.initialTitle,
    required this.initialSubtitle,
    required this.noFoundTitle,
    required this.noFoundSubtitle,
    required this.textFieldLabel,
    this.isNaturality = false,
  }) : super(key: key);

  @override
  State<SelectNaturalityBottomSheetContentWidget> createState() {
    return _SelectNaturalityBottomSheetContentWidgetState();
  }
}

class _SelectNaturalityBottomSheetContentWidgetState extends State<SelectNaturalityBottomSheetContentWidget> {
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
      body: BlocConsumer<SearchNaturalityBloc, SearchNaturalityState>(
        bloc: widget.searchNaturalityBloc,
        listener: (_, state) {
          final searchNaturalityBlocState = state;

          if (searchNaturalityBlocState is ErrorSearchNaturalityState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SeniorSnackBar.error(
                message: context.translate.searchNaturalityError,
                action: SeniorSnackBarAction(
                  onPressed: () => widget.searchNaturalityBloc.add(
                    SearchNaturalityProfileEvent(
                      search: searchNaturalityBlocState.search,
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
                    if (widget.isNaturality)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                          ),
                          child: SeniorText.body(
                            context.translate.naturalitySubtitle,
                            color: SeniorColors.neutralColor600,
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SeniorTextField(
                        key: const Key('profile-select_naturality_bottom_sheet-text_field'),
                        label: widget.textFieldLabel,
                        helper: context.translate.searchEmployeeTextFieldHint,
                        autofocus: true,
                        maxLines: 1,
                        counterText: context.translate.characters,
                        textInputAction: TextInputAction.done,
                        onChanged: (search) {
                          // Condition added because when the user dismisses keyboard
                          // using back button on changed was called and triggering a new event,
                          // and therefore a new search has been made.
                          if (lastSearch != search) {
                            lastSearch = search;
                            _formKey.currentState!.validate();
                            widget.searchNaturalityBloc.add(
                              SearchNaturalityProfileEvent(
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
                    NaturalitySearchListViewWidget(
                      key: const Key('profile-select_naturality_bottom_sheet-naturality_search_list'),
                      searchNaturalityBloc: widget.searchNaturalityBloc,
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
