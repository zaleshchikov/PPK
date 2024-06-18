import 'dart:async';
import 'package:ppk/db/daily_task_db/daily_task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseDailyTask {

  static final _databaseName = "tasks.db";
  static final _databaseVersion = 1;
  static final table = 'daily_task';
  static final columnId = '_id';
  static final name = 'name';
  static final done = 'done';
  static final date = 'date';
  static final vladId = 'vladId';


  static Future open() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'today_tasks.db'),
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $name TEXT,
        $done TEXT,
        $date TEXT,
        $vladId TEXT
      )
      ''');
      },
      version: 1,
    );
  }

  static Database? _database;

  static Future<void> DropTableIfExistsThenReCreate() async {
    await open();

    //here we get the Database object by calling the openDatabase method
    //which receives the path and onCreate function and all the good stuff

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await _database!.execute("DROP TABLE IF EXISTS today_tasks");

    //and finally here we recreate our beloved "tableName" again which needs
    //some columns initialization

  }

  static Future<int> insert(DailyTask task) async {
    await open();
    return await _database!.insert(table, task.toMap());
  }

  static Future<List<DailyTask>> getTasksByDate(DateTime day) async {
    day = DateTime.utc(day.year, day.month, day.day);
    var allTasksQuery = await queryAllRows();
    var allTasks = allTasksQuery.map((e) => DailyTask.fromMap(e));
    return allTasks.where((element) => element.date.compareTo(day) == 0).toList();
  }

  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    await open();
    return await _database!.query(table);
  }

  static Future<int> update(DailyTask task) async {
    await open();
    return await _database!.update(table, task.toMap(), where: '$columnId = ?', whereArgs: [task.id]);
  }

  static Future<int> delete(int id) async {
    await open();
    return await _database!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
