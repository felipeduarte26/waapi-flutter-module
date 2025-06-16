import '../../../../core/enums/brazilian_state_enum.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/cnh_category_enum.dart';
import '../../infra/models/cnh_model.dart';

class CnhModelMapper {
  CnhModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return CnhModel(
      number: map['number'],
      issuer: map['issuer'],
      category: EnumHelper<CnhCategoryEnum>().stringToEnum(
        stringToParse: map['category'],
        values: CnhCategoryEnum.values,
      ),
      issuerState: EnumHelper<BrazilianStateEnum>().stringToEnum(
        stringToParse: map['issuerState'],
        values: BrazilianStateEnum.values,
      ),
      expiryDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['expiryDate'],
      ),
      firstIssuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['firstIssuedDate'],
      ),
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
    );
  }
}
