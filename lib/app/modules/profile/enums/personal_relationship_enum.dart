import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PersonalRelationshipEnum {
  adopted,
  child,
  concubine,
  exSpouse,
  exPartner,
  grandparent,
  grandchild,
  greatGrandparent,
  greatGrandchild,
  guardianship,
  nephewNiece,
  parent,
  parentInLaw,
  partner,
  pensioners,
  pupil,
  sibling,
  sonDaughterInLaw,
  spouse,
  stepfather,
  stepmother,
  stepchild,
  trusteed,
  uncleAunt,
  other;

  String name(AppLocalizations appLocalizations) {
    switch (this) {
      case adopted:
        return appLocalizations.adoptedChild;
      case child:
        return appLocalizations.children;
      case concubine:
        return appLocalizations.concubine;
      case exSpouse:
        return appLocalizations.exSpouse;
      case exPartner:
        return appLocalizations.exPartner;
      case grandparent:
        return appLocalizations.grandparent;
      case grandchild:
        return appLocalizations.grandchild;
      case greatGrandparent:
        return appLocalizations.greatGrandparent;
      case greatGrandchild:
        return appLocalizations.greatGrandchild;
      case guardianship:
        return appLocalizations.guardianship;
      case nephewNiece:
        return appLocalizations.nephewNiece;
      case parent:
        return appLocalizations.fatherMother;
      case parentInLaw:
        return appLocalizations.fatherMotherInLaw;
      case partner:
        return appLocalizations.partner;
      case pensioners:
        return appLocalizations.pensioner;
      case pupil:
        return appLocalizations.dependent;
      case sibling:
        return appLocalizations.brotherSister;
      case sonDaughterInLaw:
        return appLocalizations.sonDaughterInLaw;
      case spouse:
        return appLocalizations.spouse;
      case stepfather:
        return appLocalizations.stepfather;
      case stepmother:
        return appLocalizations.stepmother;
      case stepchild:
        return appLocalizations.stepChildren;
      case trusteed:
        return appLocalizations.conservatee;
      case uncleAunt:
        return appLocalizations.uncleAunt;
      case other:
        return appLocalizations.other;
      default:
        return '';
    }
  }
}
