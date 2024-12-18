import 'package:flutter/material.dart';
import 'package:ngdemo28/core/services/log_service.dart';
import 'package:ngdemo28/core/services/utils_service.dart';
import 'package:ngdemo28/data/datasources/remote/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "no data";

  pickImageFromGallery() async{
    var base64Image = await Utils.pickAndConvertImage();
    LogService.i(base64Image);

    apiTestTextAndImage(base64Image);
  }

  apiTestTextOnly() async {
    String text = "How to learn Flutter faster?";

    var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextOnly(text));

    setState(() {
      result = response!;
    });
  }

  apiTestTextAndImage(String base64Image) async{
    String text = "What is it?";

    var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextAndImage(text, base64Image));

    setState(() {
      result = response!;
    });
  }

  @override
  void initState() {
    super.initState();
    //apiTestTextOnly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Gemini - GetX"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  color: Colors.blue,
                  child: Text("Pick image"),
                ),
                Text(
                  result,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ));
  }
}
