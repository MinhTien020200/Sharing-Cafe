import 'package:flutter/material.dart';
import 'package:sharing_cafe/model/blog_model.dart';
import 'package:sharing_cafe/service/blog_service.dart';

class BlogProvider extends ChangeNotifier {
  // private
  List<BlogModel> _blogs = [];

  // public
  List<BlogModel> get blogs => _blogs;

  Future getBlogs() async {
    _blogs = await BlogServce().getBlogs();
    notifyListeners();
  }
}
