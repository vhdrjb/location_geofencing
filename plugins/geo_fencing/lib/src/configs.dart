class Configs {
  static Configs? _instance;

  static Configs getInstance() {
    _instance ??= Configs._internal();
    return _instance!;
  }

  Configs._internal();

  static String get locationTable => "locations";

  static String get trackerTable => "trackers";
}
