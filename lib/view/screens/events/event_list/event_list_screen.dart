import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/view/screens/events/create_event/create_event_screen.dart';
import 'package:sharing_cafe/view/screens/events/event_detail/event_detail_screen.dart';
import 'package:sharing_cafe/view/screens/events/event_list/components/event_card_2.dart';
import 'package:sharing_cafe/view/screens/events/my_event/my_event_screen.dart';
import 'package:sharing_cafe/view/screens/events/search/search_screen.dart';

import 'components/event_card.dart';

class EventListScreen extends StatelessWidget {
  static String routeName = "/events";
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/cafe.png',
              height: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('Sự kiện', style: heading2Style),
          ],
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
          IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              size: 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, MyEventScreen.routeName);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Đề xuất",
              style: heading2Style,
            ),
            SizedBox(
              height: 333,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  EventCard2(
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
                  EventCard2(
                    imageUrl: 'https://picsum.photos/id/236/200/300',
                    title: 'Lễ hội âm nhạc Infinity Street Festival 2024',
                    dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                    location: 'Quận 1, TP.Hồ Chí Minh',
                    attendeeCount: 88,
                    onTap: () {
                      Navigator.pushNamed(context, EventDetailScreen.routeName);
                    },
                  ),
                  EventCard2(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sự kiện mới",
                  style: heading2Style,
                ),
                IconButton(
                    onPressed: () {/* ... */},
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 24,
                      color: kPrimaryColor,
                    ))
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}