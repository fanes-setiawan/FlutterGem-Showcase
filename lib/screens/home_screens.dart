import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:fluttergem_showcase/controller/home_controller.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  HomeController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ChatBubble(
              clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 20),
              backGroundColor: Colors.blue,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: const Text(
                  "assalamualaikum",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ChatBubble(
              clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
              backGroundColor: const Color(0xffE7E7ED),
              margin: const EdgeInsets.only(top: 20),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: const Text(
                  "wallaikumsallam wr wb.",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: null,
                            decoration: InputDecoration.collapsed(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "enter questions...",
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                              ),
                              hoverColor: Colors.transparent,
                            ),
                            onFieldSubmitted: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
