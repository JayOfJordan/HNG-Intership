import 'package:sqflite/sqflite.dart';

import '../Models/product.dart';

class ProductDatabase {
  static Future<Database> _getDatabase() async {
    final database = await openDatabase('product_database.db',
      version: 4,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            product_name TEXT,
            product_quantity TEXT,
            product_price TEXT,
            product_quantifier TEXT,
            product_image TEXT,
            product_description TEXT
          )
        ''');
        await db.insert('products', {
          'product_name': 'Sample Shoe',
          'product_quantity': '15',
          'product_price': '25000',
          'product_quantifier': 'Pairs',
          'product_image': 'assets/ads 2.jpg',
          'product_description': 'A high-quality sample shoe.'
        });
        await db.insert('products', {
          'product_name': 'Sample Bag',
          'product_quantity': '20',
          'product_price': '₦15000',
          'product_quantifier': 'Units',
          'product_image': 'assets/ads 2.jpg',
          'product_description': 'A stylish sample bag.'
        });
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE products ADD COLUMN product_image TEXT;");
        }
        if (oldVersion < 3) {
          await db.execute("ALTER TABLE products ADD COLUMN product_description TEXT;");
        }
      },
    );
    return database;
  }

  static Future<List<Product>> getProducts() async {
    final db = await _getDatabase();
    final result = await db.query('products');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  static Future<int> addProduct(Product product) async {
    final db = await _getDatabase();
    return await db.insert('products', product.toMap());
  }

  static Future<int> updateProduct(Product product) async {
    final db = await _getDatabase();
    return await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id]);
  }

  static Future<int> deleteProduct(int id) async {
    final db = await _getDatabase();
    return await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id]);
  }
}
