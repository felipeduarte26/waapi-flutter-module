class HasUnreadPushMessageEntity {
  bool hasUnreadPushMessage;
  int number;

  HasUnreadPushMessageEntity({
    required this.hasUnreadPushMessage,
    required this.number,
  });

  factory HasUnreadPushMessageEntity.fromJson(Map<String, dynamic> json) {
    return HasUnreadPushMessageEntity(
      hasUnreadPushMessage: json['hasUnreadPushMessage'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasUnreadPushMessage': hasUnreadPushMessage,
      'number': number,
    };
  }
}
