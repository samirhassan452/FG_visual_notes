import 'package:visual_notes/app/core/core_exports.dart'
    show
        DatabaseInit,
        Log,
        VisualNoteFields,
        VisualNoteModel,
        visualNotesTableName;

class DatabaseServices {
  // initiate Singleton for class instance
  static final DatabaseServices _instance = DatabaseServices._init();
  DatabaseServices._init();
  factory DatabaseServices() => _instance;

  late DatabaseInit _dbInstance;

  void init() {
    "get instance from DatabaseInit class".log();
    _dbInstance = DatabaseInit();
  }

  Future<VisualNoteModel> createVisualNote(VisualNoteModel visualNote) async {
    // get instance from db
    "get instance from DB".log();
    final db = await _dbInstance.database;
    // get id which generated from db
    "inserting visual note inside DB".log();
    final id = await db.insert(visualNotesTableName, visualNote.toJson());
    "visual note successfully inserted and id: $id".log();
    // return copy of current visual note
    "return copy from created visual note".log();
    return visualNote.copy(id: id);

    /// another way with sql statement
    /* final json = visualNote.toJson();
    const columns = "${VisualNoteFields.title}, ${VisualNoteFields.picture}";
    final values =
        "${json[VisualNoteFields.title]} ${json[VisualNoteFields.picture]}";
    final id = await db.rawInsert("INSERT INTO $visualNotesTableName ($columns) VALUES ($values)"); */
  }

  Future<VisualNoteModel> readVisualNote(int id) async {
    // get instance from db
    "get instance from DB".log();
    final db = await _dbInstance.database;
    // get list of visual notes that check filter
    // but we need only one visual note
    // so, get the first item of the list
    "execute query to read one visual note with id: $id".log();
    final maps = await db.query(
      visualNotesTableName,
      // if you want to get specific columns
      // but here we add all columns to get all of them
      columns: VisualNoteFields.columns,
      // directly -> "${VisualNoteFields.id} = $id"
      // but not secure for sql injection attack
      // another way by using ? and whereArgs
      // each ? means one filter/arg "${VisualNoteFields.id} = ? ?"
      // list of whereArgs == number of ?
      where: "${VisualNoteFields.id} = ?",
      whereArgs: [id],
    );
    "query successfully executed".log();
    if (maps.isNotEmpty) {
      "return first visual note from retured list".log();
      return VisualNoteModel.fromJson(maps.first);
    } else {
      "visual note with id: $id not found".log();
      throw Exception("ID $id not found.");
    }
  }

  Future<List<VisualNoteModel>> readAllVisualNotes() async {
    // get instance from db
    "get instance from DB".log();
    final db = await _dbInstance.database;
    // if you want to get data ordered by specific column
    const orderBy = "${VisualNoteFields.createdTime} DESC"; // ascending
    "execute query to read all visual notes".log();
    final maps = await db.query(visualNotesTableName, orderBy: orderBy);
    "query successfully executed".log();
    // if you want to execute sql statement
    /* final result = await db
        .rawQuery("SELECT * FROM $visualNotesTableName ORDER BY $orderBy"); */
    "return ${maps.length} visual notes".log();
    return VisualNoteModel.getListOfVisualNotesFromListOfJson(maps);
  }

  Future<int> updateVisualNote(VisualNoteModel visualNote) async {
    // get instance from db
    "get instance from DB".log();
    final db = await _dbInstance.database;
    // return count which is number of changes made on rows (number of rows affected)
    "updating visual note with id: ${visualNote.id}".log();
    int count = await db.update(
      visualNotesTableName,
      visualNote.toJson(),
      where: "${VisualNoteFields.id} = ?",
      whereArgs: [visualNote.id],
    );
    "visual note with id: ${visualNote.id} successfully updated".log();
    "number of row affected: $count".log();
    return count;
  }

  Future<int> deleteVisualNote(int id) async {
    // get instance from db
    "get instance from DB".log();
    final db = await _dbInstance.database;
    // return count which is number of deleted rows
    "deleting visual note with id: $id".log();
    int count = await db.delete(
      visualNotesTableName,
      where: "${VisualNoteFields.id} = ?",
      whereArgs: [id],
    );
    "visual note with id: $id successfully deleted".log();
    "number of row affected: $count".log();
    return count;
  }
}
