import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/visa_type_enum.dart';
import '../../infra/models/visa_model.dart';

class VisaModelMapper {
  VisaModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return VisaModel(
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      number: map['number'],
      expiryDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['expiryDate'],
      ),
      visaType: EnumHelper<VisaTypeEnum>().stringToEnum(
        stringToParse: map['visaType'],
        values: VisaTypeEnum.values,
      ),
    );
  }
}
