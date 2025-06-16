import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/share_post_for_member_datasource.dart';

class SharePostForMemberDatasourceImpl implements SharePostForMemberDatasource {
  final RestService _restService;

  SharePostForMemberDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String postId,
    required String memberId,
  }) async {
    await _restService.socialService().post(
      '/actions/sharePostForMember',
      body: {
        'postId': postId,
        'memberId': memberId,
      },
    );
  }
}
