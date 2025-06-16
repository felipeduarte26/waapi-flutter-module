import '../models/hyperlink_model.dart';

abstract class GetHyperlinksDatasource {
  Future<List<HyperlinkModel>> call({
    required String employeeId,
    required String userRoleId,
  });
}
