import 'dart:convert';

class ActiveTenantModulesModelMapper {
  bool fromMap({
    required List modules,
  }) {
    final isWaapiLite = (modules.isNotEmpty) ? modules.contains('MANAGEMENT_PANEL_LITE') : false;

    return isWaapiLite;
  }

  bool fromJson({
    required String json,
  }) {
    return fromMap(
      modules: jsonDecode(json),
    );
  }
}
