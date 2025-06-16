import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/personal_relationship_enum.dart';

abstract class EnumPersonalRelationshipStringFormatter {
  static String personalRelationshipEnumToValue({
    required PersonalRelationshipEnum personalRelationshipEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (personalRelationshipEnum) {
      case PersonalRelationshipEnum.adopted:
        return appLocalizations.adoptedChild;
      case PersonalRelationshipEnum.child:
        return appLocalizations.children;
      case PersonalRelationshipEnum.concubine:
        return appLocalizations.concubine;
      case PersonalRelationshipEnum.exSpouse:
        return appLocalizations.exSpouse;
      case PersonalRelationshipEnum.exPartner:
        return appLocalizations.exPartner;
      case PersonalRelationshipEnum.grandparent:
        return appLocalizations.grandparent;
      case PersonalRelationshipEnum.grandchild:
        return appLocalizations.grandchild;
      case PersonalRelationshipEnum.greatGrandparent:
        return appLocalizations.greatGrandparent;
      case PersonalRelationshipEnum.greatGrandchild:
        return appLocalizations.greatGrandchild;
      case PersonalRelationshipEnum.guardianship:
        return appLocalizations.guardianship;
      case PersonalRelationshipEnum.nephewNiece:
        return appLocalizations.nephewNiece;
      case PersonalRelationshipEnum.parent:
        return appLocalizations.fatherMother;
      case PersonalRelationshipEnum.parentInLaw:
        return appLocalizations.fatherMotherInLaw;
      case PersonalRelationshipEnum.partner:
        return appLocalizations.partner;
      case PersonalRelationshipEnum.pensioners:
        return appLocalizations.pensioner;
      case PersonalRelationshipEnum.pupil:
        return appLocalizations.dependent;
      case PersonalRelationshipEnum.sibling:
        return appLocalizations.brotherSister;
      case PersonalRelationshipEnum.sonDaughterInLaw:
        return appLocalizations.sonDaughterInLaw;
      case PersonalRelationshipEnum.spouse:
        return appLocalizations.spouse;
      case PersonalRelationshipEnum.stepfather:
        return appLocalizations.stepfather;
      case PersonalRelationshipEnum.stepmother:
        return appLocalizations.stepmother;
      case PersonalRelationshipEnum.stepchild:
        return appLocalizations.stepChildren;
      case PersonalRelationshipEnum.trusteed:
        return appLocalizations.conservatee;
      case PersonalRelationshipEnum.uncleAunt:
        return appLocalizations.uncleAunt;
      case PersonalRelationshipEnum.other:
        return appLocalizations.others;
    }
  }
}
