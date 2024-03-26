import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/chat_message_model.dart';
import 'package:sharing_cafe/service/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final Map<String, List<ChatMessageModel>> _mapUserMessages = {};

  Future getUserMessagesHistory(String userId) async {
    var history = await ChatService().getHistory(userId);
    if (_mapUserMessages.containsKey(userId)) {
      _mapUserMessages[userId] = history;
    } else {
      _mapUserMessages.putIfAbsent(userId, () => history);
    }
    notifyListeners();
  }

  List<ChatMessageModel> getUserMessages(String userId) {
    return _mapUserMessages[userId] ?? [];
  }

  void addMessage(ChatMessageModel chatMessageModel) {
    if (_mapUserMessages.containsKey(chatMessageModel.senderId)) {
      _mapUserMessages[chatMessageModel.senderId]!.add(chatMessageModel);
    }
    if (_mapUserMessages.containsKey(chatMessageModel.receiverId)) {
      _mapUserMessages[chatMessageModel.receiverId]!.add(chatMessageModel);
    }
    notifyListeners();
  }
}
