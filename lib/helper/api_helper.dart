import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String baseUrl =
      "https://sharing-coffee-be-capstone-com.onrender.com/api/";

  ApiHelper();

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(Uri.parse(baseUrl + endpoint));
    return response;
  }
}
