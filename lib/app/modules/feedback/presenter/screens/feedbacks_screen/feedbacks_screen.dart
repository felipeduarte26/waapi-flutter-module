import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../blocs/feedback_requests_bloc/feedback_requests_event.dart';
import '../../blocs/received_feedbacks_bloc/received_feedbacks_event.dart';
import '../../blocs/sent_feedbacks_bloc/sent_feedbacks_event.dart';
import 'bloc/feedbacks_screen_bloc.dart';
import 'widgets/feedback_requests_tab_content_widget.dart';
import 'widgets/received_feedbacks_tab_content_widget.dart';
import 'widgets/sent_feedbacks_tab_content_widget.dart';

class FeedbacksScreen extends StatefulWidget {
  final FeedbacksScreenBloc _feedbacksScreenBloc;

  const FeedbacksScreen({
    Key? key,
    required FeedbacksScreenBloc feedbacksScreenBloc,
  })  : _feedbacksScreenBloc = feedbacksScreenBloc,
        super(key: key);

  @override
  State<FeedbacksScreen> createState() {
    return _FeedbacksScreenState();
  }
}

class _FeedbacksScreenState extends State<FeedbacksScreen> with SingleTickerProviderStateMixin {
  late final AuthorizationEntity _authorizationEntity;
  final PageController _pageController = PageController();
  bool _alreadyOnReceivedFeedbacks = false;
  bool _alreadyOnSentFeedbacks = false;
  bool _alreadyOnRequestsFeedbacks = false;
  bool showFeedbackReceived = true;
  bool showSentFeedbacks = false;
  bool showRequestsFeedbacks = false;
  int tabIndex = 0;
  final _scroolController = ScrollController(
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
    _authorizationEntity =
        (widget._feedbacksScreenBloc.authorizationBloc.state as LoadedAuthorizationState).authorizationEntity;
    _handleTabSelection();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scroolController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_alreadyOnReceivedFeedbacks && showFeedbackReceived) {
      _alreadyOnReceivedFeedbacks = true;
      widget._feedbacksScreenBloc.receivedFeedbacksBloc.add(
        GetReceivedFeedbacksEvent(
          paginationRequirements: const PaginationRequirements(
            page: 1,
          ),
        ),
      );
    }

    if (!_alreadyOnSentFeedbacks && showSentFeedbacks) {
      _alreadyOnSentFeedbacks = true;
      widget._feedbacksScreenBloc.sentFeedbacksBloc.add(
        GetSentFeedbacksEvent(
          paginationRequirements: const PaginationRequirements(
            page: 1,
          ),
        ),
      );
    }

    if (!_alreadyOnRequestsFeedbacks && showRequestsFeedbacks) {
      _alreadyOnRequestsFeedbacks = true;
      widget._feedbacksScreenBloc.feedbackRequestsBloc.add(GetFeedbackRequestsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [];
    if (_authorizationEntity.allowToViewMyFeedbacks) {
      tabs.add(context.translate.feedbackReceivedTab);
      tabs.add(context.translate.feedbackSentTab);
    }

    if (_authorizationEntity.allowToViewMyFeedbacksRequests) {
      tabs.add(context.translate.feedbackRequestsTab);
    }

    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.feedbackSubmitted,
        scrollController: _scroolController,
        tabBarConfig: _tabBarConfig(
          tabs: tabs,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    _onSelect(value);
                  });
                },
                controller: _pageController,
                children: [
                  _authorizationEntity.allowToViewMyFeedbacks
                      ? const ReceivedFeedbacksTabContentWidget(
                          key: Key('feedback-feedback_screen-feedbacks_received-screen'),
                        )
                      : const SizedBox.shrink(),
                  _authorizationEntity.allowToViewMyFeedbacks
                      ? const SentFeedbacksTabContentWidget(
                          key: Key('feedback-feedback_screen-feedbacks_sent-screen'),
                        )
                      : const SizedBox.shrink(),
                  _authorizationEntity.allowToViewMyFeedbacksRequests
                      ? const FeedbackRequestsTabContentWidget(
                          key: Key('feedback-feedback_screen-feedbacks_requests-screen'),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _onSelect(int newValue) {
    if (newValue == 0) {
      setState(() {
        showFeedbackReceived = true;
        showSentFeedbacks = false;
        showRequestsFeedbacks = false;
        _pageController.jumpToPage(0);
        _handleTabSelection();
      });
    }

    if (newValue == 1) {
      setState(() {
        showFeedbackReceived = false;
        showSentFeedbacks = true;
        showRequestsFeedbacks = false;
        _pageController.jumpToPage(1);
        _handleTabSelection();
      });
    }

    if (newValue == 2) {
      setState(() {
        showFeedbackReceived = false;
        showSentFeedbacks = false;
        showRequestsFeedbacks = true;
        _pageController.jumpToPage(2);
        _handleTabSelection();
      });
    }
    tabIndex = newValue;
  }

  TabBarConfig _tabBarConfig({
    required List<String> tabs,
  }) {
    return TabBarConfig(
      tabs: tabs,
      onSelect: _onSelect,
      tabIndex: tabIndex,
    );
  }
}
