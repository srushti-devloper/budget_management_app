import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "budget_expense");
    var database = openDatabase(path, version: 1, onCreate: createDatabase);
    return database;
  }

  Future<void> createDatabase(Database database, int version) async {
    await database.execute(
        "create table mybudget (id INTEGER PRIMARY KEY autoincrement, month TEXT, title TEXT, amount integer,created_at TEXT)");

    await database.execute(
        "create table my_expance (id INTEGER PRIMARY KEY autoincrement, month TEXT, title TEXT, amount integer,created_at text)");

    await database.execute(
        "create table my_savings (id INTEGER PRIMARY KEY autoincrement, month TEXT, title TEXT, amount integer,created_at text)");
  }
}
