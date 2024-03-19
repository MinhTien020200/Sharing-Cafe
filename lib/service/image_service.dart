import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sharing_cafe/helper/api_helper.dart';

class ImageService {
  Future<String> uploadImage(File imageFile) async {
    var endpoint = "/image";
    String fileName = DateTime.now().toString();
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });
    var response = await ApiHelper().postFormData(endpoint, formData);
    if (response.statusCode == 200) {
      print(response);
    }
    return "";
  }
}
