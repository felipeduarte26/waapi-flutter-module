class ConfirmReadPushMessageEntity {
  bool confirmed;

  ConfirmReadPushMessageEntity({
    required this.confirmed,
  });

  factory ConfirmReadPushMessageEntity.fromJson(Map<String, dynamic> json) {
    return ConfirmReadPushMessageEntity(
      confirmed: json['confirmed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'confirmed': confirmed,
    };
  }
}
