import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../../core/extension/color_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/icons_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/helper/scroll_helper.dart';
import '../../../../../../core/pagination/pagination_requirements.dart';

import '../../../../../../core/widgets/feedback_card_widget.dart';
import '../../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/profile_routes.dart';
import '../../../blocs/public_feedbacks_bloc/public_feedbacks_event.dart';
import '../../../blocs/public_feedbacks_bloc/public_feedbacks_state.dart';
import '../../../blocs/public_profile_bloc/public_profile_state.dart';
import '../bloc/public_profile_screen_bloc.dart';

class PublicProfileFeedbacksListViewWidget extends StatefulWidget {
  final ScrollController scrollController;
  final PublicProfileScreenBloc publicProfileScreenBloc;

  const PublicProfileFeedbacksListViewWidget({
    Key? key,
    required this.scrollController,
    required this.publicProfileScreenBloc,
  }) : super(key: key);

  @override
  State<PublicProfileFeedbacksListViewWidget> createState() {
    return _PublicProfileFeedbacksListViewWidgetState();
  }
}

class _PublicProfileFeedbacksListViewWidgetState extends State<PublicProfileFeedbacksListViewWidget> {
  int nextPage = 2;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final publicProfileFeedbacksState = widget.publicProfileScreenBloc.publicFeedbacksBloc.state;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: publicProfileFeedbacksState.publicFeedbacks!.length + 1,
        (context, index) {
          if (index == publicProfileFeedbacksState.publicFeedbacks!.length) {
            return Column(
              children: [
                Offstage(
                  key: const Key('profile-public_profile_screen-feedbacks-circular_progress-load_more'),
                  offstage: publicProfileFeedbacksState is! LoadingMorePublicFeedbacksState,
                  child: const Padding(
                    padding: EdgeInsets.all(SeniorSpacing.normal),
                    child: WaapiLoadingWidget(
                      waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    ),
                  ),
                ),
              ],
            );
          }

          final feedback = publicProfileFeedbacksState.publicFeedbacks![index];

          return Container(
            margin: const EdgeInsets.only(
              left: SeniorSpacing.xxxsmall,
              right: SeniorSpacing.xxxsmall,
              top: SeniorSpacing.small,
            ),
            child: FeedbackCardWidget(
              disabled: false,
              onTap: () async {
                Modular.to.pushNamed(
                  ProfileRoutes.publicProfileFeedbackScreenInitialRoute,
                  arguments: feedback,
                );
              },
              key: Key(
                'profile-public_profile_screen-feedbacks-list_view-card-$index',
              ),
              imageUrl: feedback.fromPhotoUrl,
              userName: feedback.fromName,
              feedbackDate: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: feedback.when,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Localizations.localeOf(context),
                ),
              ),
              feedbackMessage: feedback.message,
              seniorRating: feedback.proficiency != null
                  ? null
                  : SeniorRating(
                      key: Key(
                        'profile-public_profile_screen-feedbacks-list_view-card-rating_proficiency-$index-stars_indicator',
                      ),
                      itemCount: 5,
                      initialRating: feedback.starCount.toDouble(),
                      onRatingUpdate: (_) {},
                      ignoreGestures: true,
                    ),
              proficiencyTagWidget: feedback.proficiency == null
                  ? null
                  : ProficiencyTagWidget(
                      key: Key(
                        'profile-public_profile_screen-feedbacks-list_view-card-rating_proficiency-$index-proficiency_indicator',
                      ),
                      label: feedback.proficiency!.name,
                      color: ColorExtension.fromHex(
                        hexString: feedback.proficiency!.color,
                      ),
                      icon: IconsHelper.parseProficiencyIconName(
                        proficiencyIconName: feedback.proficiency!.icon,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    final publicFeedbacksState = widget.publicProfileScreenBloc.publicFeedbacksBloc.state;

    if (publicFeedbacksState is! LoadingMorePublicFeedbacksState &&
        ScrollHelper.reachedListEnd(scrollController: widget.scrollController)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _loadMoreFeedbacks();
      });
    }
  }

  void _loadMoreFeedbacks() {
    final publicProfileState = widget.publicProfileScreenBloc.state.publicProfileState;
    final publicFeedbacksState = widget.publicProfileScreenBloc.publicFeedbacksBloc.state;

    if (publicFeedbacksState is LoadingMorePublicFeedbacksState ||
        publicFeedbacksState is LoadingPublicFeedbacksState) {
      return;
    }

    if (publicProfileState is LoadedPublicProfileState) {
      widget.publicProfileScreenBloc.publicFeedbacksBloc.add(
        GetPublicFeedbacksEvent(
          employeeId: publicProfileState.publicProfileEntity.personId,
          paginationRequirements: PaginationRequirements(
            page: nextPage,
            limit: 10,
          ),
        ),
      );
      nextPage++;
    }
  }
}
