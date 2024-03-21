import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/provider/match_provider.dart';
import 'package:sharing_cafe/view/screens/friends/friends_screen.dart';
import 'package:sharing_cafe/view/screens/matching/components/profile_card.dart';

class SwipeScreen extends StatefulWidget {
  static String routeName = "/swipe";
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<MatchProvider>(context, listen: false)
        .initListProfiles()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sharing Coffee",
          style: heading2Style,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.messenger_outline),
            onPressed: () {
              Navigator.pushNamed(context, FriendsScreen.routeName);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Consumer<MatchProvider>(builder: (context, value, child) {
              var profiles = value.profiles;
              return Stack(children: [
                Column(
                  children: <Widget>[
                    Expanded(
                      // child: Swiper(
                      //   itemCount: profiles.length,
                      //   itemBuilder: (context, index) {
                      //     return ProfileCard(
                      //       image: profiles[index].image,
                      //       name: profiles[index].name,
                      //       description: profiles[index].description,
                      //       age: profiles[index].age,
                      //     );
                      //   },
                      //   layout: SwiperLayout.STACK,
                      //   loop: true,
                      //   itemWidth: MediaQuery.of(context).size.width,
                      //   itemHeight: MediaQuery.of(context).size.height,
                      //   onIndexChanged: (index) {
                      //     // When swipe right, selected user index is index - 1
                      //     // When swipe left, selected user index is index + 1
                      //     value.setCurrentProfileByIndex(index);
                      //   },
                      // ),
                      child: ProfileCard(
                        image: profiles.first.image,
                        name: profiles.first.name,
                        description: profiles.first.description,
                        age: profiles.first.age,
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
                            heroTag: "dislike",
                            onPressed: () async {
                              await value.likeOrUnlike(MatchStatus.dislike);
                            },
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.close, color: Colors.red),
                          ),
                          FloatingActionButton(
                            heroTag: "like",
                            onPressed: () async {
                              await value.likeOrUnlike(MatchStatus.pending);
                            },
                            backgroundColor: Colors.white,
                            child:
                                const Icon(Icons.favorite, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
            }),
    );
  }
}
