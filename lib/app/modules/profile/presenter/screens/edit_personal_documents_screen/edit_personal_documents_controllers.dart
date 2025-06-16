import 'package:flutter/material.dart';

import '../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../enums/cnh_category_enum.dart';
import '../../../helper/nis_validator_helper.dart';

class EditPersonalDocumentsControllers {
  // TextEditingController CPF
  TextEditingController cpfController = TextEditingController();

  // TextEditingController RG
  TextEditingController rgNumberController = TextEditingController();
  TextEditingController rgIssuanceDateController = TextEditingController();
  TextEditingController rgIssuerController = TextEditingController();
  TextEditingController rgIssuingStateController = TextEditingController();

  // TextEditingController Título Eleitoral(Voter Registration Card)
  TextEditingController voterNumberController = TextEditingController();
  TextEditingController voterSectionController = TextEditingController();
  TextEditingController voterZoneController = TextEditingController();

  //TextEditingController CTPS
  TextEditingController ctpsNumberController = TextEditingController();
  TextEditingController ctpsSerieController = TextEditingController();
  TextEditingController ctpsSerieDigitController = TextEditingController();
  TextEditingController ctpsIssuanceDateController = TextEditingController();
  TextEditingController ctpsIssuingStateController = TextEditingController();

  // TextEditingController CNH
  TextEditingController cnhNumberController = TextEditingController();
  TextEditingController cnhCategoryController = TextEditingController();
  TextEditingController cnhIssuerController = TextEditingController();
  TextEditingController cnhIssuedDateController = TextEditingController();
  TextEditingController cnhExpiryDateController = TextEditingController();
  TextEditingController cnhFirstIssuedDateController = TextEditingController();
  TextEditingController cnhIssuerStateController = TextEditingController();

  // TextEditingController PASSAPORTE
  TextEditingController passportNumberController = TextEditingController();
  TextEditingController passportCountryController = TextEditingController();
  TextEditingController passportCountryIdController = TextEditingController();
  TextEditingController passportIssuerController = TextEditingController();
  TextEditingController passportIssuedDateController = TextEditingController();
  TextEditingController passportExpiryDateController = TextEditingController();
  TextEditingController passportIssuerStateController = TextEditingController();

  // TextEditingController NIS
  TextEditingController nisNumberController = TextEditingController();
  TextEditingController nisRegisterDateController = TextEditingController();

  //TextEditingController RIC
  TextEditingController ricNumberController = TextEditingController();
  TextEditingController ricIssuanceDateController = TextEditingController();
  TextEditingController ricIssuerController = TextEditingController();
  TextEditingController ricIssuingCityController = TextEditingController();
  TextEditingController ricIssuingCityIdController = TextEditingController();

  //TextEditingController Reservist Certificate
  TextEditingController cdiNumberController = TextEditingController();
  TextEditingController cdiCategoryController = TextEditingController();

  // TextEditingController CNS
  TextEditingController cnsNumberController = TextEditingController();

  //TextEditingController Observação
  TextEditingController notesController = TextEditingController();

