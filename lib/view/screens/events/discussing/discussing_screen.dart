import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/provider/event_provider.dart';
import 'package:sharing_cafe/view/components/custom_network_image.dart';
import 'package:sharing_cafe/view/screens/events/discussing/discussing_item.dart';
import 'package:sharing_cafe/view/screens/events/discussing/discussing_popup.dart';

class DiscussingScreen extends StatefulWidget {
  static const routeName = '/discussing-screen';
  const DiscussingScreen({super.key});

  @override
  State<DiscussingScreen> createState() => _DiscussingScreenState();
}

class _DiscussingScreenState extends State<DiscussingScreen> {
  String? _eventName;
  String? _eventImage;
  String? _eventId;
  @override
  void initState() {
    if (_eventId != null) {
      Provider.of<EventProvider>(context, listen: false)
          .getDiscussions(_eventId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arg != null) {
      _eventName = arg["eventName"] as String;
      _eventImage = arg["image"] as String;
      _eventId = arg["id"] as String;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_eventName ?? 'Thảo luận'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              url: _eventImage ?? '',
              height: 300,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            // create a new discuss button and show popup window
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return DiscussingPopup(eventId: _eventId!);
                      });
                },
                child: const Text('Tạo thảo luận'),
              ),
            ),

            const SizedBox(height: 20),
            Consumer<EventProvider>(builder: (context, value, child) {
              var discussingList = value.discussions;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: discussingList.length,
                itemBuilder: (context, index) {
                  var item = discussingList[index];
                  return DiscussingItem(
                    ownerAvatar:
                        item.profileAvatar ?? 'https://picsum.photos/200',
                    ownerName: item.userName ?? "",
                    content: item.content,
                    title: item.title,
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
