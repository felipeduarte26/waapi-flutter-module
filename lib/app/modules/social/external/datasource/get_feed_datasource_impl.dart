import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_feed_datasource.dart';
import '../../infra/models/social_feed_model.dart';
import '../mappers/social_feed_model_mapper.dart';

class GetFeedDatasourceImpl implements GetFeedDatasource {
  final RestService _restService;
  final SocialFeedModelMapper _feedMapper;

  GetFeedDatasourceImpl({
    required RestService restService,
    required SocialFeedModelMapper feedMapper,
  })  : _restService = restService,
        _feedMapper = feedMapper;

  @override
  Future<SocialFeedModel> call({
    required String nextCursor,
    required PaginationRequirements paginationRequirements,
    required DateTime since,
    String? space,
    String? tag,
  }) async {
    final formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(since.toUtc());
    final String encodedDateTime = Uri.encodeComponent(formattedDate);
    final String nextCursorFormatted = nextCursor.isEmpty ? '' : '&nextCursor=$nextCursor';

    String path = '/queries/getFeed?size=${paginationRequirements.page}&since=$encodedDateTime$nextCursorFormatted';

    if (space != null) {
      path += '&space=$space';
    }

    if (tag != null) {
      path += '&tag=$tag';
    }

    final response = await _restService.socialService().get(
          path,
        );

    final feedDecode = jsonDecode(
      response.data!,
    );

    final SocialFeedModel feed = _feedMapper.fromMap(
      feedMap: feedDecode,
    );

    return feed;
  }
}
