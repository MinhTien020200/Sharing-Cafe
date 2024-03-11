import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  final String baseUrl =
      "https://sharing-coffee-be-capstone-com.onrender.com/api";

  ApiHelper();

  Future<http.Response> get(String endpoint) async {
    var token = await getToken();
    Map<String, String> headers = {
      "Authorization": token,
    };
    final response =
        await http.get(Uri.parse(baseUrl + endpoint), headers: headers);
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    var token = await getToken();
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        "Authorization": token,
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    var token = await getToken();
    final response = await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        "Authorization": token,
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    var token = await getToken();
    final response = await http.delete(
      Uri.parse(baseUrl + endpoint),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        "Authorization": token,
      },
    );
    return response;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');
    return token ?? "";
  }
}
