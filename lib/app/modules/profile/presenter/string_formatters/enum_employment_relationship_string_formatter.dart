import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/employment_relationship_enum.dart';

abstract class EnumEmploymentRelationshipStringFormatter {
  static String getEmploymentRelationship({
    required EmploymentRelationshipEnum employmentRelationshipEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (employmentRelationshipEnum) {
      case EmploymentRelationshipEnum
          .trabalhadorUrbanoVinculadoAEmpregadorPessoaJuridicaPorContratoDeTrabalhoRegidoPelaCltPorPrazoIndeterminado:
        return appLocalizations.urbanWorkerRelatedToALegalEntityEmployerByWorkContractGovernedByCltWithUndeterminedTerm;
      case EmploymentRelationshipEnum
          .trabalhadorUrbanoVinculadoAEmpregadorPessoaFisicaPorContratoDeTrabalhoRegidoPelaCltPorPrazoIndeterminado:
        return appLocalizations
            .urbanWorkerRelatedToANaturalPersonEmployerByWorkContractGovernedByCltWithUndeterminedTerm;
      case EmploymentRelationshipEnum
          .trabalhadorRuralVinculadoAEmpregadorPessoaJuridicaPorContratoDeTrabalhoRegidoPelaLeiN5889De1973PorPrazoIndeterminado:
        return appLocalizations
            .ruralWorkerRelatedToALegalEntityEmployerByWorkContractGovernedByBrazilianLaw5889From1973ForAnUndeterminedTerm;
      case EmploymentRelationshipEnum
          .trabalhadorRuralVinculadoAEmpregadorPessoaFisicaPorContratoDeTrabalhoRegidoPelaLeiN5889De1973PorPrazoIndeterminado:
        return appLocalizations
            .ruralWorkerRelatedToANaturalPersonEmployerByWorkContractGovernedByBrazilianLaw5889From1973ForAnUndeterminedTerm;
      case EmploymentRelationshipEnum.servidorRegidoPeloRegimeJuridicoUnicoEMilitarVinculadoARegimeProprioDePrevidencia:
        return appLocalizations.servantGovernedByUniqueLegalRegimeAndMilitaryRelatedToSelfOwnedRegimeOfSocialSecurity;
      case EmploymentRelationshipEnum
          .servidorRegidoPeloRegimeJuridicoUnicoEMilitarVinculadoAoRegimeGeralDePrevidenciaSocial:
        return appLocalizations.servantGovernedByUniqueLegalRegimeAndMilitaryRelatedToTheGeneralRegimeOfSocialSecurity;
      case EmploymentRelationshipEnum
          .servidorPublicoNaoEfetivoDemissivelAdNutumOuAdmitidoPorMeioDeLegislacaoEspecialNaoRegidoPelaClt:
        return appLocalizations
            .publicServantNotEffectiveThatCanBeFiredAdNutumOrHiredViaSpecialLegislationNotGovernedByClt;
      case EmploymentRelationshipEnum
          .trabalhadorAvulsoTrabalhoAdministradoPeloSindicatoDaCategoriaOuPeloOrgaoGestorDeMaoDeObraParaOQualEDevidoDepositoDeFgts:
        return appLocalizations
            .temporaryWorkerWithWorkManagedByTheCategoryUnionOrByTheManagementBodyOfWorkToWhomTheFgtsCollectionMustBeMadeFor;
      case EmploymentRelationshipEnum.trabalhadorDomestico:
        return appLocalizations.domesticWorker;
      case EmploymentRelationshipEnum.trabalhadorTemporarioRegidoPelaLeiN6019De3DeJaneiroDe1974:
        return appLocalizations.temporaryWorkerGovernedByBrazilianLaw6019FromJanuary3Rd1974;
      case EmploymentRelationshipEnum
          .aprendizContratadoNosTermosDoArt428DaCltRegulamentadoPeloDecretoN5598De1DeDezembroDe2005:
        return appLocalizations.apprenticeHiredUnderTheTermsOfArticle428OfCltRegularizedByDecree5598FromDecember1St2005;
      case EmploymentRelationshipEnum
          .trabalhadorUrbanoVinculadoAEmpregadorPessoaJuridicaPorContratoDeTrabalhoRegidoPelaCltPorTempoDeterminadoOuObraCerta:
        return appLocalizations
            .urbanWorkerRelatedToLegalEntityEmployerByWorkContractGovernedByCltWithFixedTermContractOrWork;
      case EmploymentRelationshipEnum
          .trabalhadorUrbanoVinculadoAEmpregadorPessoaFisicaPorContratoDeTrabalhoRegidoPelaCltPorPrazoDeterminadoOuObraCerta:
        return appLocalizations
            .urbanWorkerRelatedToANaturalPersonEmployerByAnEmploymentContractGovernedByTheCltWithFixedDurationContractOrWork;
      case EmploymentRelationshipEnum
          .trabalhadorRuralVinculadoAEmpregadorPessoaJuridicaPorContratoDeTrabalhoRegidoPelaLeiN5889De1973PorPrazoDeterminado:
        return appLocalizations
            .ruralWorkerRelatedToALegalEntityEmployerByAnEmploymentContractGovernedByBrazilianLaw588973ForAFixedTerm;
      case EmploymentRelationshipEnum
          .trabalhadorRuralVinculadoAEmpregadorPessoaFisicaPorContratoDeTrabalhoRegidoPelaLeiN5889De1973PorPrazoDeterminado:
        return appLocalizations
            .ruralWorkerRelatedToANaturalPersonEmployerByAnEmploymentContractGovernedByBrazilianLaw588973WithUndeterminedTerm;
      case EmploymentRelationshipEnum
          .diretorSemVinculoEmpregaticioParaOQualAEmpresaOuEntidadeTenhaOptadoPorRecolhimentoAoFgtsOuDirigenteSindical:
        return appLocalizations
            .directorWithoutEmploymentRelationshipForWhomTheCompanyOrEntityOptedForTheCollectionOfFgtsOrUnionLeader;
      case EmploymentRelationshipEnum.contratoDeTrabalhoPorPrazoDeterminadoRegidoPelaLeiN9601De21DeJaneiroDe1998:
        return appLocalizations.employmentContractWithFixedDurationGovernedByBrazilianLawNumber9601FromJanuary21St1998;
      case EmploymentRelationshipEnum
          .contratoDeTrabalhoPorTempoDeterminadoRegidoPelaLeiN8745De9DeDezembro1993ComARedacaoDadaPelaLeiN9849De26DeOutubroDe1999:
        return appLocalizations
            .fixedTermEmploymentContractGovernedByBrazilianLaw8745FromDec9Th1993WithWordingGivenByBrLaw9849FromOct26Th1999;
      case EmploymentRelationshipEnum.contratoDeTrabalhoPorPrazoDeterminadoRegidoPorLeiEstadual:
        return appLocalizations.fixedTermEmploymentContractGovernedByStateLaw;
      case EmploymentRelationshipEnum.contratoDeTrabalhoPorPrazoDeterminadoRegidoPorLeiMunicipal:
        return appLocalizations.fixedTermEmploymentContractGovernedByMunicipalLaw;
    }
  }
}
