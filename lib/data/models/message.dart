class Message {
  final String id;
  final String message;
  final String sender;
  final DateTime? modifiedAt;

  Message({
    required this.id,
    required this.message,
    required this.sender,
    required this.modifiedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'],
    message: json['message'],
    sender: json['sender'],
    modifiedAt:
        json['modified_at'] != null && json['modified_at'] is int
            ? DateTime.fromMillisecondsSinceEpoch(json['modified_at']).toLocal()
            : null,
  );

  Map<String, dynamic> toJson() => {'message': message, 'sender': sender};
}
