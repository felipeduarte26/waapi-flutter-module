import 'package:equatable/equatable.dart';

import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../infra/models/personal_request_update_model.dart';
import 'address_entity.dart';
import 'bank_account_entity.dart';
import 'city_entity.dart';
import 'civil_certificate_entity.dart';
import 'cnh_entity.dart';
import 'contract_entity.dart';
import 'ctps_entity.dart';
import 'disabilities_entity.dart';
import 'email_entity.dart';
import 'emergencial_contact_entity.dart';
import 'nationality_entity.dart';
import 'nis_entity.dart';
import 'passport_entity.dart';
import 'phone_contact_entity.dart';
import 'profile_person_entity.dart';
import 'reservist_certificate_entity.dart';
import 'rg_entity.dart';
import 'ric_entity.dart';
import 'rne_entity.dart';
import 'social_network_entity.dart';
import 'visa_entity.dart';
import 'voter_registration_entity.dart';

class ProfileEntity extends Equatable {
  final String linkPhoto;
  final String name;
  final DateTime? birthDate;
  final GenderTypeEnum? gender;
  final MaritalStatusEnum? maritalStatus;
  final String? educationDegreeName;
  final bool? showBirthday;
  final ContractEntity? contract;
  final List<SocialNetworkEntity>? socialNetworks;
  final List<PhoneContactEntity>? contacts;
  final List<EmergencialContactEntity>? emergencialContacts;
  final NationalityEntity? nationality;
  final CityEntity? placeOfBirth;
  final List<EmailEntity>? emails;
  final AddressEntity? currentAddress;
  final BankAccountEntity? bankAccount;
  final RgEntity? rg;
  final String? cpf;
  final NisEntity? nis;
  final CtpsEntity? ctps;
  final CnhEntity? cnh;
  final PassportEntity? passport;
  final List<CivilCertificateEntity>? civilCertificates;
  final RicEntity? ric;
  final VoterRegistrationEntity? voterRegistration;
  final ReservistCertificateEntity? reservistCertificate;
  final String? nationalHealthCard;
  final String? liveBirthDeclaration;
  final VisaEntity? visa;
  final RneEntity? rne;
  final List<DisabilitiesEntity>? disabilities;
  final bool? rehabilitation;
  final ProfilePersonEntity? personEntity;
  final PersonalRequestUpdateModel? personalRequestUpdate;
  final PersonalRequestUpdateModel? addressRequestUpdate;
  final PersonalRequestUpdateModel? contactRequestUpdate;
  final PersonalRequestUpdateModel? documentRequestUpdate;

  const ProfileEntity({
    required this.linkPhoto,
    required this.name,
    this.birthDate,
    this.gender,
    this.maritalStatus,
    this.educationDegreeName,
    this.showBirthday,
    this.contract,
    this.socialNetworks,
    this.contacts,
    this.emergencialContacts,
    this.nationality,
    this.placeOfBirth,
    this.emails,
    this.currentAddress,
    this.bankAccount,
    this.rg,
    this.cpf,
    this.nis,
    this.ctps,
    this.cnh,
    this.passport,
    this.civilCertificates,
    this.ric,
    this.voterRegistration,
    this.reservistCertificate,
    this.nationalHealthCard,
    this.liveBirthDeclaration,
    this.visa,
    this.rne,
    this.disabilities,
    this.rehabilitation,
    this.personEntity,
    this.personalRequestUpdate,
    this.addressRequestUpdate,
    this.contactRequestUpdate,
    this.documentRequestUpdate,
  });

  @override
  List<Object?> get props {
    return [
      linkPhoto,
      name,
      birthDate,
      gender,
      maritalStatus,
      educationDegreeName,
      showBirthday,
      contract,
      socialNetworks,
      contacts,
      emergencialContacts,
      nationality,
      placeOfBirth,
      emails,
      currentAddress,
      bankAccount,
      rg,
      cpf,
      nis,
      ctps,
      cnh,
      passport,
      civilCertificates,
      ric,
      voterRegistration,
      reservistCertificate,
      nationalHealthCard,
      liveBirthDeclaration,
      visa,
      rne,
      disabilities,
      rehabilitation,
      personEntity,
      personalRequestUpdate,
      addressRequestUpdate,
      contactRequestUpdate,
      documentRequestUpdate,
    ];
  }
}
