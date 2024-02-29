import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/view/screens/blogs/all_blog/all_blog_screen.dart';
import 'package:sharing_cafe/view/screens/blogs/blog_categories.dart/blog_categories_screen.dart';
import 'package:sharing_cafe/view/screens/blogs/blog_category.dart/blog_category_screen.dart';
import 'package:sharing_cafe/view/screens/blogs/blog_list/components/blog_card_2.dart';
import 'package:sharing_cafe/view/screens/blogs/blog_list/components/blog_card_3.dart';
import 'package:sharing_cafe/view/screens/events/create_event/create_event_screen.dart';
import 'package:sharing_cafe/view/screens/events/event_detail/event_detail_screen.dart';
import 'package:sharing_cafe/view/screens/events/search/search_screen.dart';

import 'components/blog_card.dart';

class BlogListScreen extends StatelessWidget {
  static String routeName = "/blogs";
  const BlogListScreen({super.key});

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
            const Text('Blog', style: heading2Style),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Phổ biến",
                style: heading2Style,
              ),
            ),
            SizedBox(
              height: 280,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  BlogCard2(
                    imageUrl: 'https://picsum.photos/id/230/200/300',
                    title:
                        'Hội thảo nghệ thuật "Sell Yourself" - Hành trình Khởi lửa hành trang',
                    dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                    location: 'Quận 1, TP.Hồ Chí Minh',
                    attendeeCount: 88,
                    avtUrl: 'https://picsum.photos/id/200/200/300',
                    ownerName: "Thịnh",
                    time: "2 ngày trước",
                    onTap: () {
                      Navigator.pushNamed(context, EventDetailScreen.routeName);
                    },
                  ),
                  BlogCard2(
                    imageUrl: 'https://picsum.photos/id/236/200/300',
                    title: 'Lễ hội âm nhạc Infinity Street Festival 2024',
                    dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                    location: 'Quận 1, TP.Hồ Chí Minh',
                    attendeeCount: 88,
                    avtUrl: 'https://picsum.photos/id/199/200/300',
                    ownerName: "Kiều",
                    time: "6 ngày trước",
                    onTap: () {
                      Navigator.pushNamed(context, EventDetailScreen.routeName);
                    },
                  ),
                  BlogCard2(
                    imageUrl: 'https://picsum.photos/id/233/200/300',
                    title:
                        'M\'aRTISaN Workshop: Workshop vẽ tranh Canvas - THE WORLD AT YOUR FINGERTIPS',
                    dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                    location: 'Quận 1, TP.Hồ Chí Minh',
                    attendeeCount: 88,
                    avtUrl: 'https://picsum.photos/id/198/200/300',
                    ownerName: "An",
                    time: "10 ngày trước",
                    onTap: () {
                      Navigator.pushNamed(context, EventDetailScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Khám phá theo chủ đề",
                    style: heading2Style,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, BlogCategoriesScreen.routeName);
                    },
                    child: const Text(
                      "Xem tất cả",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 128,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                BlogCard3(
                  imageUrl: 'https://picsum.photos/id/23/200/300',
                  title: 'Du lịch',
                  number: 323,
                  onTap: () {
                    Navigator.pushNamed(context, BlogCategoryScreen.routeName);
                  },
                ),
                BlogCard3(
                  imageUrl: 'https://picsum.photos/id/43/200/300',
                  title: 'Sức khỏe',
                  number: 323,
                  onTap: () {
                    Navigator.pushNamed(context, BlogCategoryScreen.routeName);
                  },
                ),
                BlogCard3(
                  imageUrl: 'https://picsum.photos/id/54/200/300',
                  title: 'Đời sống',
                  number: 323,
                  onTap: () {
                    Navigator.pushNamed(context, BlogCategoryScreen.routeName);
                  },
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Blogs mới",
                    style: heading2Style,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AllBlogScreen.routeName);
                    },
                    child: const Text(
                      "Xem tất cả",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  )
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                BlogCard(
                  imageUrl: 'https://picsum.photos/id/123/200/300',
                  title:
                      'Hội thảo nghệ thuật "Sell Yourself" - Hành trình Khởi lửa hành trang',
                  dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                  location: 'Quận 1, TP.Hồ Chí Minh',
                  attendeeCount: 88,
                  avtUrl: 'https://picsum.photos/id/43/200/300',
                  ownerName: 'Bùi Hoàng Việt Anh',
                  time: '5 phút trước',
                  onTap: () {
                    Navigator.pushNamed(context, EventDetailScreen.routeName);
                  },
                ),
                BlogCard(
                  imageUrl: 'https://picsum.photos/id/765/200/300',
                  title: 'Lễ hội âm nhạc Infinity Street Festival 2024',
                  dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                  location: 'Quận 1, TP.Hồ Chí Minh',
                  attendeeCount: 88,
                  avtUrl: 'https://picsum.photos/id/215/200/300',
                  ownerName: 'Phạm Hải Yến',
                  time: '8 phút trước',
                  onTap: () {
                    Navigator.pushNamed(context, EventDetailScreen.routeName);
                  },
                ),
                BlogCard(
                  imageUrl: 'https://picsum.photos/id/233/200/300',
                  title:
                      'M\'aRTISaN Workshop: Workshop vẽ tranh Canvas - THE WORLD AT YOUR FINGERTIPS',
                  dateTime: 'T2, 20 THÁNG 5 LÚC 18.00',
                  location: 'Quận 1, TP.Hồ Chí Minh',
                  attendeeCount: 88,
                  avtUrl: 'https://picsum.photos/id/23/200/300',
                  ownerName: 'Khuất Văn Khang',
                  time: '12 phút trước',
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
