import 'package:flutter/material.dart';
import 'package:fluttergem_showcase/controller/home_controller.dart';
import 'package:fluttergem_showcase/utils/widget/chat_widget.dart';
import 'package:lottie/lottie.dart';

import '../utils/colors/my_colors.dart';

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
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(
              "https://s.yimg.com/ny/api/res/1.2/NzZ0s1pTMaLwMfmFcQnwjw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTY0MTtjZj13ZWJw/https://media.zenfs.com/en/news_direct/837728a991311adad97f53255197a388",
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kepo-In',
              style: TextStyle(
                color: CustomColors.backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                if (_controller!.loading == false)
                  const CircleAvatar(
                    radius: 4.0,
                    backgroundColor: Colors.green,
                  ),
                Text(
                  _controller!.loading ? "sedang mengetik...." : " Online",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (_controller!.chatList.isNotEmpty)
            IconButton(
              onPressed: () {
                _controller?.chatList.clear();
                setState(() {});
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 26.0,
              ),
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            if (_controller!.chatList.isEmpty) const Spacer(),
            if (_controller!.chatList.isEmpty)
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/chatAi.json',
                      ),
                      const Text(
                        "tanyakan sesuatu ke saya!!!",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                          image: msg.images,
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
            if (_controller?.selectedImage != null)
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _controller!.selectedImage = null;
                                  setState(() {});
                                },
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 20.0,
                                ),
                              ),
                              const Text(
                                "Images",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "tanyakan gambar ini?",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Image.memory(
                        _controller!.selectedImage!,
                        fit: BoxFit.cover,
                      ),
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
                            padding: EdgeInsets.zero,
                            child: IconButton(
                              onPressed: () async {
                                _controller!.pickImage();
                              },
                              icon: const Icon(
                                Icons.image,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _controller?.text,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              minLines: 1,
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
                      _controller!.sendMsg();
                      _controller?.selectedImage = null;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.black,
                      size: 35.0,
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
