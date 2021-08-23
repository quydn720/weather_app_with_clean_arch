abstract class LocationInfo {
  Future<Location> get location;
}

class Location {
  final double lon;
  final double lat;

  Location({required this.lon, required this.lat});
}
