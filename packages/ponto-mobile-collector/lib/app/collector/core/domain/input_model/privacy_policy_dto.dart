class PrivacyPolicyDto {
  DateTime? dateTimeEventCreated;
  DateTime? dateTimeEventRead;
  int version;
  String urlVersion;

  PrivacyPolicyDto({
    this.dateTimeEventCreated,
    this.dateTimeEventRead,
    required this.version,
    required this.urlVersion,
  });
}
