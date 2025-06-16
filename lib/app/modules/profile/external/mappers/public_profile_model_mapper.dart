import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../../feedback/external/mappers/feedback_model_mapper.dart';
import '../../enums/gender_type_enum.dart';
import '../../infra/models/public_profile_model.dart';
import 'email_model_mapper.dart';
import 'emergencial_contact_model_mapper.dart';

class PublicProfileModelMapper {
  final EmailModelMapper _emailModelMapper;
  final FeedbackModelMapper _feedbackModelMapper;
  final EmergencialContactModelMapper _emergencialContactModelMapper;
  final EnumHelper<GenderTypeEnum> _enumHelper;

  const PublicProfileModelMapper({
    required EmailModelMapper emailModelMapper,
    required FeedbackModelMapper feedbackModelMapper,
    required EmergencialContactModelMapper emergencialContactModelMapper,
    required EnumHelper<GenderTypeEnum> enumHelper,
  })  : _emailModelMapper = emailModelMapper,
        _feedbackModelMapper = feedbackModelMapper,
        _emergencialContactModelMapper = emergencialContactModelMapper,
        _enumHelper = enumHelper;

  PublicProfileModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PublicProfileModel(
      name: map['profile']['name'] ?? '',
      photoUrl: map['profile']['linkPhoto'] ?? '',
      showBirthday: map['profile']['showBirthday'] ?? false,
      birthDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['profile']['birthDate'],
      ),
      department: map['publicProfessionalProfile']['contracts'] != null &&
              (map['publicProfessionalProfile']['contracts'] as List).isNotEmpty
          ? (map['publicProfessionalProfile']['contracts'] as List).first['departament']
          : null,
      jobPosition: map['publicProfessionalProfile']['contracts'] != null &&
              (map['publicProfessionalProfile']['contracts'] as List).isNotEmpty
          ? (map['publicProfessionalProfile']['contracts'] as List).first['jobPosition']
          : null,
      emails: map['publicProfessionalProfile']['contracts'] != null &&
              (map['publicProfessionalProfile']['contracts'] as List).isNotEmpty &&
              (map['publicProfessionalProfile']['contracts'] as List).first.containsKey('emails')
          ? ((map['publicProfessionalProfile']['contracts'] as List).first['emails'] as List)
              .map(
                (emailMap) => _emailModelMapper.fromMap(
                  map: emailMap,
                ),
              )
              .toList()
          : null,
      gender: _enumHelper.stringToEnum(
        stringToParse: map['profile']['gender'],
        values: GenderTypeEnum.values,
      ),
      personId: map['publicProfessionalProfile']['id'] ?? '',
      profileSummary: map['professionalProfile']['profileSummary'],
      feedbacks: map['feedbacks'] != null && (map['feedbacks']['list'] as List).isNotEmpty
          ? (map['feedbacks']['list'] as List).map((e) {
              return _feedbackModelMapper.fromMap(map: e);
            }).toList()
          : [],
      emergencialContact:
          map['profile']['emergencialContacts'] != null && (map['profile']['emergencialContacts'] as List).isNotEmpty
              ? (map['profile']['emergencialContacts'] as List).map((e) {
                  return _emergencialContactModelMapper.fromMap(map: e);
                }).toList()
              : [],
    );
  }

  PublicProfileModel fromJson({
    required String publicProfileJson,
  }) {
    return fromMap(
      map: json.decode(publicProfileJson),
    );
  }
}
