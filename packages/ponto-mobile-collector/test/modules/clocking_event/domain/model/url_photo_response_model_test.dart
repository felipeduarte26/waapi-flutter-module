import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test('UrlPhotoResponseModel test.', () {
    UrlPhotoResponseModel model =
        UrlPhotoResponseModel(uploadUrls: ['uploadUrls']);

    expect(model.uploadUrls, ['uploadUrls']);
  });
}
