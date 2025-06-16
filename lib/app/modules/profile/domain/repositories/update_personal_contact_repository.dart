import '../input_models/edit_personal_contact_input_model.dart';
import '../types/profile_domain_types.dart';

abstract class UpdatePersonalContactRepository {
  UpdatePersonalContactUsecaseCallback call({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  });
}
