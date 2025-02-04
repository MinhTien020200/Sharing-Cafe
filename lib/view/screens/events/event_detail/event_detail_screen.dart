// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_cafe/constants.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/helper/datetime_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/model/event_participant.dart';
import 'package:sharing_cafe/provider/event_provider.dart';
import 'package:sharing_cafe/service/event_service.dart';
import 'package:sharing_cafe/service/image_service.dart';
import 'package:sharing_cafe/view/components/custom_network_image.dart';
import 'package:sharing_cafe/view/components/form_field.dart';
import 'package:sharing_cafe/view/screens/events/discussing/discussing_screen.dart';

class EventDetailScreen extends StatefulWidget {
  static String routeName = "/event-detail";
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _canJoinEvent = true;
  String _loggedUser = "";
  String id = "";
  List<String> _imageGallery = [];
  TabController? tabController;
  List<EventParticipantModel> _participants = [];

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    SharedPrefHelper.getUserId().then((value) {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      id = arguments['id'];
      _loggedUser = value;
    }).then((_) => Provider.of<EventProvider>(context, listen: false)
        .getEventDetails(id)
        .then((value) async {
          _participants = await EventService().getEventParticipants(id);
          return _participants;
        })
        .then((value) => _canJoinEvent =
            !value.any((element) => element.userId == _loggedUser))
        .then((_) async => _imageGallery = (await ImageService()
                .getImageLinks(refId: id, type: ImageType.event))
            .map((e) => e.url)
            .toList())
        .then((_) => setState(() {
              _isLoading = false;
            })));
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Consumer<EventProvider>(builder: (context, value, child) {
              var eventDetails = value.eventDetails;
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    snap: false,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        child: CustomNetworkImage(
                          url: eventDetails.backgroundImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    iconTheme: const IconThemeData(color: Colors.black),
                    actions: [
                      IconButton(
                          onPressed: () {
                            showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(100, 50, 0, 0),
                                items: [
                                  PopupMenuItem(
                                    onTap: () {
                                      final TextEditingController
                                          reportContentController =
                                          TextEditingController();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Báo cáo"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                      "Bạn có chắc chắn muốn báo cáo bài viết này?"),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  //text field for report content
                                                  KFormField(
                                                    hintText:
                                                        "Nội dung báo cáo",
                                                    maxLines: 3,
                                                    controller:
                                                        reportContentController,
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Hủy"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    if (reportContentController
                                                        .text.isEmpty) {
                                                      ErrorHelper.showError(
                                                          message:
                                                              "Vui lòng nhập nội dung báo cáo");
                                                      return;
                                                    }
                                                    var loggedUser =
                                                        await SharedPrefHelper
                                                            .getUserId();
                                                    var res = await EventService()
                                                        .reportEvent(
                                                            reporterId:
                                                                loggedUser,
                                                            eventId:
                                                                eventDetails
                                                                    .eventId,
                                                            content:
                                                                reportContentController
                                                                    .text);
                                                    if (res) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text("Báo cáo"),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Text("Báo cáo"),
                                  ),
                                ]);
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                eventDetails.title,
                                textAlign: TextAlign.center,
                                style: headingStyle,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _canJoinEvent
                                      ? TextButton(
                                          onPressed: () async {
                                            var res = await EventService()
                                                .joinEvent(
                                                    eventDetails.eventId);
                                            if (res) {
                                              Provider.of<EventProvider>(
                                                      context,
                                                      listen: false)
                                                  .getEventDetails(id);
                                              setState(() {
                                                _canJoinEvent = false;
                                              });
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateColor.resolveWith(
                                                    (states) => kPrimaryColor),
                                            padding: WidgetStateProperty
                                                .resolveWith((states) =>
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32.0)),
                                          ),
                                          child: const Text(
                                            'Tham gia',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                var res = await EventService()
                                                    .leaveEvent(
                                                        eventDetails.eventId);
                                                if (res) {
                                                  Provider.of<EventProvider>(
                                                          context,
                                                          listen: false)
                                                      .getEventDetails(id);
                                                  setState(() {
                                                    _canJoinEvent = true;
                                                  });
                                                }
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateColor
                                                        .resolveWith((states) =>
                                                            kErrorColor),
                                                padding: WidgetStateProperty
                                                    .resolveWith((states) =>
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 32.0)),
                                              ),
                                              child: const Text(
                                                'Hủy tham gia',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, DiscussingScreen.routeName,
                                          arguments: {
                                            'id': eventDetails.eventId,
                                            'eventName': eventDetails.title,
                                            'image':
                                                eventDetails.backgroundImage
                                          });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateColor.resolveWith(
                                              (states) => kPrimaryLightColor),
                                      padding: WidgetStateProperty.resolveWith(
                                          (states) =>
                                              const EdgeInsets.symmetric(
                                                  horizontal: 24.0)),
                                    ),
                                    child: const Text(
                                      'Thảo luận',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     // Handle attend action
                                  //   },
                                  //   style: ButtonStyle(
                                  //     backgroundColor:
                                  //         MaterialStateColor.resolveWith(
                                  //             (states) => kPrimaryLightColor),
                                  //   ),
                                  //   child: const Icon(
                                  //     Icons.more_horiz,
                                  //     color: kPrimaryColor,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(
                                  Icons.access_time_filled,
                                  color: kSecondaryColor,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  DateTimeHelper.formatDateTime2(
                                          eventDetails.timeOfEvent) +
                                      " - ${DateTimeHelper.formatDateTime2(eventDetails.endOfEvent) ?? ""}",
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.person,
                                  color: kSecondaryColor,
                                ),
                                title: Text.rich(
                                  TextSpan(text: 'Sự kiện của ', children: [
                                    TextSpan(
                                        text: eventDetails.organizationName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.location_on_rounded,
                                  color: kSecondaryColor,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  eventDetails.location ?? "",
                                ),
                                subtitle: Text(
                                  eventDetails.address ?? "",
                                  style: const TextStyle(
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.check_box,
                                  color: kSecondaryColor,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  '${eventDetails.participantsCount} Người sẽ tham gia',
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 600,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Danh sách tham gia',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              ListView.builder(
                                                itemCount: _participants.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    leading: _participants[
                                                                    index]
                                                                .profileAvatar !=
                                                            null
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    _participants[
                                                                            index]
                                                                        .profileAvatar!),
                                                          )
                                                        : null,
                                                    title: Text(
                                                      _participants[index]
                                                              .userName ??
                                                          "Người dùng không xác định",
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const Divider(),
                              const Text(
                                'Chi tiết sự kiện',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                eventDetails.description ?? "",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const Divider(),
                              const Text(
                                'Hình ảnh',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: _imageGallery
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomNetworkImage(
                                            url: e,
                                            fit: BoxFit.cover,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
    );
  }
}
