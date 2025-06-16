import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CalculationTypeEnum {
  empty,
  calculoMensal,
  folhaComplementar,
  complementarDissidio,
  pagamentoDissidio,
  complementarRescisao,
  primeiraSemana,
  semanaIntermediaria,
  ultimaSemana,
  adiantamentoDecimoTerceiroSalario,
  decimoTerceiroSalarioIntegral,
  gratificacao,
  segundaQuinzena,
  primeiraQuinzena,
  adiantamentoSalarial,
  participacaoLucros,
  especiais,
  reclamatoriaTrabalhista;

  String name(AppLocalizations appLocalizations) {
    switch (this) {
      case empty:
        return '';
      case calculoMensal:
        return appLocalizations.monthlyCalculation;
      case folhaComplementar:
        return appLocalizations.complementaryPayroll;
      case complementarDissidio:
        return appLocalizations.bargainingComplement;
      case pagamentoDissidio:
        return appLocalizations.bargainingPayment;
      case complementarRescisao:
        return appLocalizations.rescissionComplement;
      case primeiraSemana:
        return appLocalizations.firstWeek;
      case semanaIntermediaria:
        return appLocalizations.intermediateWeek;
      case ultimaSemana:
        return appLocalizations.lastWeek;
      case adiantamentoDecimoTerceiroSalario:
        return appLocalizations.christmasBonusAdvance;
      case decimoTerceiroSalarioIntegral:
        return appLocalizations.fullChristmasBonus;
      case gratificacao:
        return appLocalizations.bonus;
      case segundaQuinzena:
        return appLocalizations.secondFortnight;
      case primeiraQuinzena:
        return appLocalizations.firstFortnight;
      case adiantamentoSalarial:
        return appLocalizations.salaryAdvance;
      case participacaoLucros:
        return appLocalizations.profitSharing;
      case especiais:
        return appLocalizations.special;
      case reclamatoriaTrabalhista:
        return appLocalizations.laborClaim;
    }
  }
}
