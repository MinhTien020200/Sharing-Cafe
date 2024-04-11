// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';
import 'package:sharing_cafe/model/blog_model.dart';
import 'package:sharing_cafe/model/comment_model.dart';

class BlogService {
  Future<List<BlogModel>> getBlogs() async {
    try {
      var response = await ApiHelper().get('/blog');
      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body) as List;
        return jsonList.map<BlogModel>((e) => BlogModel.fromJson(e)).toList();
      } else {
        ErrorHelper.showError(
            message:
                "Lỗi ${response.statusCode}: Không thể lấy danh sách blog");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return [];
  }

  Future<BlogModel?> getBlogDetails(String blogId) async {
    try {
      var response = await ApiHelper().get('/blog/$blogId');
      if (response.statusCode == HttpStatus.ok) {
        return BlogModel.fromJson(json.decode(response.body)[0]);
      } else {
        ErrorHelper.showError(
            message: "Lỗi ${response.statusCode}: Không thể lấy blog");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return null;
  }

  Future<List<CommentModel>> loadComment(String blogId) async {
    try {
      var response = await ApiHelper().get('/blog/comment/$blogId');
      if (response.statusCode == HttpStatus.ok) {
        var jsonList = json.decode(response.body) as List;
        return jsonList
            .map<CommentModel>((e) => CommentModel.fromJson(e))
            .toList();
      } else {
        ErrorHelper.showError(
            message:
                "Lỗi ${response.statusCode}: Không thể lấy danh sách bình luận");
      }
    } on Exception catch (_, e) {
      print(e);
    }
    return [];
  }

  Future createComment({
    required String blogId,
    required String content,
  }) async {
    var userId = await SharedPrefHelper.getUserId();
    var data = {"userId": userId, "blogId": blogId, "content": content};
    var response = await ApiHelper().post('/blog/comment', data);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      ErrorHelper.showError(
          message: "Lỗi ${response.statusCode}: Không thể tạo bình luận");
    }
  }
}
