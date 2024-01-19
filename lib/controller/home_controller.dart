import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttergem_showcase/utils/model/chat_model.dart';
import 'package:intl/intl.dart';

class HomeController {
  void Function(void Function()) setState;
  HomeController({required this.setState});
  TextEditingController chat = TextEditingController();
  bool isLoading = false;
  List<ChatModel> chatList = [];

  addMsg() {
    if (chat.text.isNotEmpty) {
      DateTime now = DateTime.now();

      String formattedTime24 = DateFormat('HH:mm').format(now);
      ChatModel newChat = ChatModel(
        time: formattedTime24.toString(),
        message: chat.text,
        isSender: true,
        id: 1,
      );
      setState(() {
        chatList.add(newChat);
      });
      chat.clear();
    }
  }

  getAnswer() async {
    DateTime now = DateTime.now();

    String formattedTime24 = DateFormat('HH:mm').format(now);
    const String key = "_YOUR KEY_";
    const String url =
        "https://generativelanguage.googleapis.com/v1beta/models/chat-bison-001:generateMessage?key=${key}";

    List<Map<String, String>> msg = [];
    for (var i in chatList) {
      msg.add({"content": i.message});
    }
    print(msg);
    Map<String, dynamic> request = {
      "prompt": {"messages": msg},
      "temperature": 1,
      "candidateCount": 1,
      "topP": 1,
      "topK": 1
    };
    setState(() {
      isLoading = true;
    });
    var response = await Dio().post(
      url,
      data: request,
    );

    setState(() {
      isLoading = false;
      ChatModel newChat = ChatModel(
        time: formattedTime24.toString(),
        message: response.data != null && response.data['candidates'] != null
            ? response.data['candidates'][0]['content'] ??
                'Saya bingung atas pertanyaan Anda'
            : 'maaf, saya tidak mengerti masud kamu',
        isSender: false,
        id: 2,
      );
      setState(() {
        chatList.add(newChat);
      });
    });
  }
}
