import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart' as g;
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:fluttergem_showcase/utils/model/chat_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HomeController {
  void Function(void Function()) setState;
  HomeController({required this.setState});
  TextEditingController text = TextEditingController();

  // final gemini = g.Gemini.instance;
  bool isLoading = false;
  // XFile? selectedImage;
  final ImagePicker picker = ImagePicker();
  String? searchedText, result;

  Uint8List? selectedImage;

  final gemini = Gemini.instance;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  final List<Content> chats = [];
  final List<ChatModel> chatList = [];

  void sendMsg() {
    DateTime now = DateTime.now();
    String formattedTime24 = DateFormat('HH:mm').format(now);
    if (text.text.isNotEmpty && selectedImage == null) {
      final searchedText = text.text;
      Content userChat = Content(
        role: 'user',
        parts: [
          Parts(
            text: searchedText,
          )
        ],
      );
      chats.add(userChat);
      ChatModel newChat = ChatModel(
        id: 1,
        time: formattedTime24.toString(),
        message: userChat.parts?.firstOrNull?.text ?? 'cannot generate data!',
        isSender: true,
      );
      chatList.add(newChat);
      text.clear();
      loading = true;

      gemini.chat(chats).then((value) {
        Content participantChat = Content(
          role: 'model',
          parts: [
            Parts(
              text: value?.output,
            ),
          ],
        );
        chats.add(participantChat);
        ChatModel newChats = ChatModel(
          id: 2,
          time: formattedTime24.toString(),
          message: participantChat.parts?.firstOrNull?.text ??
              'cannot generate data!',
          isSender: false,
        );
        chatList.add(newChats);
        loading = false;
      });
    } else if (text.text.isNotEmpty && selectedImage != null) {
      searchedText = text.text;
      ChatModel newChat = ChatModel(
        id: 1,
        images: selectedImage,
        time: formattedTime24.toString(),
        message: searchedText!,
        isSender: true,
      );

      chatList.add(newChat);
      text.clear();
      loading = true;

      gemini.textAndImage(text: searchedText!, images: [selectedImage!]).then(
        (value) {
          result = value?.content?.parts?.last.text;
          loading = false;

          ChatModel newChats = ChatModel(
            id: 3,
            time: formattedTime24.toString(),
            message: result ?? 'cannot generate data!',
            isSender: false,
          );

          setState(() {
            chatList.add(newChats);
          });
        },
      );
    }
  }

  Future<void> pickImage() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      photo.readAsBytes().then(
            (value) => setState(
              () {
                selectedImage = Uint8List.fromList(value);
              },
            ),
          );
    }
  }
}
