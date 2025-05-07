import 'package:geo_fencing/geo_fencing.dart';
import 'package:geo_fencing/src/database/app_database.dart';
import 'package:geo_fencing/src/database/tracker_dao.dart';

class GeoRepository {
  static GeoRepository? _instance;

  late AppDatabase _appDatabase;
  LocationDao? _locationDao;
  TrackerDao? _trackerDao;

  factory GeoRepository() {
    _instance ??= GeoRepository._internal();
    return _instance!;
  }

  GeoRepository._internal() {
    _appDatabase = AppDatabase();
  }

  LocationDao get locationDao {
    _locationDao ??= LocationDao(appDatabase: _appDatabase);
    return _locationDao!;
  }

  TrackerDao get trackerDao {
    _trackerDao ??= TrackerDao(appDatabase: _appDatabase);
    return _trackerDao!;
  }
}
