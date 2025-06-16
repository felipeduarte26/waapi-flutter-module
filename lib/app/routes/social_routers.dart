abstract class SocialRouters {
  // Module route name
  static const String socialModuleRoute = '/social';

  // Social screen routes name
  static const String socialScreenRoute = '/';
  static const String socialScreenInitialRoute = '$socialModuleRoute$socialScreenRoute';

  // Social comments screen routes name
  static const String socialCommentsScreenRoute = '/comments';
  static const String socialCommentsScreenInitialRoute = '$socialModuleRoute$socialCommentsScreenRoute';

  // Social answers screen routes name
  static const String socialAnswersScreenRoute = '/answers';
  static const String socialAnswersScreenInitialRoute = '$socialModuleRoute$socialAnswersScreenRoute';

  // Social list members screen routes name
  static const String socialListMembersScreenRoute = '/members';
  static const String socialListMembersScreenInitialRoute = '$socialModuleRoute$socialListMembersScreenRoute';

  // Social search routes
  static const String socialSearchScreenRoute = '/search';
  static const String socialSearchScreenInitialRoute = '$socialModuleRoute$socialSearchScreenRoute';

  // Social profile routes
  static const String socialProfileRoute = '/profile';
  static const String socialProfileInitialRoute = '$socialModuleRoute$socialProfileRoute';

  // Social space routes
  static const String socialSpaceRoute = '/space';
  static const String socialSpaceInitialRoute = '$socialModuleRoute$socialSpaceRoute';

  // Social private space routes
  static const String socialPrivateSpaceRoute = '/private_space';
  static const String socialPrivateSpaceInitialRoute = '$socialModuleRoute$socialPrivateSpaceRoute';

  // Social tag routes
  static const String socialTagRoute = '/tag';
  static const String socialTagInitialRoute = '$socialModuleRoute$socialTagRoute';
}
