class PrivacyPolicyEntity {
  DateTime? dateTimeEventCreated;
  DateTime? dateTimeEventRead;
  int version;
  String urlVersion;

  PrivacyPolicyEntity({
    this.dateTimeEventCreated,
    this.dateTimeEventRead,
    required this.version,
    required this.urlVersion,
  });
}
