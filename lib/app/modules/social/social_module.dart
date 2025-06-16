import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/social_routers.dart';
import 'binds/social_domain_binds.dart';
import 'binds/social_external_binds.dart';
import 'binds/social_infra_binds.dart';
import 'binds/social_presenter_binds.dart';
import 'presenter/bloc/social_space_feed/social_space_feed_bloc.dart';
import 'presenter/bloc/social_space_feed/social_space_feed_event.dart';
import 'presenter/bloc/social_tag_feed/social_tag_feed_bloc.dart';
import 'presenter/bloc/social_tag_feed/social_tag_feed_event.dart';
import 'presenter/screen/social_answers/social_answers_screen.dart';
import 'presenter/screen/social_comments/social_comments_screen.dart';
import 'presenter/screen/social_list_members/social_list_members_screen.dart';
import 'presenter/screen/social_profile/social_profile_screen.dart';
import 'presenter/screen/social_search/social_search_screen.dart';
import 'presenter/screen/social_space/social_private_space_screen.dart';
import 'presenter/screen/social_space/social_space_screen.dart';
import 'presenter/screen/social_tag/social_tag_screen.dart';

class SocialModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...SocialDomainBinds.binds,
      ...SocialExternalBinds.binds,
      ...SocialInfraBinds.binds,
      ...SocialPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        SocialRouters.socialCommentsScreenRoute,
        child: (_, args) {
          return SocialCommentsScreen(
            post: args.data['post'],
            onLikeChanged: args.data['onLikeChanged'],
            socialScreenBloc: args.data['socialScreenBloc'],
            openWithFocus: args.data['openWithFocus'],
          );
        },
      ),
      ChildRoute(
        SocialRouters.socialAnswersScreenRoute,
        child: (_, args) {
          return SocialAnswersScreen(
            comment: args.data['comment'],
            urls: args.data['urls'],
            socialScreenBloc: args.data['socialScreenBloc'],
            postId: args.data['postId'],
          );
        },
      ),
      ChildRoute(
        SocialRouters.socialListMembersScreenRoute,
        child: (_, args) {
          return SocialListMembersScreen(
            socialScreenBloc: args.data['socialScreenBloc'],
            postId: args.data['postId'],
          );
        },
      ),
      ChildRoute(
        SocialRouters.socialSearchScreenRoute,
        child: (_, args) {
          return const SocialSearchScreen();
        },
      ),
      ChildRoute(
        SocialRouters.socialProfileRoute,
        child: (_, args) {
          return SocialProfileScreen(
            permaname: args.data['permaname'],
          );
        },
      ),
      ChildRoute(
        SocialRouters.socialSpaceRoute,
        child: (_, args) {
          (args.data['socialSpaceFeedBloc'] as SocialSpaceFeedBloc).add(
            GetSocialSpaceFeedEvent(
              spacePermaname: args.data['permaname'],
              since: DateTime.now(),
            ),
          );
          return SocialSpaceScreen(
            permaname: args.data['permaname'],
            socialSpaceFeedBloc: args.data['socialSpaceFeedBloc'],
          );
        },
      ),
      ChildRoute(
        SocialRouters.socialPrivateSpaceRoute,
        child: (_, args) {
          return SocialPrivateSpaceScreen(
            space: args.data['space'],
          );
        },
      ),
      ChildRoute(
        SocialRouters.socialTagRoute,
        child: (_, args) {
          (args.data['socialTagFeedBloc'] as SocialTagFeedBloc).add(
            GetSocialTagFeedEvent(
              tag: args.data['tag'],
              since: DateTime.now(),
            ),
          );
          return SocialTagScreen(
            tag: args.data['tag'],
            socialTagFeedBloc: args.data['socialTagFeedBloc'],
          );
        },
      ),
    ];
  }
}
