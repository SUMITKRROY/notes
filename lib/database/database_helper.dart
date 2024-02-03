import 'package:notes/database/table/notes_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  // database name
  static const _databaseName = "myNoteDb.db";
  // database version
  static const _databaseVersion = 1;
// Singleton pattern
  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseHelper;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, _databaseName);

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: _databaseVersion,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {DeviceInfoTable} TABLE statement on the database.
    await db.execute(NotesTable.CREATE);

  }

  // UPGRADE DATABASE TABLES
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      switch(oldVersion){
        case 1:
        // you can execute drop table and create table
        //db.execute("ALTER TABLE tb_name ADD COLUMN newCol TEXT");
          break;
      }
    }
  }

  // Future<Breed> breed(int id) async {
  //   final db = await _databaseHelper.database;
  //   final List<Map<String, dynamic>> maps =
  //   await db.query('breeds', where: 'id = ?', whereArgs: [id]);
  //   return Breed.fromMap(maps[0]);
  // }
  //
  // Future<List<Dog>> dogs() async {
  //   final db = await _databaseHelper.database;
  //   final List<Map<String, dynamic>> maps = await db.query('dogs');
  //   return List.generate(maps.length, (index) => Dog.fromMap(maps[index]));
  // }
  //
  // // A method that updates a breed data from the breeds table.
  // Future<void> updateBreed(Breed breed) async {
  //   // Get a reference to the database.
  //   final db = await _databaseHelper.database;
  //
  //   // Update the given breed
  //   await db.update(
  //     'breeds',
  //     breed.toMap(),
  //     // Ensure that the Breed has a matching id.
  //     where: 'id = ?',
  //     // Pass the Breed's id as a whereArg to prevent SQL injection.
  //     whereArgs: [breed.id],
  //   );
  // }
  //
  // Future<void> updateDog(Dog dog) async {
  //   final db = await _databaseHelper.database;
  //   await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  // }
  //
  // // A method that deletes a breed data from the breeds table.
  // Future<void> deleteBreed(int id) async {
  //   // Get a reference to the database.
  //   final db = await _databaseHelper.database;
  //
  //   // Remove the Breed from the database.
  //   await db.delete(
  //     'breeds',
  //     // Use a `where` clause to delete a specific breed.
  //     where: 'id = ?',
  //     // Pass the Breed's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }
  //
  // Future<void> deleteDog(int id) async {
  //   final db = await _databaseHelper.database;
  //   await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  // }
}