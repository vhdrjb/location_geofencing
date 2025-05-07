import 'dart:async';

import 'package:geo_fencing/src/configs.dart';
import 'package:sqflite/sqflite.dart';

import 'location_dao.dart';
import 'tracker_dao.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static const _databaseName = 'geo_fencing.db';
  Database? _database;

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  Future<void> initDataBase() async {
    _database ??= await _initDatabase();
  }

  Future<Database> get database async {
    assert(_database != null, 'Flutter Error: database is not initialized');
    return _database!;
  }

  Future<String> get locationDatabase async {
    if (_database == null) {
      await _initDatabase();
    }
    return getDatabasesPath();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(_databaseName, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) {
    return Future.wait([_createLocationTable(db), _createTrackerTable(db)]);
  }

  Future<void> _createTrackerTable(Database db) {
    return db.execute('''
      CREATE TABLE ${Configs.trackerTable} (
        ${TrackerDao.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TrackerDao.columnLocationId} INTEGER NOT NULL,
        ${TrackerDao.columnFrom} timestamp DEFAULT CURRENT_TIMESTAMP,
        ${TrackerDao.columnTo} timestamp DEFAULT NULL
      )
    ''');
  }

  Future<void> _createLocationTable(Database db) {
    return db.execute('''
      CREATE TABLE ${Configs.locationTable} (
        ${LocationDao.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${LocationDao.columnName}  TEXT NOT NULL,
        ${LocationDao.columnLatitude} NUMERIC DEFAULT 0.0,
        ${LocationDao.columnLongitude} NUMERIC DEFAULT 0.0
      )
    ''');
  }
}
