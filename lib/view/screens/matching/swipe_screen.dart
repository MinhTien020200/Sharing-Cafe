import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/profile_model.dart';
import 'package:sharing_cafe/view/screens/matching/components/profile_card.dart';

class SwipeScreen extends StatefulWidget {
  static String routeName = "swipe";
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  List<ProfileModel> profiles = [
    ProfileModel(
        image: "https://picsum.photos/id/12/1000/1000",
        name: "Ava",
        description: "Tập gym, Đọc sách, Bóng đá",
        age: 18),
    ProfileModel(
        image: "https://picsum.photos/id/1025/1000/1000",
        name: "Olivia",
        description: "Mountain biking, Cooking, Traveling",
        age: 20),
    ProfileModel(
        image: "https://picsum.photos/id/237/1000/1000",
        name: "Liam",
        description: "Photography, Surfing, Chess",
        age: 23),
    ProfileModel(
        image: "https://picsum.photos/id/1005/1000/1000",
        name: "Sophia",
        description: "Yoga, Painting, Science fiction",
        age: 25),
    ProfileModel(
        image: "https://picsum.photos/id/1027/1000/1000",
        name: "Ethan",
        description: "Playing guitar, Hiking, Robotics",
        age: 26),
    ProfileModel(
        image: "https://picsum.photos/id/1003/1000/1000",
        name: "Mia",
        description: null,
        age: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  return ProfileCard(
                    image: profiles[index].image,
                    name: profiles[index].name,
                    description: profiles[index].description,
                    age: profiles[index].age,
                  );
                },
                layout: SwiperLayout.TINDER,
                itemWidth: MediaQuery.of(context).size.width,
                itemHeight: MediaQuery.of(context).size.height,
                loop: true,
              ),
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.refresh, color: Colors.grey),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.star, color: Colors.blue),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.favorite, color: Colors.green),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.flash_on, color: Colors.purple),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
