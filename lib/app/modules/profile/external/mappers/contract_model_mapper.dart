import '../../infra/models/contract_model.dart';
import 'email_model_mapper.dart';
import 'phone_contact_model_mapper.dart';

class ContractModelMapper {
  final PhoneContactModelMapper _phoneContactModelMapper;
  final EmailModelMapper _emailModelMapper;

  const ContractModelMapper({
    required PhoneContactModelMapper phoneContactModelMapper,
    required EmailModelMapper emailModelMapper,
  })  : _phoneContactModelMapper = phoneContactModelMapper,
        _emailModelMapper = emailModelMapper;

  ContractModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return ContractModel(
      departament: map['departament'],
      employeeId: map['employeeId'],
      jobPosition: map['jobPosition'],
      phoneContact: map['phoneContact'] == null
          ? null
          : (map['phoneContact'] as List).map(
              (emailMap) {
                return _phoneContactModelMapper.fromMap(
                  map: emailMap,
                );
              },
            ).toList(),
      emails: map['emails'] == null
          ? null
          : (map['emails'] as List).map(
              (emailMap) {
                return _emailModelMapper.fromMap(
                  map: emailMap,
                );
              },
            ).toList(),
    );
  }
}
