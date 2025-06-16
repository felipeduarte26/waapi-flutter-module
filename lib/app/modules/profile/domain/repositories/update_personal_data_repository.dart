import '../input_models/edit_personal_data_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalDataRepository {
  UpdatePersonalDataUsecaseCallback call({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  });
}
