import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../infra/models/profile_model.dart';
import 'address_model_mapper.dart';
import 'bank_account_model_mapper.dart';
import 'city_model_mapper.dart';
import 'civil_certificate_model_mapper.dart';
import 'cnh_model_mapper.dart';
import 'contract_model_mapper.dart';
import 'ctps_model_mapper.dart';
import 'disabilities_model_mapper.dart';
import 'email_model_mapper.dart';
import 'emergencial_contact_model_mapper.dart';
import 'nationality_model_mapper.dart';
import 'nis_model_mapper.dart';
import 'passport_model_mapper.dart';
import 'personal_request_update_mapper.dart';
import 'phone_contact_model_mapper.dart';
import 'reservist_certificate_model_mapper.dart';
import 'rg_model_mapper.dart';
import 'ric_model_mapper.dart';
import 'rne_model_mapper.dart';
import 'social_network_model_mapper.dart';
import 'visa_model_mapper.dart';
import 'voter_registration_model_mapper.dart';

class ProfileModelMapper {
  final BankAccountModelMapper _bankAccountModelMapper;
  final ContractModelMapper _contractModelMapper;
  final CivilCertificateModelMapper _civilCertificateModelMapper;
  final PhoneContactModelMapper _phoneContactModelMapper;
  final EmailModelMapper _emailModelMapper;
  final EmergencialContactModelMapper _emergencialContactModelMapper;
  final SocialNetworkModelMapper _socialNetworkModelMapper;
  final CtpsModelMapper _ctpsModelMapper;
  final AddressModelMapper _addressModelMapper;
  final NisModelMapper _nisModelMapper;
  final PassportModelMapper _passportModelMapper;
  final NationalityModelMapper _nationalityModelMapper;
  final CityModelMapper _cityModelMapper;
  final ReservistCertificateModelMapper _reservistCertificateModelMapper;
  final RgModelMapper _rgModelMapper;
  final RicModelMapper _ricModelMapper;
  final RneModelMapper _rneModelMapper;
  final VisaModelMapper _visaModelMapper;
  final VoterRegistrationModelMapper _voterRegistrationModelMapper;
  final DisabilitiesModelMapper _disabilitiesModelMapper;
  final PersonalRequestUpdateMapper _personalRequestUpdateMapper;
  final PersonalRequestUpdateMapper _addressRequestUpdateMapper;
  final PersonalRequestUpdateMapper _contactRequestUpdateMapper;
  final PersonalRequestUpdateMapper _documentRequestUpdateMapper;

  const ProfileModelMapper({
    required BankAccountModelMapper bankAccountModelMapper,
    required ContractModelMapper contractModelMapper,
    required CivilCertificateModelMapper civilCertificateModelMapper,
    required PhoneContactModelMapper phoneContactModelMapper,
    required EmailModelMapper emailModelMapper,
    required EmergencialContactModelMapper emergencialContactModelMapper,
    required SocialNetworkModelMapper socialNetworkModelMapper,
    required CtpsModelMapper ctpsModelMapper,
    required AddressModelMapper addressModelMapper,
    required NisModelMapper nisModelMapper,
    required PassportModelMapper passportModelMapper,
    required NationalityModelMapper nationalityModelMapper,
    required CityModelMapper cityModelMapper,
    required ReservistCertificateModelMapper reservistCertificateModelMapper,
    required RgModelMapper rgModelMapper,
    required RicModelMapper ricModelMapper,
    required RneModelMapper rneModelMapper,
    required VisaModelMapper visaModelMapper,
    required VoterRegistrationModelMapper voterRegistrationModelMapper,
    required DisabilitiesModelMapper disabilitiesModelMapper,
    required PersonalRequestUpdateMapper personalRequestUpdateMapper,
    required PersonalRequestUpdateMapper addressRequestUpdateMapper,
    required PersonalRequestUpdateMapper contactRequestUpdateMapper,
    required PersonalRequestUpdateMapper documentRequestUpdateMapper,
  })  : _bankAccountModelMapper = bankAccountModelMapper,
        _contractModelMapper = contractModelMapper,
        _civilCertificateModelMapper = civilCertificateModelMapper,
        _phoneContactModelMapper = phoneContactModelMapper,
        _emailModelMapper = emailModelMapper,
        _emergencialContactModelMapper = emergencialContactModelMapper,
        _socialNetworkModelMapper = socialNetworkModelMapper,
        _ctpsModelMapper = ctpsModelMapper,
        _addressModelMapper = addressModelMapper,
        _nisModelMapper = nisModelMapper,
        _passportModelMapper = passportModelMapper,
        _nationalityModelMapper = nationalityModelMapper,
        _cityModelMapper = cityModelMapper,
        _reservistCertificateModelMapper = reservistCertificateModelMapper,
        _rgModelMapper = rgModelMapper,
        _ricModelMapper = ricModelMapper,
        _rneModelMapper = rneModelMapper,
        _visaModelMapper = visaModelMapper,
        _voterRegistrationModelMapper = voterRegistrationModelMapper,
        _disabilitiesModelMapper = disabilitiesModelMapper,
        _personalRequestUpdateMapper = personalRequestUpdateMapper,
        _addressRequestUpdateMapper = addressRequestUpdateMapper,
        _contactRequestUpdateMapper = contactRequestUpdateMapper,
        _documentRequestUpdateMapper = documentRequestUpdateMapper;

