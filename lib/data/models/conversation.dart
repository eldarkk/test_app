class Conversation {
  String id;
  String lastMessage;
  List<String> members;
  String topic;
  DateTime? modifiedAt;

  Conversation({
    required this.id,
    required this.lastMessage,
    required this.members,
    required this.topic,
    required this.modifiedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    lastMessage: json["last_message"],
    members: List<String>.from(json["members"].map((x) => x)),
    topic: json["topic"],
    modifiedAt:
        json['modified_at'] != null && json['modified_at'] is int
            ? DateTime.fromMillisecondsSinceEpoch(json['modified_at']).toLocal()
            : null,
  );
}
