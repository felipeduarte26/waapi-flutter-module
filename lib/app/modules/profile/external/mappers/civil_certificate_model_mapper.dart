import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/civil_certificate_type_enum.dart';
import '../../infra/models/civil_certificate_model.dart';
import 'city_model_mapper.dart';

class CivilCertificateModelMapper {
  final CityModelMapper _cityModelMapper;

  const CivilCertificateModelMapper({
    required CityModelMapper cityModelMapper,
  }) : _cityModelMapper = cityModelMapper;

  CivilCertificateModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return CivilCertificateModel(
      id: map['id'],
      certificateType: EnumHelper<CivilCertificateTypeEnum>().stringToEnum(
        stringToParse: map['certificateType'],
        values: CivilCertificateTypeEnum.values,
      ),
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      enrollment: map['enrollment'],
      termNumber: map['termNumber'],
      bookNumber: map['bookNumber'],
      paperNumber: map['paperNumber'],
      registryName: map['registryName'],
      registryNumber: map['registryNumber'],
      city: map['city'] != null
          ? _cityModelMapper.fromMap(
              map: map['city'],
            )
          : null,
    );
  }
}
