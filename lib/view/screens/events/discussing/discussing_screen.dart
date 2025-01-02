import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/discussing_model.dart';
import 'package:sharing_cafe/service/event_service.dart';
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
  List<DiscussingModel> _discussingList = [];

  @override
  void initState() {
    super.initState();
  }

  Future getDiscuss(eventId) {
    return EventService().getDiscussing(eventId!).then((value) {
      setState(() {
        _discussingList = value;
      });
    });
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
                        return const DiscussingPopup();
                      });
                },
                child: const Text('Tạo thảo luận'),
              ),
            ),

            const SizedBox(height: 20),
            FutureBuilder(
                future: getDiscuss(_eventId),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _discussingList.length,
                    itemBuilder: (context, index) {
                      var item = _discussingList[index];
                      return DiscussingItem(
                        ownerAvatar: 'https://picsum.photos/200',
                        ownerName: item.title,
                        content: item.content,
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
