// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/model/chat_message_model.dart';
import 'package:sharing_cafe/provider/chat_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = true;
  late String _userId;
  late String _loggedUserId;
  late io.Socket socket;

  void connectAndListen() {
    socket = io.io(ApiHelper().socketBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on('message', (data) {
      var message = ChatMessageModel.fromJson(data);
      message.messageType = message.receiverId == _userId;
      Provider.of<ChatProvider>(context, listen: false).addMessage(message);
    });

    socket.connect();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero, () {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      var id = arguments['id'];
      setState(() {
        _userId = id;
      });
      return id;
    })
        .then((value) => Provider.of<ChatProvider>(context, listen: false)
            .getUserMessagesHistory(value))
        .then((_) => SharedPrefHelper.getUserId())
        .then((value) => setState(() {
              _loggedUserId = value;
            }))
        .then((_) => connectAndListen())
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.close();
    print("disconnected");
    super.dispose();
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      var data = {
        'from': _loggedUserId,
        'to': _userId,
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
      };
      socket.emit('message', data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: Consumer<ChatProvider>(
                      builder: (context, provider, child) {
                    var messages = provider.getUserMessages(_userId);
                    return ListView.builder(
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          var message = ChatMessageModel(
                            messageId: messages[index].messageId,
                            senderId: messages[index].senderId,
                            senderAvt: messages[index].senderAvt,
                            senderName: messages[index].senderName,
                            receiverId: messages[index].receiverId,
                            receiverAvt: messages[index].receiverAvt,
                            receiverName: messages[index].receiverName,
                            messageContent: messages[index].messageContent,
                            createdAt: messages[index].createdAt,
                            messageType:
                                !(messages[index].receiverId == _userId),
                          );
                          var chatComponent = <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  !message.messageType!
                                      ? message.senderAvt
                                      : message.receiverAvt),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (message.messageType!
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(message.messageContent),
                            ),
                          ];
                          if (!message.messageType!) {
                            chatComponent = chatComponent.reversed.toList();
                          }
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: message.messageType!
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: chatComponent,
                            ),
                          );
                        });
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
