import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/relationship_type_enum.dart';

class EnumRelationshipStringFormatter {
  static String getRelationshipString({
    required RelationshipTypeEnum relationshipTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (relationshipTypeEnum) {
      case RelationshipTypeEnum.empregadoGeral:
        return appLocalizations.employeeGeneral;
      case RelationshipTypeEnum.empregadoTrabalhadorRuralPorPequenoPrazoDaLei_11_718_2008:
        return appLocalizations.employeeShortTermRuralWorkerOfBrazilianLaw117182008;
      case RelationshipTypeEnum.empregadoAprendiz:
        return appLocalizations.employeeApprentice;
      case RelationshipTypeEnum.empregadoDomestico:
        return appLocalizations.employeeDomesticWorker;
      case RelationshipTypeEnum.empregadoContratoTermoFirmadoNosTermosDaLei_9601_98:
        return appLocalizations.employeeFixedTermInAccordanceToBrazilianLaw960198;
      case RelationshipTypeEnum.empregadoContratoPorPrazoDeterminadoNosTermosDaLei_6019_74:
        return appLocalizations.employeeFixedTermContractInAccordanceToBrazilianLaw601974;
      case RelationshipTypeEnum.trabalhadorNaoVinculadoAoRgpsComDireitoAoFgts:
        return appLocalizations
            .employeeNotRelatedToRgpsGeneralSocialWelfarePolicyButEntitledToFgtsGuaranteeFundForLengthOfService;
      case RelationshipTypeEnum.trabalhadorAvulsoPortuario:
        return appLocalizations.temporaryWorkerPortWorker;
      case RelationshipTypeEnum.trabalhadorAvulsoNaoPortuarioInformacoesSindicato:
        return appLocalizations.temporaryWorkerNonPortUnionInformation;
      case RelationshipTypeEnum.trabalhadorAvulsoNaoPortuarioInformacoesContratante:
        return appLocalizations.temporaryWorkerNonPortContractorInformation;
      case RelationshipTypeEnum.servidorPublicoTitularDeCargoEfetivo:
        return appLocalizations.publicServantTitularOfEffectiveJob;
      case RelationshipTypeEnum.servidorPublicoOcupanteCargoExclusivoComissao:
        return appLocalizations.publicServantOccupyingACommissionedExclusiveJob;
      case RelationshipTypeEnum.servidorPublicoExercenteDeMandatoEfetivo:
        return appLocalizations.publicServantElectiveMandateExercise;
      case RelationshipTypeEnum.servidorPublicoAgentePublico:
        return appLocalizations.publicServantPublicAgent;
      case RelationshipTypeEnum
          .servidorPublicoVinculadoARppsIndicadoParaConselhoOuOrgaoRepresentativoNaCondicaoDeRepresentanteDoGovernoOrgaoOuEntidadeDaAdministracaoPublica:
        return appLocalizations
            .publicServerRelatedToRppsIndicatedForCouncilOrRepresentativeBodyInTheConditionOfRepresentativeOfTheGovernmentBodyOrPublicAdministrationEntity;
      case RelationshipTypeEnum.servidorPublicoContratoTemporario:
        return appLocalizations.publicServantTemporaryContract;
      case RelationshipTypeEnum.dirigenteSindicalEmRelacaoARemuneracaoRecebidaNoSindicato:
        return appLocalizations.unionLeaderInRelationToTheRemunerationReceivedInTheUnion;
      case RelationshipTypeEnum.contribIndividualAutonomoContratadoPorEmpresasEmGeral:
        return appLocalizations.individualContributorSelfEmployedWorkerHiredByCompaniesInGeneral;
      case RelationshipTypeEnum
          .contribIndividualAutonomoContratadoPorContribIndividualPorPessoaFisicaEmGeralOuPorMissaoDiplomaticaEReparticaoConsularDeCarreiraEstrangeiras:
        return appLocalizations
            .individualContributorSelfEmployedHiredByIndividualContributorByNaturalPersonInGeneralOrByDiplomaticMissionAndConsularOfficeOfForeignCareers;
      case RelationshipTypeEnum
          .contribIndividualAutonomoContratadoPorEntidadeBeneficenteDeAssistenciaSocialIsentaDaCotaPatronal:
        return appLocalizations
            .individualContributorSelfEmployedHiredByBeneficentEntityOfSocialAssistanceExemptFromEmployerSQuota;
      case RelationshipTypeEnum.contribIndividualTransportadorAutonomoContratadoPorEmpresasEmGeral:
        return appLocalizations.individualContributorSelfEmployedCarrierHiredByCompaniesInGeneral;
      case RelationshipTypeEnum
          .contribIndividualTransportadorAutonomoContratadoPorContribIndividualPorPessoaFisicaEmGeralOuPorMissaoDiplomaticaEReparticaoConsularDeCarreiraEstrangeiras:
        return appLocalizations
            .individualContributorSelfEmployedCarrierHiredByIndividualContributorByNaturalPersonInGeneralOrByDiplomaticMissionAndConsularOfficeOfForeignCareers;
      case RelationshipTypeEnum
          .contribIndividualTransportadorAutonomoContratadoPorEntidadeBeneficenteDeAssistenciaSocialIsentaDaCotaPatronal:
        return appLocalizations
            .individualContributorSelfEmployedCarrierHiredByBeneficentEntityOfSocialAssistanceExemptFromEmployerSQuota;
      case RelationshipTypeEnum.contribIndividualDiretorNaoEmpregadoComFgts:
        return appLocalizations.individualContributorNonEmployedDirectorWithFgts;
      case RelationshipTypeEnum.contribIndividualDiretorNaoEmpregadoSemFgts:
        return appLocalizations.individualContributorNonEmployedDirectorWithoutFgts;
      case RelationshipTypeEnum.contribIndividualCooperadoEleitoParaDirecaoDaCooperativa:
        return appLocalizations.individualContributorCooperativeMemberElectedForTheManagementOfTheCooperative;
      case RelationshipTypeEnum
          .contribIndividualTransportadorCooperadoQuePrestaServicosAEmpresaPorIntermedioDeCooperativaDeTrabalho:
        return appLocalizations
            .individualContributorCooperativeCarrierWhoProvidesServicesToTheCompanyThroughWorkCooperative;
      case RelationshipTypeEnum
          .contribIndividualTransportadorCooperadoQuePrestaServicosAEntidadeBeneficenteDeAssistenciaSocialIsentaDaCotaPatronalOuParaPessoaFisica:
        return appLocalizations
            .individualContributorCooperativeCarrierWhoProvidesServicesToBeneficentEntityOfSocialAssistanceExemptFromEmployerSQuotaOrForNaturalPerson;
      case RelationshipTypeEnum.contribIndividualTransportadorCooperadoEleitoParaDirecaoDaCooperativa:
        return appLocalizations.individualContributorCooperativeCarrierElectedForTheManagementOfTheCooperative;
      case RelationshipTypeEnum.contribIndividualCooperadoFiliadoACooperativaDeProducao:
        return appLocalizations.individualContributorCooperativeMemberAffiliatedToProductionCooperative;
      case RelationshipTypeEnum.contribIndividualMicroEmpreendedorIndividualQuandoContratadoPorPj:
        return appLocalizations.individualContributorMicroIndividualEntrepreneurWhenHiredByLegalPerson;
      case RelationshipTypeEnum.estagiario:
        return appLocalizations.intern;
      case RelationshipTypeEnum.naoSeAplica:
        return appLocalizations.doesNotApply;
      case RelationshipTypeEnum.contribIndividualCooperadoQuePrestaServicosAEmpresaPorIntermedioDeCooperativaDeTrabalho:
        return appLocalizations
            .individualContributorCooperativeMemberWhoProvidesServicesToCompanyThroughWorkCooperative;
      case RelationshipTypeEnum
          .contribIndividualCooperadoQuePrestaServicosAEntidadeBeneficenteDeAssistenciaSocialIsentaDaCotaPatronalOuParaPessoaFisica:
        return appLocalizations
            .individualContributorCooperativeCarrierWhoProvidesServicesToBeneficentEntityOfSocialAssistanceExemptFromEmployerSQuotaOrForNaturalPerson;
    }
  }
}
