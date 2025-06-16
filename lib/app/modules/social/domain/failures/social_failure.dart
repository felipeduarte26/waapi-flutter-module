import '../../../../core/failures/failure.dart';

abstract class SocialFailure extends Failure {}

class SocialDatasourceFailure extends SocialFailure {}

class SocialUploadFailure extends SocialFailure {}

class SocialRequestFileUploadFailure extends SocialFailure {}

class SocialDriverFailure extends SocialFailure {}

class SocialGetPostLikesFailure extends SocialFailure{}

class SocialSearchFailure extends SocialFailure {}
