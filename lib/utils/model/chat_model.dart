import 'dart:typed_data';

class ChatModel {
  final int id;
  final String time;
  final String message;
  Uint8List? images;
  final bool isSender;

  ChatModel({
    required this.id,
    required this.time,
    required this.message,
    this.images,
    required this.isSender,
  });
}
