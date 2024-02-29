import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/view/screens/events/create_event/create_event_screen.dart';
import 'package:sharing_cafe/view/screens/events/event_detail/event_detail_screen.dart';
import 'package:sharing_cafe/view/screens/events/event_list/components/event_card.dart';

class MyEventScreen extends StatefulWidget {
  static String routeName = "/my-event";
  const MyEventScreen({super.key});

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sự kiện của bạn",
          style: heading2Style,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_box_outlined,
              size: 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, CreateEventScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            EventCard(
              imageUrl: 'https://picsum.photos/id/230/200/300',
              title:
                  'Hội thảo nghệ thuật "Sell Yourself" - Hành trình Khởi lửa hành trang',
              dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
              location: 'Quận 1, TP.Hồ Chí Minh',
              attendeeCount: 88,
              onTap: () {
                Navigator.pushNamed(context, EventDetailScreen.routeName);
              },
            ),
            EventCard(
              imageUrl: 'https://picsum.photos/id/236/200/300',
              title: 'Lễ hội âm nhạc Infinity Street Festival 2024',
              dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
              location: 'Quận 1, TP.Hồ Chí Minh',
              attendeeCount: 88,
              onTap: () {
                Navigator.pushNamed(context, EventDetailScreen.routeName);
              },
            ),
            EventCard(
              imageUrl: 'https://picsum.photos/id/233/200/300',
              title:
                  'M\'aRTISaN Workshop: Workshop vẽ tranh Canvas - THE WORLD AT YOUR FINGERTIPS',
              dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
              location: 'Quận 1, TP.Hồ Chí Minh',
              attendeeCount: 88,
              onTap: () {
                Navigator.pushNamed(context, EventDetailScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
