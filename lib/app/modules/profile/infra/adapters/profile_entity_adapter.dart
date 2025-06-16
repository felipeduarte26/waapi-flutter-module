import '../../domain/entities/education_degree_entity.dart';
import '../../domain/entities/ethnicity_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/profile_person_entity.dart';
import '../models/profile_model.dart';
import '../models/profile_person_model.dart';
import 'address_entity_adapter.dart';
import 'bank_account_entity_adapter.dart';
import 'city_entity_adapter.dart';
import 'civil_certificate_entity_adapter.dart';
import 'cnh_entity_adapter.dart';
import 'contract_entity_adapter.dart';
import 'ctps_entity_adapter.dart';
import 'disabilities_entity_adapter.dart';
import 'email_entity_adapter.dart';
import 'emergencial_contact_entity_adapter.dart';
import 'nationality_entity_adapter.dart';
import 'nis_entity_adapter.dart';
import 'passport_entity_adapter.dart';
import 'phone_contact_entity_adapter.dart';
import 'reservist_certificate_entity_adapter.dart';
import 'rg_entity_adapter.dart';
import 'ric_entity_adapter.dart';
import 'rne_entity_adapter.dart';
import 'social_network_entity_adapter.dart';
import 'visa_entity_adapter.dart';
import 'voter_registration_entity_adapter.dart';

class ProfileEntityAdapter {
  ProfileEntity fromModel({
    required ProfileModel profileModel,
    ProfilePersonModel? personModel,
  }) {
    return ProfileEntity(
      personEntity: personModel != null
          ? ProfilePersonEntity(
              birthDate: personModel.birthDate,
              educationDegree: personModel.educationDegree != null
                  ? EducationDegreeEntity(
                      code: personModel.educationDegree!.code,
                      name: personModel.educationDegree!.name,
                      id: personModel.educationDegree!.id,
                      type: personModel.educationDegree!.type,
                    )
                  : null,
              ethnicity: personModel.ethnicity != null
                  ? EthnicityEntity(
                      id: personModel.ethnicity!.id,
                      name: personModel.ethnicity!.name,
                      code: personModel.ethnicity!.code,
                    )
                  : null,
            )
          : null,
      linkPhoto: profileModel.linkPhoto,
      name: profileModel.name,
      birthDate: profileModel.birthDate,
      gender: profileModel.gender,
      maritalStatus: profileModel.maritalStatus,
      educationDegreeName: profileModel.educationDegreeName,
      showBirthday: profileModel.showBirthday,
      contract: profileModel.contract != null
          ? ContractEntityAdapter().fromModel(
              contractModel: profileModel.contract!,
            )
          : null,
      socialNetworks: profileModel.socialNetworks?.map((socialNetworks) {
        return SocialNetworkEntityAdapter().fromModel(
          socialNetworkModel: socialNetworks,
        );
      }).toList(),
      contacts: profileModel.contacts?.map((phoneContact) {
        return PhoneContactEntityAdapter().fromModel(
          phoneContactModel: phoneContact,
        );
      }).toList(),
      emergencialContacts: profileModel.emergencialContacts?.map((emergencialContact) {
        return EmergencialContactEntityAdapter().fromModel(
          emergencialContactModel: emergencialContact,
        );
      }).toList(),
      nationality: profileModel.nationality != null
          ? NationalityEntityAdapter().fromModel(
              nationalityModel: profileModel.nationality!,
            )
          : null,
      placeOfBirth: profileModel.placeOfBirth != null
          ? CityEntityAdapter().fromModel(
              cityModel: profileModel.placeOfBirth!,
            )
          : null,
      currentAddress: profileModel.currentAddress != null
          ? AddressEntityAdapter().fromModel(
              addressModel: profileModel.currentAddress!,
            )
          : null,
      bankAccount: profileModel.bankAccount != null
          ? BankAccountEntityAdapter().fromModel(
              bankAccountModel: profileModel.bankAccount!,
            )
          : null,
      rg: profileModel.rg != null
          ? RgEntityAdapter().fromModel(
              rgModel: profileModel.rg!,
            )
          : null,
      cpf: profileModel.cpf,
      nis: profileModel.nis != null
          ? NisEntityAdapter().fromModel(
              nisModel: profileModel.nis!,
            )
          : null,
      ctps: profileModel.ctps != null
          ? CtpsEntityAdapter().fromModel(
              ctpsModel: profileModel.ctps!,
            )
          : null,
      cnh: profileModel.cnh != null
          ? CnhEntityAdapter().fromModel(
              cnhModel: profileModel.cnh!,
            )
          : null,
      passport: profileModel.passport != null
          ? PassportEntityAdapter().fromModel(
              passportModel: profileModel.passport!,
            )
          : null,
      civilCertificates: profileModel.civilCertificates?.map((civilCertificate) {
        return CivilCertificateEntityAdapter().fromModel(
          civilCertificateModel: civilCertificate,
        );
      }).toList(),
      ric: profileModel.ric != null
          ? RicEntityAdapter().fromModel(
              ricModel: profileModel.ric!,
            )
          : null,
      voterRegistration: profileModel.voterRegistration != null
          ? VoterRegistrationEntityAdapter().fromModel(
              voterRegistrationModel: profileModel.voterRegistration!,
            )
          : null,
      reservistCertificate: profileModel.reservistCertificate != null
          ? ReservistCertificateEntityAdapter().fromModel(
              reservistCertificateModel: profileModel.reservistCertificate!,
            )
          : null,
      nationalHealthCard: profileModel.nationalHealthCard,
      liveBirthDeclaration: profileModel.liveBirthDeclaration,
      visa: profileModel.visa != null
          ? VisaEntityAdapter().fromModel(
              visaModel: profileModel.visa!,
            )
          : null,
      rne: profileModel.rne != null
          ? RneEntityAdapter().fromModel(
              rneModel: profileModel.rne!,
            )
          : null,
      emails: profileModel.emails?.map((email) {
        return EmailEntityAdapter().fromModel(
          emailModel: email,
        );
      }).toList(),
      disabilities: profileModel.disabilities?.map((disabilities) {
        return DisabilitiesEntityAdapter().fromModel(
          disabilitiesModel: disabilities,
        );
      }).toList(),
      personalRequestUpdate: profileModel.personalRequestUpdate,
      contactRequestUpdate: profileModel.contactRequestUpdate,
      addressRequestUpdate: profileModel.addressRequestUpdate,
      documentRequestUpdate: profileModel.documentRequestUpdate,
      rehabilitation: profileModel.rehabilitation,
    );
  }
}
