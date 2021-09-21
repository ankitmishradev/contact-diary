import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DiaryDB with ChangeNotifier {
  static final _dbName = 'DiaryDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'persons';

  DiaryDB._privateConstructor();

  static final DiaryDB instance = DiaryDB._privateConstructor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(
      directory.path,
      _dbName,
    );
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
          CREATE TABLE $_tableName 
          ( 
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT,
            phone int NOT NULL,
            address TEXT,
            relation TEXT NOT NULL,
            isFav BOOLEAN NOT NULL,
            inTouch BOOLEAN NOT NULL,
            profileImage TEXT
          )
      ''');

    await db.execute(''' 
          CREATE TABLE groups
          ( 
            id int PRIMARY KEY,
            group TEXT NOT NULL UNIQUE
          )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(
      tableName,
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(String id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
