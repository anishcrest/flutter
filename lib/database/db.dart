import 'package:common_components/utils/constant_utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    // Get a location using getDatabasesPath
    var path = await getDatabasesPath();
    var databasePath = join(path, ConstantUtil.DB_NAME);
    return await openDatabase(
      databasePath,
      version: ConstantUtil.DB_VERSION,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE '
      '${ConstantUtil.TABLE_NAME}'
      '('
      '${ConstantUtil.todo_column_id} INTEGER PRIMARY KEY autoincrement,'
      '${ConstantUtil.todo_column_title} TEXT not null,'
      '${ConstantUtil.todo_column_subtitle} TEXT not null,'
      '${ConstantUtil.todo_column_done} INTEGER not null,'
      '${ConstantUtil.todo_column_created_at} INTEGER not null,'
      '${ConstantUtil.todo_column_modified_at} INTEGER not null,'
      '${ConstantUtil.todo_column_isDeleted} INTEGER not null'
      ' )',
    );
  }

  /// Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryWhereRows(
      String table, String columnName, dynamic id) async {
    Database db = await instance.database;
    //return await db.query('SELECT * FROM $table',where: '$columnName =?',whereArgs: [id]);
    return await db.rawQuery('SELECT * FROM $table where $columnName = $id');
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'))!;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table, String columnName, dynamic id,
      Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db
        .update(table, row, where: '$columnName = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, String columnName, dynamic id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnName = ?', whereArgs: [id]);
  }
}
