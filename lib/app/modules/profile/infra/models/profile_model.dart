import 'package:equatable/equatable.dart';

import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import 'address_model.dart';
import 'bank_account_model.dart';
import 'city_model.dart';
import 'civil_certificate_model.dart';
import 'cnh_model.dart';
import 'contract_model.dart';
import 'ctps_model.dart';
import 'disabilities_model.dart';
import 'email_model.dart';
import 'emergencial_contact_model.dart';
import 'nationality_model.dart';
import 'nis_model.dart';
import 'passport_model.dart';
import 'personal_request_update_model.dart';
import 'phone_contact_model.dart';
import 'profile_person_model.dart';
import 'reservist_certificate_model.dart';
import 'rg_model.dart';
import 'ric_model.dart';
import 'rne_model.dart';
import 'social_network_model.dart';
import 'visa_model.dart';
import 'voter_registration_model.dart';

class ProfileModel extends Equatable {
  final String linkPhoto;
  final String name;
  final DateTime? birthDate;
  final GenderTypeEnum? gender;
  final MaritalStatusEnum? maritalStatus;
  final String? educationDegreeName;
  final bool? showBirthday;
  final ContractModel? contract;
  final List<SocialNetworkModel>? socialNetworks;
  final List<PhoneContactModel>? contacts;
  final List<EmergencialContactModel>? emergencialContacts;
  final NationalityModel? nationality;
  final CityModel? placeOfBirth;
  final List<EmailModel>? emails;
  final AddressModel? currentAddress;
  final BankAccountModel? bankAccount;
  final RgModel? rg;
  final String? cpf;
  final NisModel? nis;
  final CtpsModel? ctps;
  final CnhModel? cnh;
  final PassportModel? passport;
  final List<CivilCertificateModel>? civilCertificates;
  final RicModel? ric;
  final VoterRegistrationModel? voterRegistration;
  final ReservistCertificateModel? reservistCertificate;
  final String? nationalHealthCard;
  final String? liveBirthDeclaration;
  final VisaModel? visa;
  final RneModel? rne;
  final List<DisabilitiesModel>? disabilities;
  final bool? rehabilitation;
  final ProfilePersonModel? personModel;
  final PersonalRequestUpdateModel? personalRequestUpdate;
  final PersonalRequestUpdateModel? contactRequestUpdate;
  final PersonalRequestUpdateModel? addressRequestUpdate;
  final PersonalRequestUpdateModel? documentRequestUpdate;

  const ProfileModel({
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
    this.personModel,
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
      personModel,
      personalRequestUpdate,
      addressRequestUpdate,
      contactRequestUpdate,
      documentRequestUpdate,
    ];
  }
}
