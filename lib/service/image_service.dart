import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:sharing_cafe/enums.dart';
import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/model/image_model.dart';

class ImageService {
  Future<String> uploadImage(File imageFile) async {
    var endpoint = "/image";
    String fileName = DateTime.now().toString();
    FormData formData = FormData.fromMap({
      'background_img':
          await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });
    var response = await ApiHelper().postFormData(endpoint, formData);
    if (response.statusCode == 200) {
      return response.data["background_img"];
    }
    return "";
  }

  Future<bool> updateImageLinks(
      List<ImageFile> images, String refId, ImageType type) async {
    var endpoint = "/auth/image";
    List<String> imageLinks = [];
    for (var image in images) {
      if (!image.path!.contains("http")) {
        imageLinks.add(await uploadImage(File(image.path!)));
      }
    }
    var data = {
      "items": imageLinks
          .map((e) => {"ref_id": refId, "type": type.value, "url": e})
          .toList(),
    };
    var response = await ApiHelper().post(endpoint, data);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<ImageModel>> getImageLinks(
      {required String refId,
      required ImageType type,
      int limit = 10,
      int offset = 1}) async {
    var endpoint = "/auth/image";
    var query = {
      "ref_id": refId,
      "type": type.value,
      "limit": limit,
      "offset": offset
    };
    var response =
        await ApiHelper().get(ApiHelper().appendUrlParams(endpoint, query));
    if (response.statusCode == 200) {
      List<ImageModel> images = [];
      var result = jsonDecode(response.body);
      for (var item in result) {
        images.add(ImageModel.fromJson(item));
      }
      return images;
    }
    return [];
  }
}
