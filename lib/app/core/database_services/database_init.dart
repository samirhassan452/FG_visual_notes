import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show VisualNoteFields, Log, visualNotesTableName;

class DatabaseInit {
  // initiate Singleton for class instance
  static final DatabaseInit _instance = DatabaseInit._init();
  DatabaseInit._init();
  factory DatabaseInit() => _instance;

  // create instance from Database from sqfile package, but it's private
  Database? _database;

  // get the instance after initialized
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      "initialize DB for the first time".log();
      _database = await _dbInit("visual_notes.db");
      "DB initialized".log();
      return _database!;
    }
  }

  Future<Database> _dbInit(String dbName) async {
    // get db path to save db in this path
    final dbPath = await getDatabasesPath();
    "dbPath: $dbPath".log();
    // try to join both path & db name
    final path = join(dbPath, dbName);
    "path: $path".log();
    "try to open DB".log();
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB,
      onOpen: _onOpenDB,
    );
  }

  // only executed in case of db not found "at the first time"
  void _onCreateDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const pictureType = "BLOB NOT NULL";
    // const boolType = "BOOLEAN NOT NULL";
    // const integerType = "INTEGER NOT NULL";
    "creating table".log();
    await db.execute(
      '''
        CREATE TABLE $visualNotesTableName (
          ${VisualNoteFields.id} $idType,
          ${VisualNoteFields.title} $textType,
          ${VisualNoteFields.picture} $pictureType,
          ${VisualNoteFields.description} $textType,
          ${VisualNoteFields.createdTime} $textType,
          ${VisualNoteFields.status} $textType
        )
      ''',
    );
    "table created".log();
    // you can create another table in the same way as before
    "DB created".log();
  }

  // called when open db
  void _onOpenDB(Database db) => "DB opened".log();

  void closeDB() async {
    // get instance from db
    "get instance from DB".log();
    final db = await _instance.database;
    if (db.isOpen) {
      "DB already open".log();
      // close db
      "closing DB".log();
      await db.close();
      "DB closed".log();
    } else {
      "DB already closed".log();
    }
  }
}
