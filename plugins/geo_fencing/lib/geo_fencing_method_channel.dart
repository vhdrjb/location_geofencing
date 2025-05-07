import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'geo_fencing_platform_interface.dart';
import 'src/actions/parameter_factory.dart';
import 'src/database/app_database.dart';
import 'src/model/location/location.dart';

/// An implementation of [GeoFencingPlatform] that uses method channels.
class MethodChannelGeoFencing extends GeoFencingPlatform {
  static const String _channelName = 'ir.vhdrjb/geo_fencing';

  static const String initMethod = 'init_geo_fencing';
  static const String insertMethod = 'insert_location';

  final ParameterFactory _parameterFactory = ParameterFactory();

  @visibleForTesting
  final methodChannel = const MethodChannel(_channelName);

  @override
  Future<void> init() async {
    String dbPath = await AppDatabase().locationDatabase;
    return methodChannel.invokeMethod(
      initMethod,
      _parameterFactory.createParameter(initMethod, argument: dbPath),
    );
  }

  @override
  Future<void> insert(Location location) {
    return methodChannel.invokeMethod(
      insertMethod,
      _parameterFactory.createParameter(insertMethod, argument: location),
    );
  }
}
