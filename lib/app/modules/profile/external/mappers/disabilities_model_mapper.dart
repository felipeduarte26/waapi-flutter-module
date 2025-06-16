import '../../infra/models/disabilities_model.dart';
import 'disability_model_mapper.dart';

class DisabilitiesModelMapper {
  DisabilitiesModel fromMap({
    required Map<String, dynamic> map,
    required bool rehabilitation,
  }) {
    return DisabilitiesModel(
      id: map['id'],
      disability: map['disability'] != null
          ? DisabilityModelMapper().fromMap(
              map: map['disability'],
            )
          : null,
      isRehabilitated: map['isRehabilitated'] is bool ? map['isRehabilitated'] : false,
      mainDisability: map['mainDisability'] is bool ? map['mainDisability'] : false,
      rehabilitation: rehabilitation,
    );
  }

  Map<String, dynamic> toMap({
    required DisabilitiesModel disabilitiesModel,
  }) {
    return {
      'id': disabilitiesModel.id,
      'mainDisability': disabilitiesModel.mainDisability,
      'disability': DisabilityModelMapper().toMap(
        disabilityModel: disabilitiesModel.disability!,
      ),
    };
  }
}
