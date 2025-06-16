import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/icon_header_widget.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../domain/entities/happiness_index_reason_entity.dart';
import '../../../enums/happiness_index_mood_enum.dart';
import '../../blocs/happiness_index/happiness_index_event.dart';
import '../../blocs/happiness_index/happiness_index_state.dart';
import '../../blocs/retrieve_all_reasons/retrieve_all_reasons_event.dart';
import '../../blocs/retrieve_all_reasons/retrieve_all_reasons_state.dart';
import '../../screens/blocs/happiness_index_screen_bloc.dart';
import '../../screens/blocs/happiness_index_screen_state.dart';
import '../happiness_index_mood_widget.dart';
import 'happiness_index_show_reasons_widget.dart';

class HappinessIndexSelectMoodBottomSheetWidget extends StatefulWidget {
  final HappinessIndexMoodEnum selectedMood;

  const HappinessIndexSelectMoodBottomSheetWidget({
    super.key,
    required this.selectedMood,
  });

  @override
  State<HappinessIndexSelectMoodBottomSheetWidget> createState() => _HappinessIndexSelectMoodBottomSheetWidgetState();
}

class _HappinessIndexSelectMoodBottomSheetWidgetState extends State<HappinessIndexSelectMoodBottomSheetWidget> {
  late HappinessIndexScreenBloc _happinessIndexScreenBloc;

  TextEditingController notes = TextEditingController();
  late HappinessIndexMoodEnum selectedMood;
  final List<HappinessIndexReasonEntity> reasons = [];

  @override
  void initState() {
    super.initState();
    selectedMood = widget.selectedMood;
    _happinessIndexScreenBloc = Modular.get<HappinessIndexScreenBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _happinessIndexScreenBloc.retrieveAllReasonsBloc.add(
        GetRetrieveAllReasonsEvent(
          language: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    return BlocConsumer<HappinessIndexScreenBloc, HappinessIndexScreenState>(
      bloc: _happinessIndexScreenBloc,
      listener: (_, state) {
        if (state.happinessIndexState is SuccessOnSaveHappinessIndexState) {
          Modular.to.pop();
        }
      },
      builder: (context, state) {
        if (state.retrieveAllReasonsState is LoadingRetrieveAllReasonsState) {
          return const Expanded(
            child: WaapiLoadingWidget(),
          );
        }

        return Expanded(
          child: Scaffold(
            backgroundColor: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
            body: Scrollbar(
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconHeaderWidget(
                          title: context.translate.howsYourMoodToday,
                          icon: FontAwesomeIcons.solidHandHoldingHeart,
                          removeHorizontalPadding: true,
                        ),
                        SizedBox(
                          height: SeniorSpacing.xxhuge,
                          child: Center(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final mood = HappinessIndexMoodEnum.values[index];
                                return Center(
                                  child: HappinessIndexMoodWidget(
                                    size: SeniorIconSize.big,
                                    iconSize: SeniorIconSize.large,
                                    mood: mood,
                                    isSelected: selectedMood == mood,
                                    isDefined: selectedMood == mood,
                                    onSelectedMood: (mood) {
                                      selectedMood = mood;
                                      setState(() {});
                                    },
                                    showBadgeOnMood: selectedMood == mood,
                                    disabled: !(selectedMood == mood),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: SeniorSpacing.normal,
                                );
                              },
                              itemCount: HappinessIndexMoodEnum.values.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: SeniorSpacing.normal,
                        ),
                        SeniorText.cta(context.translate.whyFeelingHappinessIndex),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            bottom: context.bottomSize,
                          ),
                          itemCount: state.retrieveAllReasonsState.groupList.length,
                          itemBuilder: (_, index) {
                            return HappinessIndexShowReasonsWidget(
                              groupReasons: state.retrieveAllReasonsState.groupList[index],
                              reasons: reasons,
                              canSelect: true,
                            );
                          },
                        ),
                        const SizedBox(
                          height: SeniorSpacing.normal,
                        ),
                        SeniorTextField(
                          controller: notes,
                          label: context.translate.todaysNote,
                          maxLength: 255,
                          maxLines: 3,
                          counterText: context.translate.characters,
                          showCounterText: true,
                          style: SeniorTextFieldStyle(
                            borderColor: SeniorColors.grayscale60,
                            textColor: theme.textFieldTheme!.style!.textColor,
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: SeniorSpacing.normal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: EmployeeBottomSheetWidget(
              seniorButtons: [
                SeniorText.small(
                  context.translate.anonymouslySharedHappinessIndex,
                ),
                const SizedBox(
                  height: SeniorSpacing.normal,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SeniorSpacing.normal,
                  ),
                  child: SeniorButton(
                    label: context.translate.save,
                    busy: state.happinessIndexState is LoadingHappinessIndexState,
                    disabled: state.happinessIndexState is LoadingHappinessIndexState,
                    onPressed: () {
                      _happinessIndexScreenBloc.happinessIndexBloc.add(
                        SaveHappinessIndexEvent(
                          mood: selectedMood,
                          language: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                          notes: notes.text,
                          reasons: reasons.map((e) => e.id!).toList(),
                        ),
                      );
                    },
                    fullWidth: true,
                  ),
                ),
              ],
              horizontalPadding: false,
            ),
          ),
        );
      },
    );
  }
}
