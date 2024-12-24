class UserLocation {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final LocationStreet street;

  UserLocation({
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.street
  });
}

class LocationStreet {
  final int number;
  final String name;

  LocationStreet({
    required this.number, 
    required this.name});
}
