import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/service/image_service.dart';

class ProfileCard extends StatefulWidget {
  final String refId;
  final String image;
  final String name;
  final String? description;
  final String age;
  final bool isDetailPage;
  const ProfileCard({
    super.key,
    required this.refId,
    required this.image,
    required this.name,
    this.description,
    required this.age,
    required this.isDetailPage,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  List<String> profileImages = [];
  @override
  void initState() {
    if (widget.isDetailPage) {
      getProfileGallery();
    }
    super.initState();
  }

  Future getProfileGallery() async {
    profileImages.add(widget.image);
    final profileGallery = await ImageService()
        .getImageLinks(refId: widget.refId, type: ImageType.user);
    setState(() {
      profileImages.addAll(profileGallery.map((e) => e.url).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        Positioned.fill(
          child: widget.isDetailPage
              ? Swiper(
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(profileImages[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                      ),
                  itemCount: profileImages.length,
                  pagination: const SwiperPagination(),
                  loop: false,
                  control: const SwiperControl(
                    color: kPrimaryColor,
                  ))
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.0, 1.0]),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${widget.name}, ${widget.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    if (widget.description != null)
                      Text(
                        widget.description!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
