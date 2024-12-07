import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ImageHelper {
  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static String getExtension(String path) {
    return path.split('.').last;
  }

  static bool isImageUrl(String url) {
    // Regex to match common image file extensions
    final imageFileExtensions =
        RegExp(r'\.(jpg|jpeg|png|gif|bmp|webp|svg)$', caseSensitive: false);

    // Check if the string is a valid URL
    Uri? uri = Uri.tryParse(url);
    if (uri == null || !(uri.hasScheme && uri.hasAuthority)) {
      return false;
    }

    // Check if the URL ends with a valid image extension
    return imageFileExtensions.hasMatch(url);
  }

  static ImageFile convertToImageFile(XFile pickedFile) {
    return ImageFile(pickedFile.path,
        name: pickedFile.path, path: pickedFile.path, extension: "png");
  }
}
