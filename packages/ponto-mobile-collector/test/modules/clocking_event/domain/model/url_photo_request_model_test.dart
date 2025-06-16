import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'UrlPhotoRequestModel test.',
    () {
      UrlPhotoRequestModel model = UrlPhotoRequestModel(
        uploadType: 'uploadType',
        employeeId: 'employeeId',
        photoNames: ['photoNames'],
      );

      expect(model.employeeId, 'employeeId');
      expect(model.photoNames, ['photoNames']);
      expect(model.uploadType, 'uploadType');
    },
  );
}
