import 'package:sharing_cafe/enums.dart';

class ImageModel {
  final String imageId;
  final String url;
  final String refId;
  final ImageType type;

  ImageModel({
    required this.imageId,
    required this.url,
    required this.refId,
    required this.type,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageId: json["image_id"],
      url: json["url"],
      refId: json["ref_id"],
      type: ImageType.fromInt(json["type"]),
    );
  }
}
