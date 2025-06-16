import '../models/feature_control_authorization_model.dart';

abstract class FeatureControlAuthorizationsDatasource {
  Future<FeatureControlAuthorizationModel> call();
}
