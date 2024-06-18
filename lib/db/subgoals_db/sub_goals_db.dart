import 'dart:async';
import 'package:ppk/db/daily_task_db/daily_task_model.dart';
import 'package:ppk/db/subgoals_db/subGoal_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SubGoalsDB {

  static final _databaseName = "subgoals.db";
  static final _databaseVersion = 1;
  static final table = 'subgoals';
  static final columnId = '_id';
  static final name = 'name';
  static final done = 'isCompleted';
  static final date = 'mainGoal';


  static Future open() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'sub_goals.db'),
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $name TEXT,
        $done TEXT,
        $date TEXT
      )
      ''');
      },
      version: 1,
    );
  }

  static Database? _database;



  static Future<int> insert(SubGoalModel subgoal) async {
    await open();
    return await _database!.insert(table, subgoal.toMap());
  }

  static Future<List<SubGoalModel>> getTasksByMainGoal(String mainGoal) async {
    var allTasksQuery = await queryAllRows();
    var allTasks = allTasksQuery.map((e) => SubGoalModel.fromMap(e));
    return allTasks.where((element) => element.mainGoal == mainGoal).toList();
  }

  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    await open();
    return await _database!.query(table);
  }

  static Future<int> update(SubGoalModel subgoal) async {
    await open();
    return await _database!.update(table, subgoal.toMap(), where: '$columnId = ?', whereArgs: [subgoal.id]);
  }

  static Future<int> delete(int id) async {
    await open();
    return await _database!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
