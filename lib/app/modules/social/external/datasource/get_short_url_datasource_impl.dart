import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_short_url_datasource.dart';

class GetShortUrlDatasourceImpl implements GetShortUrlDatasource {
  final RestService _restService;

  GetShortUrlDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<Map<String, String>> call({
    required List<String> listUrl,
  }) async {
    Map<String, String> mapUrlShorterner = {};
    for (var url in listUrl) {
      if (!url.contains('https://snr')) {
        final response = await _restService.socialService().post(
          '/actions/getShortUrl',
          body: {
            'textIn': url,
          },
        );
        final urlDecode = jsonDecode(
          response.data!,
        );
        mapUrlShorterner[url] = urlDecode['textOut'];
      }
    }

    return mapUrlShorterner;
  }
}
