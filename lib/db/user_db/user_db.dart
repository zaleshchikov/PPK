import 'dart:async';
import 'package:ppk/db/user_db/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseUser {
  static final _databaseName = "UserDatabase.db";
  static final _databaseVersion = 1;
  static final table = 'user';
  static final columnId = '_id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnToken = 'token';
  static final columnNickName = 'nickname';


  static Future open() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnEmail TEXT,
        $columnPassword TEXT,
        $columnToken TEXT,
        $columnNickName TEXT
      )
      ''');
      },
      version: 1,
    );
  }

  static Database? _database;

  static Future<String> getToken() async {
    await open();
    var users = await queryAllRows();
    var user = User.fromMap(users[0]);
    return user.token;
  }

  static Future<String> getNick() async {
    await open();
    var users = await queryAllRows();
    var user = User.fromMap(users[0]);
    return user.nickName;
  }

  static Future<int> saveToken(String token) async {
    await open();
    var users = await queryAllRows();
    var user = User.fromMap(users[0]);
    user.token = token;
    return await _database!.update(table, user.toMap(), where: '$columnId = ?', whereArgs: [1]);
  }

  static Future<bool> isRegister() async {
    final query = await queryAllRows();
    return query[0]['email'] != 'Неизвестная почта';
  }

  static Future<bool> isFirstTimeInApp() async {
    final query = await queryAllRows();
    return query.isEmpty;
  }

  static Future<int> insert(User user) async {
    await open();
    return await _database!.insert(table, user.toMap());
  }

  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    await open();
    return await _database!.query(table);
  }

  static Future<int> update(Map<String, dynamic> row) async {
    await open();
    int id = row[columnId];
    return await _database!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    await open();
    return await _database!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
