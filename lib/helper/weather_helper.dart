import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:sharing_cafe/helper/error_helper.dart';

class WeatherHelper {
  // Replace with your actual API key
  String apiKey =
      'bd5e378503939ddaee76f12ad7a97608'; // Copy from github https://gist.github.com/lalithabacies/c8f973dc6754384d6cade282b64a8cb1

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle permission denial
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<dynamic> getWeather() async {
    try {
      Position position = await getCurrentLocation();
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey'),
      );
      if (response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        return weatherData;
      }
    } catch (e) {
      ErrorHelper.showError(message: "Không thể lấy thông tin thời tiết");
    }
    return null;
  }

  // change K to C
  double kelvinToCelsius(double kelvin) {
    // round to 2 decimal places
    return double.parse((kelvin - 273.15).toStringAsFixed(2));
  }
}
