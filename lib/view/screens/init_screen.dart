import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/view/screens/blogs/blog_list/blog_list_screen.dart';
import 'package:sharing_cafe/view/screens/events/event_list/event_list_screen.dart';
import 'package:sharing_cafe/view/screens/matching/swipe_screen.dart';
import 'package:sharing_cafe/view/screens/home/home_screen.dart';
import 'package:sharing_cafe/view/screens/profiles/profile_page/profile_screen.dart';

const Color inActiveIconColor = kPrimaryColor;

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const HomeScreen(),
    const EventListScreen(),
    const SwipeScreen(),
    const BlogListScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/home.svg",
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/event.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/event.svg",
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Event",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/cafe.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/cafe.svg",
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Match",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/blog.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/blog.svg",
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Blog",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
