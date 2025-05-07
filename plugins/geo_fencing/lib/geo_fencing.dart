import 'package:geo_fencing/src/database/app_database.dart';
import 'package:geo_fencing/src/model/location/location.dart';

import 'geo_fencing_platform_interface.dart';
export 'src/resources.dart';

class GeoFencing {
  Future<void> init() {
    return Future.wait([
      AppDatabase().initDataBase(),
      GeoFencingPlatform.instance.init(),
    ]);
  }

  Future<void> insert(Location location) {
    return GeoFencingPlatform.instance.insert(location);
  }
}
