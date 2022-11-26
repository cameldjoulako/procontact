import 'package:procontact/database/databaseConnection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Ajouter un contact
  insertContact(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Recuperer tous les Contacts
  readContact(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Modifier un contact
  updateContact(table, data) async {
    var connection = await database;
    return await connection?.update(
      table,
      data,
      where: 'id=?',
      whereArgs: [data['id']],
    );
  }

  //Supprimer un Contact
  deleteContactById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
