import 'package:littlewords/beans/dto/word.dto.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static const String _dbName = 'littlewords.db';
  static const int _dbVersion = 3;

  static Database? _db;

  static initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + _dbName;
    final Database database = await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _db = database;
    var isOpen = _db?.isOpen;
    print("Db is open: $isOpen");
  }

  static const String tableName = "words";

  static const String createTable = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      uid INTEGER PRIMARY KEY NOT NULL,
      author TEXT not null,
      content TEXT not null,
      latitude REAL,
      longitude REAL 
    )
  ''';

  static const String dropTable = '''
    DROP TABLE IF EXISTS $tableName
  ''';


  static  _onCreate(Database db, int version) {
    db.execute(createTable);
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute(dropTable);

    _onCreate(db, newVersion);
  }

  /// Inserer une ligne dans la table
 static void insert(WordDTO word){
    final Map<String, dynamic> wordAsMap = word.toJson();
    _db!.insert(tableName, wordAsMap);
  }

  /// Récupérer toutes les lignes de la table
  static Future<List<WordDTO>> findAll() async {
    final List<Map<String, Object?>> resultSet = await _db!.query(tableName);
    if (resultSet == null || resultSet.isEmpty) {
      return [];
    }
    /// convertir chaque ligne du ResultSet en WordDTO
    final List<WordDTO> words = [];
    for (var rs in resultSet) {
      var wordDTO = WordDTO.fromJson(rs);
      words.add(wordDTO);
    }
    return words;
  }

  /// Supprimer une ligne de la table par son uid
  static Future<void> delete(String uid) async {
    await _db!.delete(tableName, where: 'uid = ?', whereArgs: [uid]);
  }


}