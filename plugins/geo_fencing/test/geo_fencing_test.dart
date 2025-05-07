import 'package:flutter_test/flutter_test.dart';
import 'package:geo_fencing/geo_fencing.dart';
import 'package:geo_fencing/geo_fencing_platform_interface.dart';
import 'package:geo_fencing/geo_fencing_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGeoFencingPlatform
    with MockPlatformInterfaceMixin
    implements GeoFencingPlatform {


  @override
  Future<void> init() => Future.any([]);
}

void main() {
  final GeoFencingPlatform initialPlatform = GeoFencingPlatform.instance;

  test('$MethodChannelGeoFencing is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGeoFencing>());
  });

  test('getPlatformVersion', () async {
    GeoFencing geoFencingPlugin = GeoFencing();
    MockGeoFencingPlatform fakePlatform = MockGeoFencingPlatform();
    GeoFencingPlatform.instance = fakePlatform;
  });
}
