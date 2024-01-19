class ChatModel {
  final int id;
  final String time;
  final String message;
  final bool isSender;

  ChatModel({
    required this.id,
    required this.time,
    required this.message,
    required this.isSender,
  });
}
