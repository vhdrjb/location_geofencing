
import 'app_database.dart';

abstract class Dao {
  final AppDatabase appDatabase;

  const Dao({
    required this.appDatabase,
  });

  String get table;
}