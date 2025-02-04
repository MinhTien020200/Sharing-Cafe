// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/provider/account_provider.dart';
import 'package:sharing_cafe/provider/user_profile_provider.dart';
import 'package:sharing_cafe/view/components/custom_network_image.dart';
import 'package:sharing_cafe/view/screens/appointment/appointment_history.dart';
// import 'package:sharing_cafe/view/screens/auth/complete_profile/complete_profile_screen.dart';
import 'package:sharing_cafe/view/screens/auth/login/login_screen.dart';
import 'package:sharing_cafe/view/screens/blogs/my_blogs/my_blog_screen.dart';
import 'package:sharing_cafe/view/screens/calendar/my_calendar_screen.dart';
import 'package:sharing_cafe/view/screens/events/my_event/my_event_screen.dart';
import 'package:sharing_cafe/view/screens/profiles/preview_my_profile/preview_my_profile_screen.dart';
import 'package:sharing_cafe/view/screens/profiles/profile_page/components/profile_menu.dart';
import 'package:sharing_cafe/view/screens/profiles/update_profile/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<UserProfileProvider>(context, listen: false)
        .getUserProfile()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountProvider>(context);
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
            Text('Hồ sơ', style: heading2Style.copyWith(color: kPrimaryColor)),
          ],
        ),
      ),
      body: Consumer<UserProfileProvider>(builder: (context, value, child) {
        var userProfile = value.userProfile;
        return _isLoading && userProfile == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CustomNetworkImage(
                                  url: userProfile!.profileAvatar,
                                  fit: BoxFit.cover))),
                      const SizedBox(height: 10),
                      Text(
                        userProfile.userName,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(userProfile.story ?? "",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, UpdateProfileScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("Chỉnh sửa",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PreviewMyProfileScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("Xem trước",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),

                      //MENU
                      ProfileMenu(
                          title: "Workshop của bạn",
                          icon: LineAwesomeIcons.calendar_check,
                          onPress: () {
                            Navigator.pushNamed(
                                context, MyEventScreen.routeName);
                          }),
                      ProfileMenu(
                          title: "Lịch",
                          icon: LineAwesomeIcons.calendar,
                          onPress: () {
                            Navigator.pushNamed(
                                context, MyCalendarScreen.routeName);
                          }),
                      ProfileMenu(
                          title: "Blog của bạn",
                          icon: LineAwesomeIcons.blog,
                          onPress: () {
                            Navigator.pushNamed(
                                context, MyBlogScreen.routeName);
                          }),
                      // ProfileMenu(
                      //     title: "Hoàn thiện hồ sơ",
                      //     icon: LineAwesomeIcons.candy_cane,
                      //     onPress: () {
                      //       Navigator.pushNamed(
                      //           context, CompleteProfileScreen.routeName);
                      //     }),
                      ProfileMenu(
                          title: "Lịch sử cuộc hẹn",
                          icon: LineAwesomeIcons.history,
                          onPress: () async {
                            var loggedUserId =
                                await SharedPrefHelper.getUserId();
                            Navigator.pushNamed(
                                context, AppointmentHistoryScreen.routeName,
                                arguments: loggedUserId);
                          }),
                      const Divider(color: Colors.grey),
                      // ProfileMenu(
                      //     title: "Thời tiết",
                      //     icon: LineAwesomeIcons.cloud_with_sun,
                      //     onPress: () {}),
                      ProfileMenu(
                          title: "Đăng Xuất",
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () async {
                            try {
                              await accountService.logout();
                            } catch (e) {
                              return;
                            }
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.routeName, (route) => false);
                          }),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
