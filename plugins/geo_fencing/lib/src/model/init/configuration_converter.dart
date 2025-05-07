import 'package:geo_fencing/src/configs.dart';

import '../serializable.dart';

class ConfigurationConverter implements Serializable {
  final String dbPath;

  const ConfigurationConverter({required this.dbPath});

  @override
  Map<String, dynamic> toMap() => {
    "database-path-key": dbPath,
    "database-version-key": 1,
    "database-tracker-table": Configs.trackerTable,
    "database-location-table": Configs.locationTable,
  };
}