  EditPersonalDocumentsControllers({
    required ProfileEntity profileEntity,
    required String localeName,
  }) {
   
    //CPF
    if (profileEntity.cpf != null) {
      cpfController = profileEntity.cpf != null
          ? TextEditingController(
              text: profileEntity.cpf,
            )
          : TextEditingController();
    }

    // RG
    if (profileEntity.rg != null) {
      rgNumberController = profileEntity.rg!.number != null
          ? TextEditingController(text: profileEntity.rg!.number!)
          : TextEditingController();

      rgIssuanceDateController = profileEntity.rg!.issuedDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.rg!.issuedDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      rgIssuerController = profileEntity.rg!.issuer != null
          ? TextEditingController(text: profileEntity.rg!.issuer!)
          : TextEditingController();

      rgIssuingStateController = profileEntity.rg!.issuingState != null
          ? TextEditingController(
              text: EnumHelper<BrazilianStateEnum>().enumToString(
                enumToParse: profileEntity.rg!.issuingState!,
              ),
            )
          : TextEditingController();
    }

    // Titulo Eleitor
    if (profileEntity.voterRegistration != null) {
      voterNumberController = profileEntity.voterRegistration!.number != null
          ? TextEditingController(text: profileEntity.voterRegistration!.number)
          : TextEditingController();
      voterZoneController = profileEntity.voterRegistration!.zone != null
          ? TextEditingController(text: profileEntity.voterRegistration!.zone.toString())
          : TextEditingController();
      voterSectionController = profileEntity.voterRegistration!.section != null
          ? TextEditingController(text: profileEntity.voterRegistration!.section.toString())
          : TextEditingController();
    }

    //CTPS
    if (profileEntity.ctps != null) {
      ctpsNumberController = profileEntity.ctps!.number != null
          ? TextEditingController(text: profileEntity.ctps!.number!)
          : TextEditingController();
      ctpsSerieController = profileEntity.ctps!.serie != null
          ? TextEditingController(text: profileEntity.ctps!.serie!)
          : TextEditingController();
      ctpsSerieDigitController = profileEntity.ctps!.serieDigit != null
          ? TextEditingController(text: profileEntity.ctps!.serieDigit!)
          : TextEditingController();
      ctpsIssuanceDateController = profileEntity.ctps!.issuedDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.ctps!.issuedDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();
      ctpsIssuingStateController.text = profileEntity.ctps!.state != null
          ? EnumHelper<BrazilianStateEnum>().enumToString(
              enumToParse: profileEntity.ctps!.state!,
            )
          : '';
    }

    //CNH
    if (profileEntity.cnh != null) {
      cnhNumberController = profileEntity.cnh?.number != null
          ? TextEditingController(
              text: profileEntity.cnh!.number,
            )
          : TextEditingController();
      cnhCategoryController = profileEntity.cnh?.category != null
          ? TextEditingController(
              text: EnumHelper<CnhCategoryEnum>().enumToString(
                enumToParse: profileEntity.cnh!.category!,
              ),
            )
          : TextEditingController();

      cnhIssuerController = profileEntity.cnh?.issuer != null
          ? TextEditingController(
              text: profileEntity.cnh!.issuer,
            )
          : TextEditingController();

      cnhIssuedDateController = profileEntity.cnh?.issuedDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.cnh!.issuedDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      cnhExpiryDateController = profileEntity.cnh?.expiryDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.cnh!.expiryDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      cnhFirstIssuedDateController = profileEntity.cnh?.firstIssuedDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.cnh!.firstIssuedDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      cnhIssuerStateController = profileEntity.cnh?.issuerState != null
          ? TextEditingController(
              text: EnumHelper<BrazilianStateEnum>().enumToString(
                enumToParse: profileEntity.cnh!.issuerState!,
              ),
            )
          : TextEditingController();
    }

    //PASSAPORTE
    if (profileEntity.passport != null) {
      passportNumberController = profileEntity.passport?.number != null
          ? TextEditingController(
              text: profileEntity.passport!.number,
            )
          : TextEditingController();

      passportCountryIdController = profileEntity.passport?.issuingCountryId != null
          ? TextEditingController(
              text: profileEntity.passport!.issuingCountryId!,
            )
          : TextEditingController();

      passportCountryController = profileEntity.passport?.issuingCountryName != null
          ? TextEditingController(
              text: profileEntity.passport!.issuingCountryName!,
            )
          : TextEditingController();

      passportIssuerController = profileEntity.passport?.issuer != null
          ? TextEditingController(
              text: profileEntity.passport!.issuer,
            )
          : TextEditingController();

      passportIssuedDateController = profileEntity.passport?.issuedDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.passport!.issuedDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      passportExpiryDateController = profileEntity.passport?.expiryDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.passport!.expiryDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      passportIssuerStateController = profileEntity.passport?.issuingState != null
          ? TextEditingController(
              text: EnumHelper<BrazilianStateEnum>().enumToString(
                enumToParse: profileEntity.passport!.issuingState!,
              ),
            )
          : TextEditingController();
    }

    // RIC
    if (profileEntity.ric != null) {
      ricNumberController = profileEntity.ric?.number != null
          ? TextEditingController(
              text: profileEntity.ric!.number,
            )
          : TextEditingController();

      ricIssuanceDateController = profileEntity.ric?.issuedDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.ric!.issuedDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();

      ricIssuerController = profileEntity.ric?.issuer != null
          ? TextEditingController(
              text: profileEntity.ric!.issuer,
            )
          : TextEditingController();

      ricIssuingCityController = profileEntity.ric?.issuingCityName != null
          ? TextEditingController(
              text: profileEntity.ric!.issuingCityName,
            )
          : TextEditingController();

      ricIssuingCityIdController = profileEntity.ric?.issuingCityId != null
          ? TextEditingController(
              text: profileEntity.ric!.issuingCityId,
            )
          : TextEditingController();
    }

    //NIS
    if (profileEntity.nis != null) {
      nisNumberController = profileEntity.nis!.number != null
          ? TextEditingController(
              text: NisValidatorHelper.format(
                profileEntity.nis!.number!,
              ),
            )
          : TextEditingController();

      nisRegisterDateController = profileEntity.nis!.registrationDate != null
          ? TextEditingController(
              text: DateTimeHelper.formatWithDefaultDatePattern(
                dateTime: profileEntity.nis!.registrationDate!,
                locale: LocaleHelper.languageAndCountryCode(
                  locale: Locale(localeName),
                ),
              ),
            )
          : TextEditingController();
    }

    //CDI
    if (profileEntity.reservistCertificate != null) {
      cdiNumberController = profileEntity.reservistCertificate?.number != null
          ? TextEditingController(
              text: profileEntity.reservistCertificate?.number,
            )
          : TextEditingController();

      cdiCategoryController = profileEntity.reservistCertificate?.category != null
          ? TextEditingController(
              text: profileEntity.reservistCertificate!.category!,
            )
          : TextEditingController();
    }

    //CNS
    if (profileEntity.nationalHealthCard != null) {
      cnsNumberController = profileEntity.nationalHealthCard != null
          ? TextEditingController(
              text: profileEntity.nationalHealthCard,
            )
          : TextEditingController();
    }
  }

