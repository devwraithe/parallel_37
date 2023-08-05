import 'package:parallel_37/src/data/models/cart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await createDatabase();
    } else {
      return _database!;
    }
    return _database!;
  }

  createDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "cart.db");
    // deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT, product_id INTEGER, name VARCHAR, image VARCHAR, price DOUBLE,  publisher_id INTEGER)',
    );
  }

  // insert data to database
  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient?.insert(
      "cart",
      cart.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return cart;
  }

  // === get all db items === //
  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query("cart");
    final queryResultMap =
        queryResult.map((result) => Cart.fromMap(result)).toList();
    return queryResultMap;
  }

  // === delete item from cart === //
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete(
      "cart",
      where: "rowid = ?",
      whereArgs: [id],
    );
  }
}
