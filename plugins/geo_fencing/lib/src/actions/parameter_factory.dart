import 'package:geo_fencing/geo_fencing_method_channel.dart';

import '../model/init/configuration_converter.dart';
import '../model/location/location_converter.dart';

class ParameterFactory {
  Map<String, dynamic> createParameter(String method, {dynamic argument}) {
    switch (method) {
      case MethodChannelGeoFencing.initMethod:
        return ConfigurationConverter(dbPath: argument).toMap();
      case MethodChannelGeoFencing.insertMethod:
        return LocationConverter.fromModel(location: argument).toMap();
      default:
        return {};
    }
  }
}
