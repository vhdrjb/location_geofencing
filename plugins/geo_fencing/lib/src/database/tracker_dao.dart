import 'package:geo_fencing/src/configs.dart';

import 'dao.dart';

class TrackerDao extends Dao {
  static const String columnId = "id";
  static const String columnLocationId = "location_id";
  static const String columnFrom = "start";
  static const String columnTo = "end";

  TrackerDao({required super.appDatabase});

  @override
  String get table => Configs.trackerTable;
}
