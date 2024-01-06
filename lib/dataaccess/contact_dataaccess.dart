import 'package:flutter_application_1_sql_crud/model/contact_model.dart';
import 'package:flutter_application_1_sql_crud/provider/sqllite_provider.dart';
import 'package:sqflite/sqflite.dart';

class ContactDataAcess {
  // Retrieve all contacts from database
  Future<List<Contact>> getAll() async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Contact");
    List<Contact> list = response.map((e) => Contact.fromMap(e)).toList();
    return list;
  }

  // Retrieve contact by ID from database
  Future<Contact?> getById(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Contact", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Contact.fromMap(response.first) : null;
  }

  // Insert new contact into database
  insert(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.insert("Contact",
        {"name": contact.name, "phone": contact.phone, "email": contact.email},
        conflictAlgorithm: ConflictAlgorithm.replace);
    return response;
  }

  // Update existing contact in database
  update(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.update("Contact", contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
    return response;
  }

  // Delete contact by ID from database
  delete(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Contact", where: "id = ?", whereArgs: [id]);
    return response;
  }

  // Delete all contacts from database
  deleteAll(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Contact");
    return response;
  }
}
