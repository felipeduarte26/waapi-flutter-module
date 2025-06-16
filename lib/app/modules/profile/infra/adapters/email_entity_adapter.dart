import '../../domain/entities/email_entity.dart';
import '../models/email_model.dart';

class EmailEntityAdapter {
  EmailEntity fromModel({
    required EmailModel emailModel,
  }) {
    return EmailEntity(
      id: emailModel.id,
      email: emailModel.email,
      employeeId: emailModel.employeeId,
      type: emailModel.type,
    );
  }
}
