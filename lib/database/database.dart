import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'profile.dart';

class DatabaseHelper {
  static const profileTable = "profiletable";

  static const dbVersion = 2;

  static const idProfileColumn = "id";
  static const nameColumn = "name";
  static const image64bitColumn = "image64bit";

  static const timestampColumn = "timestamp";

  static Future _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $profileTable(
      $idProfileColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $nameColumn TEXT,
      $image64bitColumn TEXT,
      $timestampColumn TEXT
    )    
    """);
  }

  static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE $profileTable ADD COLUMN $timestampColumn TEXT",
      );
    }
  }

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, "flutter_onnxruntimeDb.db");
    return openDatabase(
      dbPath,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: dbVersion,
    );
  }

  static Future insertProfile(Map<String, dynamic> row) async {
    final db = await DatabaseHelper.open();
    return await db.insert(profileTable, row);
  }

  static Future<List<ProfileModel>> getAllProfile() async {
    final db = await DatabaseHelper.open();
    List<Map<String, dynamic>> mapList = await db.query(profileTable);
    return List.generate(
      mapList.length,
      (index) => ProfileModel.fromMap(mapList[index]),
    );
  }

  static Future<int> deleteItem(int id) async {
    final db = await DatabaseHelper.open();
    return await db.delete(
      profileTable,
      where: '$idProfileColumn = ?',
      whereArgs: [id],
    );
  }
}
