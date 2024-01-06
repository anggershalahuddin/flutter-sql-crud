import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  // Private constructor
  DatabaseProvider._();

  // Singleton instance
  static final DatabaseProvider db = DatabaseProvider._();

  // Late variable to store database instance
  late Database _database;

  // Getter to access database
  Future<Database> get database async {
    _database = await getDatabaseInstance();
    return _database;
  }

  // Get database instance
  Future<Database> getDatabaseInstance() async {
    // Get application documents directory
    Directory directory = await getApplicationDocumentsDirectory();

    // Create path to database file
    String path = join(directory.path, "localhost.db");

    // Open or create database at path
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // Create table on database creation
      db.execute("""CREATE TABLE Contact(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        email TEXT
      )""");
    });
  }
}
