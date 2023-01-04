import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:budget_tracker_app/database_connection.dart';

class Repository {
  late DatabaseConnection databaseconnection;

  Repository() {
    databaseconnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await databaseconnection.setDatabase();
      return _database;
    }
  }

  insertBudget(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  selectMyBudget(table) async {
    var connection = await database;
    return await connection?.rawQuery("select *from $table");
  }

  deleteEntryFromBudget(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawQuery("DELETE FROM $table WHERE id = ? ", [itemId]);
  }

  deleteEntryFromSaving(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawQuery("DELETE FROM $table WHERE id = ? ", [itemId]);
  }

  fetchEntryByMonth(table, monthname) async {
    var connection = await database;
    return await connection?.query(table,
        columns: ['id', 'amount', 'month', 'title'],
        where: 'month = ?',
        whereArgs: [monthname]);
  }

  insertExpence(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  selectMyExpence(table) async {
    var connection = await database;
    return await connection?.rawQuery("select *from $table");
  }

  fetchSavingsData(table) async {
    var connection = await database;
    return await connection?.rawQuery("select *from $table");
  }

  deleteEntryFromExpence(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawQuery("DELETE FROM $table WHERE id = ? ", [itemId]);
  }

  fetchEntryByMonthExpence(table, monthname) async {
    var connection = await database;
    return await connection?.query(table,
        columns: ['id', 'amount', 'month', 'title'],
        where: 'month = ?',
        whereArgs: [monthname]);
  }

  insertSaving(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  selectMySaving(table) async {
    var connection = await database;
    return await connection?.rawQuery("select *from $table");
  }

  fetchEntryByMonthSaving(table, monthname) async {
    var connection = await database;
    return await connection?.query(table,
        columns: [
          'id',
          'amount',
          'monthS',
          'title',
        ],
        where: 'month = ?',
        whereArgs: [monthname]);
  }
}
