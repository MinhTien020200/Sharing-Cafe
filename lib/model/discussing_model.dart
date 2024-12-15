import 'package:sharing_cafe/enums.dart';

class DiscussingModel {
  String refId;
  DiscussingType type;
  String title;
  String content;

  DiscussingModel({
    required this.refId,
    required this.type,
    required this.title,
    required this.content,
  });

  factory DiscussingModel.fromJson(Map<String, dynamic> json) {
    return DiscussingModel(
      refId: json['refId'] as String,
      type: DiscussingType.values[json['type'] as int],
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refId': refId,
      'type': type.value,
      'title': title,
      'content': content,
    };
  }
}