  Future<void> clearReservistCertificate() async {
    cdiNumberController.clear();
    cdiCategoryController.clear();
  }

  Future<void> clearCNH() async {
    cnhNumberController.clear();
    cnhCategoryController.clear();
    cnhIssuerController.clear();
    cnhIssuedDateController.clear();
    cnhExpiryDateController.clear();
    cnhFirstIssuedDateController.clear();
    cnhIssuerStateController.clear();
  }

  Future<void> clearVoterRegistration() async {
    voterNumberController.clear();
    voterSectionController.clear();
    voterZoneController.clear();
  }

  Future<void> clearRG() async {
    rgNumberController.clear();
    rgIssuanceDateController.clear();
    rgIssuerController.clear();
    rgIssuingStateController.clear();
  }

  Future<void> clearPassport() async {
    passportNumberController.clear();
    passportCountryController.clear();
    passportCountryIdController.clear();
    passportIssuerController.clear();
    passportIssuedDateController.clear();
    passportExpiryDateController.clear();
    passportIssuerStateController.clear();
  }

  Future<void> clearCNS() async {
    cnsNumberController.clear();
  }

  Future<void> clearRIC() async {
    ricNumberController.clear();
    ricIssuanceDateController.clear();
    ricIssuerController.clear();
    ricIssuingCityController.clear();
    ricIssuingCityIdController.clear();
  }
}
