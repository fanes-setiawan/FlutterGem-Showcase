import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatWidget {
  static textMsg({
    required BuildContext context,
    required String id,
    required isSender,
    required String messageTime,
    String? message,
  }) {
    return Column(
      children: [
        ChatBubble(
          clipper: ChatBubbleClipper3(
            type: isSender ? BubbleType.sendBubble : BubbleType.receiverBubble,
          ),
          alignment: isSender ? Alignment.topRight : Alignment.topLeft,
          backGroundColor: isSender
              ? Colors.pink.withOpacity(0.5)
              : Colors.grey.withOpacity(0.5),
          margin: const EdgeInsets.only(top: 5),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message.toString(),
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black,
              ),
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
