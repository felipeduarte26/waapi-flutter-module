class PushMessageEntity {
  String? id;
  String? title;
  String? messageContent;
  DateTime? createdAt;
  bool? read;

  PushMessageEntity({
    this.id,
    this.title,
    this.messageContent,
    this.createdAt,
    this.read,
  });

  factory PushMessageEntity.fromJson(Map<String, dynamic> json) {
    return PushMessageEntity(
      id: json['id'] as String?,
      title: json['title'] as String?,
      messageContent: json['messageContent'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      read: json['read'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messageContent': messageContent,
      'createdAt': createdAt?.toIso8601String(),
      'read': read,
    };
  }
}
