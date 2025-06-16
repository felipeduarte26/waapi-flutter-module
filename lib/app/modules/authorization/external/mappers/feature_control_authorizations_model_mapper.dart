import 'dart:convert';

import '../../infra/models/feature_control_authorization_model.dart';

class FeatureControlAuthorizationsModelMapper {
  FeatureControlAuthorizationModel fromMap({
    required List requestUpdatePermissions,
  }) {
    final personalDataStatus = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_DADOS_PESSOAIS').first['active'] ?? false
        : false;

    final emergencyContactStatus = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_CONTATO_EMERGENCIA').first['active'] ??
            false
        : false;

    final personalAddressStatus = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_ENDERECOS_PESSOAIS').first['active'] ??
            false
        : false;

    final personalContactStatus = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_CONTATOS_PESSOAIS').first['active'] ?? false
        : false;

    final personalDocumentsStatus = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_DOCUMENTOS_PESSOAIS').first['active'] ??
            false
        : false;

    final personalDependentsStatus = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_DEPENDENTE').first['active'] ?? false
        : false;

    final enableDependentIncomeTax = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions
                .where((e) => e['featureName'] == 'HABILITAR_DEPENDENTE_IMPOSTO_DE_RENDA')
                .first['active'] ??
            false
        : false;

    final allowToPayroll = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'EXIBIR_DADOS_FINANCEIROS_WAAPI').first['active'] ??
            false
        : false;

    final enablePersonalPhoto = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_FOTO_PESSOAL').first['active'] ?? false
        : false;

    final allowToMaintainSelfDeclaration = (requestUpdatePermissions.isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['featureName'] == 'MANTER_AUTODECLARACAO').first['active'] ?? false
        : false;

    return FeatureControlAuthorizationModel(
      allowUpdatePersonalData: personalDataStatus,
      allowUpdateEmergencyContact: emergencyContactStatus,
      allowUpdatePersonalAddress: personalAddressStatus,
      allowUpdatePersonalContact: personalContactStatus,
      allowUpdatePersonalDocuments: personalDocumentsStatus,
      allowUpdatePersonalDependents: personalDependentsStatus,
      enableDependentIncomeTax: enableDependentIncomeTax,
      allowToPayroll: allowToPayroll,
      enablePersonalPhoto: enablePersonalPhoto,
      allowToMaintainSelfDeclaration: allowToMaintainSelfDeclaration,
    );
  }

  FeatureControlAuthorizationModel fromJson({
    required String json,
  }) {
    return fromMap(
      requestUpdatePermissions: jsonDecode(json),
    );
  }
}
