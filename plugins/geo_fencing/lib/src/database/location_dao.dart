import 'package:geo_fencing/src/configs.dart';
import 'package:sqflite/sqflite.dart';

import '../model/location/location.dart';
import '../model/location/location_converter.dart';
import 'dao.dart';

class LocationDao extends Dao {
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnLatitude = "latitude";
  static const String columnLongitude = "longitude";



  LocationDao({required super.appDatabase});

  Future<void> insert(Location location) {
    return appDatabase.database.then((db) {
      db.insert(table, LocationConverter.fromModel(location: location).toMap());
    });
  }

  Future<Iterable<Location>> getAll() async {
    Database database = await appDatabase.database;
    List<Map<String, dynamic>> result = await database.query(table);
    return result.map((e) {
      return LocationConverter.raw().toModel(e);
    });
  }

  @override
  String get table => Configs.locationTable;
}
