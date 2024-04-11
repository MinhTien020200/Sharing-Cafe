import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sharing_cafe/helper/api_helper.dart';
import 'package:sharing_cafe/helper/error_helper.dart';
import 'package:sharing_cafe/helper/location_helper.dart';
import 'package:sharing_cafe/helper/shared_prefs_helper.dart';

class LocationService {
  Future updateLocation() async {
    // update current location to backend
    var userId = await SharedPrefHelper.getUserId();
    if (userId.isNotEmpty) {
      var currentLocation = await LocationHelper.getCurrentLocation();
      var endpoint =
          "/location/updateCurrentLocation?userId=$userId&e&lat=${currentLocation.latitude}&lng=${currentLocation.longitude}";
      var response = await ApiHelper().put(endpoint, {});
      if (response.statusCode == HttpStatus.ok) {
        if (kDebugMode) {
          print("Update location success");
        }
        return true;
      } else {
        ErrorHelper.showError(message: "Không thể cập nhật vị trí hiện tại");
        return false;
      }
    }
  }
}
