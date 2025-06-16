class CheckFeatureToggleMapper {
  bool fromMap({
    required Map<String, dynamic> map,
  }) {
    return map['hasFeature'];
  }
}
