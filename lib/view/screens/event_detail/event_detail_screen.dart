import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';

class EventDetailScreen extends StatelessWidget {
  static String routeName = "/event-detail";
  const EventDetailScreen({super.key});

  final String eventTitle =
      'Hội thảo nghệ thuật "Sell Yourself" - Hành trình Khởi lửa hành trang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                child: Image.network(
                  'https://picsum.photos/400', // Replace with actual image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
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
                        eventTitle,
                        textAlign: TextAlign.center,
                        style: headingStyle,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle attend action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kPrimaryColor),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => const EdgeInsets.symmetric(
                                      horizontal: 32.0)),
                            ),
                            child: const Text(
                              'Tham gia',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle attend action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kPrimaryLightColor),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => const EdgeInsets.symmetric(
                                      horizontal: 24.0)),
                            ),
                            child: const Text(
                              'Kết nối nhóm',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle attend action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kPrimaryLightColor),
                            ),
                            child: const Icon(
                              Icons.more_horiz,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(
                          Icons.access_time_filled,
                          color: kSecondaryColor,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '15 tháng 5 lúc 9:00 - 28 tháng 5 lúc 17:00',
                        ),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.person,
                          color: kSecondaryColor,
                        ),
                        title: Text.rich(
                          TextSpan(text: 'Sự kiện của ', children: [
                            TextSpan(
                                text: 'CLB Nghệ thuật',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.location_on_rounded,
                          color: kSecondaryColor,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Trung Tâm Văn Hóa Quận Gò Vấp',
                        ),
                        subtitle: Text(
                          "Quận Gò Vấp, TP.Hồ Chí Minh",
                          style: TextStyle(
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.check_box,
                          color: kSecondaryColor,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '23 Người sẽ tham gia',
                        ),
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
                      const Text(
                        'Nếu như thế hệ 8x biết Tiếng Anh được xem là nhân tài, thì Gen Z chỉ xem Tiếng Anh là phương tiện với nhiều chứng chỉ Ielts, Toeic “khủng”. Nếu như thế hệ 8x biết Word, Excel được xem là lợi thế cạnh tranh, thì Gen Z chỉ xem Word, Excel, PPT,... là công cụ.  Trong thời đại của sự cạnh tranh gay gắt và môi trường tuyển dụng không ngừng biến đổi, việc xây dựng và phát triển bản thân không chỉ còn là kỹ năng mà trở thành một nghệ thuật. Hãy tưởng tượng, trong thị trường lao động với hàng triệu ứng viên, làm thế nào để bạn có thể tỏa sáng, thu hút và nổi bật? Bạn có biết rằng khả năng tự quảng bá và “bán thân” không chỉ đòi hỏi sự tự tin, mà còn là việc hiểu rõ giá trị và thế mạnh cá nhân của mình? Nếu bạn đang có những mối quan tâm này và cảm thấy việc xây dựng thương hiệu cá nhân và giao tiếp hiệu quả là thách thức thì Hội thảo: Nghệ thuật “Sell Yourself” do Học viện Kỹ năng VTALK tổ chức, thuộc dự án Hành trình Khởi lửa Hành trang hứa hẹn sẽ là nơi để mọi người cùng nhau chia sẻ và học hỏi những chiến lược, kỹ năng và bí quyết để tự tin “bán thân” một cách sáng tạo và “được giá” nhất!',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      // Add more widgets for other details if needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
