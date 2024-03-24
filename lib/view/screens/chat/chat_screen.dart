// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/stream_socket.dart';
import 'package:sharing_cafe/model/chat_message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessageModel> messages = [
    ChatMessageModel(messageContent: "Hello, how are you?", messageType: true),
    ChatMessageModel(
        messageContent: "I'm fine, thanks! How about you?", messageType: false),
    // Add more messages here
  ];

  TextEditingController _controller = TextEditingController();

  late IO.Socket socket;

  void connectAndListen() {
    socket = IO.io(ApiHelper().socketBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on('message', (data) {
      print('Message from server: $data');
    });

    socket.connect();
  }

  @override
  void initState() {
    super.initState();
    connectAndListen();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      socket.emit('message', message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var message = ChatMessageModel(
                      messageContent: messages[index].messageContent,
                      messageType: messages[index].messageType);
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: (message.messageType
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (message.messageType
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(message.messageContent),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      constraints: const BoxConstraints(
                        maxHeight: 50,
                        minHeight: 10,
                      ),
                      hintStyle: const TextStyle(fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (String messageText) {},
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
