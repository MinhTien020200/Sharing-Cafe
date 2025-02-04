import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/location_helper.dart';

class WeatherHelper {
  // Replace with your actual API key
  String apiKey =
      'qs3f4traf7wcisg8roeyn1bfuibmfv4lhgo2gj5c'; // Copy from github https://gist.github.com/lalithabacies/c8f973dc6754384d6cade282b64a8cb1

  Future<dynamic> getWeather() async {
    try {
      Position position = await LocationHelper.getCurrentLocation();
      final response = await http.get(
        Uri.parse(
            'https://www.meteosource.com/api/v1/free/point?lat=${position.latitude}&lon=${position.longitude}&sections=current&language=en&units=auto&key=$apiKey'),
      );
      if (response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        return weatherData;
      }
    } catch (e) {
      // ErrorHelper.showError(message: "Không thể lấy thông tin thời tiết");
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  // change K to C
  double kelvinToCelsius(double kelvin) {
    // round to 2 decimal places
    return double.parse((kelvin - 273.15).toStringAsFixed(2));
  }
}
