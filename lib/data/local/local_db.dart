import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_project/data/models/cached_weather_info/cached_weather_item.dart';

class LocalDatabase {
  LocalDatabase._init();
  static final LocalDatabase localDatabase = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return localDatabase;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("weathers.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const String textType = "TEXT NOT NULL";
    const String intType = "INTEGER DEFAULT 0";

    await db.execute("""
    CREATE TABLE $weatherTable (
      ${CachedWeatherItemFields.id} $idType,
      ${CachedWeatherItemFields.addressName} $textType,
      ${CachedWeatherItemFields.weatherType} $textType,
      ${CachedWeatherItemFields.temperature} $intType
    ) 
    """);
  }
  //***************************************Cached Weather Table************************************************ */

  static Future<CachedWeatherItem> insertCachedWeather(
      CachedWeatherItem cachedWeatherItem) async {
    final db = await localDatabase.database;
    final id = await db.insert(weatherTable, cachedWeatherItem.toJson());
    return cachedWeatherItem.copyWith(id: id);
  }

  static Future<List<CachedWeatherItem>> getAllWeathers() async {
    final db = await localDatabase.database;
    const orderBy = "${CachedWeatherItemFields.id} DESC";
    final result = await db.query(weatherTable, orderBy: orderBy);
    return result
        .map((weather) => CachedWeatherItem.fromJson(weather))
        .toList();
  }
}
