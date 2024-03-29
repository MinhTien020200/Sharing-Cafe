import 'package:sharing_cafe/helper/datetime_helper.dart';

class BlogModel {
  final String blogId;
  final String userId;
  final String content;
  final int likesCount;
  final int commentsCount;
  final bool isApprove;
  final DateTime createdAt;
  final String image;
  final String title;
  final String ownerName;
  final String category;

  BlogModel({
    required this.blogId,
    required this.userId,
    required this.content,
    required this.likesCount,
    required this.commentsCount,
    required this.isApprove,
    required this.createdAt,
    required this.image,
    required this.title,
    required this.ownerName,
    required this.category,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      blogId: json["blog_id"],
      userId: json["user_id"],
      content: json["content"],
      likesCount: json["likes_count"],
      commentsCount: json["comments_count"],
      isApprove: json["is_approve"],
      createdAt: DateTimeHelper.parseToLocal(json["created_at"]),
      image: json["image"],
      title: json["title"],
      ownerName: json['user_name'],
      category: json['name'],
    );
  }
}
