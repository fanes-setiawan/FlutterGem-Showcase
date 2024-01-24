import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../colors/my_colors.dart';

class ChatWidget {
  static textMsg({
    required BuildContext context,
    required String id,
    Uint8List? image,
    required isSender,
    required String messageTime,
    String? message,
  }) {
    return Column(
      children: [
        ChatBubble(
          clipper: ChatBubbleClipper5(
            type: isSender ? BubbleType.sendBubble : BubbleType.receiverBubble,
          ),
          alignment: isSender ? Alignment.topRight : Alignment.topLeft,
          backGroundColor:
              isSender ? CustomColors.accentColor : CustomColors.primaryColor,
          margin: const EdgeInsets.only(top: 5),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null)
                  SizedBox(
                    height: 150,
                    child: Image.memory(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                Text(
                  message.toString(),
                  style: TextStyle(
                    color: isSender ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              messageTime,
              style: const TextStyle(
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
