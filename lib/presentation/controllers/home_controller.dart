import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngdemo28/core/services/log_service.dart';
import 'package:ngdemo28/data/repositories/gemini_talk_repository_impl.dart';
import 'package:ngdemo28/domain/usecases/gemini_text_only_usecase.dart';

import '../../data/models/message_model.dart';

class HomeController extends GetxController {
  TextEditingController textController = TextEditingController();
  List<MessageModel> messages = [];

  GeminiTextOnlyUseCase textOnlyUseCase = GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());

  askToGemini() {
    String message = textController.text.toString().trim();

    if (message.isNotEmpty) {
      MessageModel mine = MessageModel(isMine: true, message: message);
      updateMessage(mine);
      apiTextOnly(message);
    }

    textController.clear();
  }

  updateMessage(MessageModel messageModel) {
    messages.add(messageModel);
    update();
  }

  apiTextOnly(String text) async {
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.e(l);
      MessageModel messageModel = MessageModel(isMine: false, message: l);
      updateMessage(messageModel);
    }, (r) {
      LogService.i(r);
      MessageModel messageModel = MessageModel(isMine: false, message: r);
      updateMessage(messageModel);
    });
  }
}
