import '../models/sexual_orientation_model.dart';

abstract class GetSexualOrientationDatasource {
  Future<List<SexualOrientationModel>> call();
}
