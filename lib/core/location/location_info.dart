import 'package:geolocator/geolocator.dart';
import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';

abstract class LocationInfo {
  Future<Location> get location;
}

class LocationInfoImpl implements LocationInfo {
  @override
  Future<Location> get location async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are not enabled don't continue
    //   // accessing the position and request users of the
    //   // App to enable the location services.
    //   throw LocationPermissionException();
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // Permissions are denied, next time you could try
    //     // requesting permissions again (this is also where
    //     // Android's shouldShowRequestPermissionRationale
    //     // returned true. According to Android guidelines
    //     // your App should show an explanatory UI now.
    //     throw LocationPermissionException();
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   throw LocationPermissionException();
    // }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    return position.parseLocation();
  }
}

class Location {
  final double lon;
  final double lat;

  Location({required this.lon, required this.lat});
}

extension LocationParsing on Position {
  Location parseLocation() {
    return Location(
      lon: this.longitude,
      lat: this.latitude,
    );
  }
}
