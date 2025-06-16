import '../../infra/models/nationality_model.dart';

class NationalityModelMapper {
  NationalityModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return NationalityModel(
      id: map['id'],
      code: map['code'] is int ? map['code'] : null,
      name: map['name'],
    );
  }
}
