
import '../deserialize.dart';
import '../serializable.dart';
import 'location.dart';

class LocationConverter implements Serializable, Deserialize<Location> {
  final Location? _location;
  static const String _name = 'name';
  static const String _latitude = 'latitude';
  static const String _longitude = 'longitude';

  LocationConverter._internal({Location? location}) : _location = location;

  factory LocationConverter.fromModel({required Location location}) =>
      LocationConverter._internal(location: location);

  factory LocationConverter.raw() =>
      LocationConverter._internal(location: null);

  @override
  Map<String, dynamic> toMap() => {
    _name: _location?.name,
    _latitude: _location?.latitude,
    _longitude: _location?.longitude,
  };

  @override
  Location toModel(Map<String, dynamic> data) {
    return Location(
      name: data[_name],
      latitude: data[_latitude],
      longitude: data[_longitude],
    );
  }
}
