import 'package:geolocator/geolocator.dart';
// import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';

abstract class LocationInfo {
  Future<Location> get location;
}

class LocationInfoImpl implements LocationInfo {
  @override
  Future<Location> get location async {
    try {
      Position position = await this._determinePosition();
      return Location(lon: position.longitude, lat: position.latitude);
    } catch (e) {
      throw LocationServiceDisabledException();
    }
  }

  Future<Position> _determinePosition() {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
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
