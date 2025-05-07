import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geo_fencing_method_channel.dart';
import 'src/model/location/location.dart';

abstract class GeoFencingPlatform extends PlatformInterface {
  /// Constructs a GeoFencingPlatform.

  static const String _notImplemented = 'Not Implemented for this platform';

  GeoFencingPlatform() : super(token: _token);

  static final Object _token = Object();

  static GeoFencingPlatform _instance = MethodChannelGeoFencing();

  /// The default instance of [GeoFencingPlatform] to use.
  ///
  /// Defaults to [MethodChannelGeoFencing].
  static GeoFencingPlatform get instance => _instance;

  static set instance(GeoFencingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() {
    throw UnimplementedError(_notImplemented);
  }

  Future<void> insert(Location location) {
    throw UnimplementedError(_notImplemented);
  }
}
