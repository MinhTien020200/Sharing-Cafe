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
      refId: json['ref_id'] as String,
      type: DiscussingType.values[json['type'] as int],
      title: json['title'] as String,
      content: json['content'] as String,
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
