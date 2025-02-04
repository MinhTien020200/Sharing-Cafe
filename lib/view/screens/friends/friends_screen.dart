import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/provider/friends_provider.dart';
import 'package:sharing_cafe/view/screens/chat/chat_screen.dart';

class FriendsScreen extends StatefulWidget {
  static const routeName = "/friends";
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<FriendsProvider>(context, listen: false)
        .getListFriends()
        .then((value) => setState(() {
              _isLoading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bạn bè',
          style: heading2Style,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<FriendsProvider>(
                builder: (context, value, child) {
                  var matches = value.friends;
                  return ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      GlobalKey moreButtonKey = GlobalKey();
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ChatScreen.routeName,
                              arguments: {
                                'id': matches[index].userId,
                                'name': matches[index].userName,
                              });
                        },
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(matches[index].profileAvatar),
                            ),
                            title: Text(matches[index].userName),
                            subtitle: Text(matches[index].bio),
                            trailing: IconButton(
                                key: moreButtonKey,
                                onPressed: () {
                                  final RenderBox renderBox = moreButtonKey
                                      .currentContext
                                      ?.findRenderObject() as RenderBox;
                                  final Offset offset =
                                      renderBox.localToGlobal(Offset.zero);
                                  final RelativeRect position =
                                      RelativeRect.fromLTRB(
                                          offset.dx, offset.dy, 30, 0);
                                  showMenu(
                                      context: context,
                                      position: position,
                                      items: [
                                        PopupMenuItem(
                                          value: "unfriend",
                                          onTap: () {
                                            Provider.of<FriendsProvider>(
                                                    context,
                                                    listen: false)
                                                .unfriend(
                                                    matches[index].matchedId);
                                          },
                                          child: const Text(
                                            "Hủy kết bạn",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ]);
                                },
                                icon: const Icon(Icons.more_horiz)),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