  ProfileModel fromMap({
    required Map<String, dynamic> map,
    required String employeeId,
  }) {
    return ProfileModel(
      linkPhoto: map['linkPhoto'],
      name: map['name'],
      cpf: map['cpf'],
      educationDegreeName: map['educationDegreeName'],
      showBirthday: map['showBirthday'],
      liveBirthDeclaration: map['liveBirthDeclaration'],
      nationalHealthCard: map['nationalHealthCard'],
      birthDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['birthDate'],
      ),
      bankAccount: map['bankAccounts'] == null || (map['bankAccounts'] as List).isEmpty
          ? null
          : _bankAccountModelMapper.fromMap(
              map: (map['bankAccounts'] as List).first,
            ),
      contract: map['contracts'] == null || (map['contracts'] as List).isEmpty
          ? null
          : _contractModelMapper.fromMap(
              map: (map['contracts'] as List).firstWhere((contract) {
                return contract['employeeId'] == employeeId;
              }),
            ),
      cnh: map['cnh'] != null
          ? CnhModelMapper().fromMap(
              map: map['cnh'],
            )
          : null,
      civilCertificates: map['civilCertificates'] == null
          ? null
          : (map['civilCertificates'] as List).map(
              (civilCertificate) {
                return _civilCertificateModelMapper.fromMap(
                  map: civilCertificate,
                );
              },
            ).toList(),
      contacts: map['contacts'] == null
          ? null
          : (map['contacts'] as List).map(
              (contact) {
                return _phoneContactModelMapper.fromMap(
                  map: contact,
                );
              },
            ).toList(),
      emails: map['emails'] == null
          ? null
          : (map['emails'] as List).map(
              (email) {
                return _emailModelMapper.fromMap(
                  map: email,
                );
              },
            ).toList(),
      emergencialContacts: map['emergencialContacts'] == null
          ? null
          : (map['emergencialContacts'] as List).map(
              (emergencialContact) {
                return _emergencialContactModelMapper.fromMap(
                  map: emergencialContact,
                );
              },
            ).toList(),
      socialNetworks: map['socialNetworks'] == null
          ? null
          : (map['socialNetworks'] as List).map(
              (socialNetwork) {
                return _socialNetworkModelMapper.fromMap(
                  map: socialNetwork,
                );
              },
            ).toList(),
      ctps: map['ctps'] == null
          ? null
          : _ctpsModelMapper.fromMap(
              map: map['ctps'],
            ),
      currentAddress: map['currentAddress'] == null
          ? null
          : _addressModelMapper.fromMap(
              map: map['currentAddress'],
            ),
      nis: map['nis'] == null
          ? null
          : _nisModelMapper.fromMap(
              map: map['nis'],
            ),
      passport: map['passport'] == null
          ? null
          : _passportModelMapper.fromMap(
              map: map['passport'],
            ),
      rg: map['rg'] == null
          ? null
          : _rgModelMapper.fromMap(
              map: map['rg'],
            ),
      ric: map['ric'] == null
          ? null
          : _ricModelMapper.fromMap(
              map: map['ric'],
            ),
      rne: map['rne'] == null
          ? null
          : _rneModelMapper.fromMap(
              map: map['rne'],
            ),
      visa: map['visa'] == null
          ? null
          : _visaModelMapper.fromMap(
              map: map['visa'],
            ),
      voterRegistration: map['voterRegistration'] == null
          ? null
          : _voterRegistrationModelMapper.fromMap(
              map: map['voterRegistration'],
            ),
      nationality: map['nationality'] == null
          ? null
          : _nationalityModelMapper.fromMap(
              map: map['nationality'],
            ),
      placeOfBirth: map['placeOfBirth'] == null
          ? null
          : _cityModelMapper.fromMap(
              map: map['placeOfBirth'],
            ),
      reservistCertificate: map['reservistCertificate'] == null
          ? null
          : _reservistCertificateModelMapper.fromMap(
              map: map['reservistCertificate'],
            ),
      gender: EnumHelper<GenderTypeEnum>().stringToEnum(
        stringToParse: map['gender'],
        values: GenderTypeEnum.values,
      ),
      maritalStatus: EnumHelper<MaritalStatusEnum>().stringToEnum(
        stringToParse: map['maritalStatus'],
        values: MaritalStatusEnum.values,
      ),
      disabilities: map['disabilities'] == null
          ? null
          : (map['disabilities'] as List).map(
              (disabilities) {
                return _disabilitiesModelMapper.fromMap(
                  map: disabilities,
                  rehabilitation: map['rehabilitation'],
                );
              },
            ).toList(),
      personalRequestUpdate: map['personalRequestUpdate'] == null
          ? null
          : _personalRequestUpdateMapper.fromMap(
              map: map['personalRequestUpdate'],
            ),
      addressRequestUpdate: map['addressRequestUpdate'] == null
          ? null
          : _addressRequestUpdateMapper.fromMap(
              map: map['addressRequestUpdate'],
            ),
      contactRequestUpdate: map['contactRequestUpdate'] == null
          ? null
          : _contactRequestUpdateMapper.fromMap(
              map: map['contactRequestUpdate'],
            ),
      documentRequestUpdate: map['documentRequestUpdate'] == null
          ? null
          : _documentRequestUpdateMapper.fromMap(
              map: map['documentRequestUpdate'],
            ),
      rehabilitation: map['rehabilitation'],
    );
  }

  ProfileModel fromJson({
    required String profileJson,
    required String employeeId,
  }) {
    final profileMap = jsonDecode(profileJson);

    return fromMap(
      map: profileMap,
      employeeId: employeeId,
    );
  }
}
