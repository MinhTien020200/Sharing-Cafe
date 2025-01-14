import 'package:sharing_cafe/enums.dart';

class DiscussingModel {
  String refId;
  DiscussingType type;
  String title;
  String content;
  String? userName;
  String? profileAvatar;

  DiscussingModel({
    required this.refId,
    required this.type,
    required this.title,
    required this.content,
    this.userName,
    this.profileAvatar,
  });

  factory DiscussingModel.fromJson(Map<String, dynamic> json) {
    return DiscussingModel(
      refId: json['ref_id'] as String,
      type: DiscussingType.values[json['type'] as int],
      title: json['title'] as String,
      content: json['content'] as String,
      userName: json['user_name'] as String?,
      profileAvatar: json['profile_avatar'] as String?,
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
