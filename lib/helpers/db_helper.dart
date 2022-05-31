import 'package:ekank/models/article_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _databaseName = 'bookmarks.db';
  static const _bookmarkTable = 'bookmark_table';
  static const _databaseVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_bookmarkTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, author STRING, title TEXT, description STRING, url STRING, urlToImage STRING, publishedAt STRING, content STRING'
        ')');
  }

  Future<int> insertTask(Article task) async {
    Database? db = DBHelper._database;
    return await db!.insert(_bookmarkTable, {
      'author': task.author,
      'title': task.title,
      'description': task.description,
      'url': task.url,
      'urlToImage': task.urlToImage,
      'publishedAt': task.publishedAt,
      'content': task.content,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = DBHelper._database;
    return await db!.query(_bookmarkTable);
  }

  Future<int> delete(int id) async {
    Database? db = DBHelper._database;
    return await db!.delete(_bookmarkTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteByTitle(String title) async {
    Database? db = DBHelper._database;
    return await db!
        .delete(_bookmarkTable, where: 'title = ?', whereArgs: [title]);
  }

  Future<List<Map<String, dynamic>>> checkByTitle(String title) async {
    Database? db = DBHelper._database;
    return await db!
        .query(_bookmarkTable, where: 'title = ?', whereArgs: [title]);
  }

  Future<int> deleteAllTasks() async {
    Database? db = DBHelper._database;
    return await db!.delete(_bookmarkTable);
  }
}
