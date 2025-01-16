import 'package:sharing_cafe/enums.dart';

class DiscussingModel {
  String? id;
  String refId;
  DiscussingType type;
  String title;
  String content;
  String? userName;
  String? profileAvatar;
  int likeCount;
  bool isLiked;

  DiscussingModel({
    this.id,
    required this.refId,
    required this.type,
    required this.title,
    required this.content,
    this.userName,
    this.profileAvatar,
    this.likeCount = 0,
    this.isLiked = false,
  });

  factory DiscussingModel.fromJson(Map<String, dynamic> json) {
    return DiscussingModel(
      id: json['id'] as String,
      refId: json['ref_id'] as String,
      type: DiscussingType.values[json['type'] as int],
      title: json['title'] as String,
      content: json['content'] as String,
      userName: json['user_name'] as String?,
      profileAvatar: json['profile_avatar'] as String?,
      likeCount: json['like_count'] as int,
      isLiked: json['is_like'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ref_id': refId,
      'type': type.value,
      'title': title,
      'content': content,
    };
  }
}
