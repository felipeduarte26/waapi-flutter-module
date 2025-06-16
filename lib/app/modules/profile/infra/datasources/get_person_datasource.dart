import '../models/profile_person_model.dart';

abstract class GetPersonDatasource {
  Future<ProfilePersonModel> call({
    required String personId,
  });
}
