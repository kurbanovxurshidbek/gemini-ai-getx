import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngdemo28/core/services/log_service.dart';
import 'package:ngdemo28/core/services/utils_service.dart';
import 'package:ngdemo28/data/datasources/remote/http_service.dart';
import 'package:ngdemo28/presentation/controllers/home_controller.dart';

import '../widgets/item_gemini_message.dart';
import '../widgets/item_user_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<HomeController>(
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                  child: Image(
                    image: AssetImage('assets/images/gemini_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: _controller.messages.isNotEmpty
                        ? ListView.builder(
                            itemCount: _controller.messages.length,
                            itemBuilder: (context, index) {
                              var message = _controller.messages[index];
                              if (message.isMine!) {
                                return itemOfUserMessage(message);
                              } else {
                                return itemOfGeminiMessage(message);
                              }
                            },
                          )
                        : Center(
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child:
                                  Image.asset('assets/images/gemini_icon.png'),
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller.textController,
                              maxLines: null,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Message",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _controller.askToGemini();
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
