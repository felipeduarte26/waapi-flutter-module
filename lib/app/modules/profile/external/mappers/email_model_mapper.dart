import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_personal_contact_email_input_model.dart';
import '../../enums/email_type_enum.dart';
import '../../infra/models/email_model.dart';

class EmailModelMapper {
  EmailModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmailModel(
      id: map['id'],
      email: map['email'],
      employeeId: map['employeeId'],
      type: EnumHelper<EmailTypeEnum>().stringToEnum(
        stringToParse: map['type'],
        values: EmailTypeEnum.values,
      ),
    );
  }

  Map<String, dynamic> toMap({
    required EditPersonalContactEmailInputModel editPersonalContactEmailInputModel,
  }) {
    final map = {
      'id': editPersonalContactEmailInputModel.id,
      'type': editPersonalContactEmailInputModel.type,
      'originalType': editPersonalContactEmailInputModel.originalType,
      'email': editPersonalContactEmailInputModel.email,
    };

    if (editPersonalContactEmailInputModel.personRequestUpdateType != null) {
      map.addAll(
        {'personRequestUpdateType': editPersonalContactEmailInputModel.personRequestUpdateType!},
      );
    }

    return map;
  }
}
