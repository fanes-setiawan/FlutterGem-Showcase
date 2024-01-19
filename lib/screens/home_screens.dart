import 'package:flutter/material.dart';
import 'package:fluttergem_showcase/controller/home_controller.dart';
import 'package:fluttergem_showcase/utils/widget/chat_widget.dart';

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
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(
              "https://awsimages.detik.net.id/community/media/visual/2023/06/26/ilustrasi-robot_169.jpeg?w=1200",
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AI Chatbot '),
            Text(
              _controller!.isLoading ? "sedang mengetik...." : "Online",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                controller: ScrollController(),
                child: Column(
                  children: [
                    if (_controller != null)
                      ..._controller!.chatList.map((msg) {
                        return ChatWidget.textMsg(
                          context: context,
                          message: msg.message,
                          id: msg.id.toString(),
                          messageTime: msg.time.toString(),
                          isSender: msg.isSender,
                        );
                      }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // height: 50,
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _controller?.chat,
                              initialValue: null,
                              decoration: InputDecoration.collapsed(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "kirim pesan . . .",
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                ),
                                hoverColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      _controller?.addMsg();
                      await _controller?.getAnswer();
                      setState(() {});
                      for (var data in _controller!.chatList) {
                        print(data.message);
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
