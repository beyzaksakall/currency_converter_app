import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'currency_history.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE history(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fromCurrency TEXT,
          toCurrency TEXT,
          amount REAL,
          result REAL,
          date TEXT
        )
        ''');
      },
    );
  }

  static Future<void> insertHistory({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
    required double result,
    required String date,
  }) async {
    final db = await database;
    await db.insert('history', {
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'amount': amount,
      'result': result,
      'date': date,
    });
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return db.query('history', orderBy: 'id DESC');
  }

  static Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
  }
}
