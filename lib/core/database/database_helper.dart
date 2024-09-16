import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokemon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE pokemons(
      id INTEGER PRIMARY KEY,
      name TEXT,
      url TEXT,
      height INTEGER,
      weight INTEGER,
      types TEXT
    )
    ''');
  }

  Future<void> insertPokemon(Results pokemon) async {
    final db = await database;
    await db.insert('pokemons', pokemon.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Results>> getAllPokemons() async {
    final db = await database;
    final maps = await db.query('pokemons');
    print('Fetched ${maps.length} pokemons from local database');
    return maps.map((map) {
      var pokemonMap = Map<String, dynamic>.from(map);
      if (pokemonMap['types'] is String) {
        pokemonMap['types'] = (pokemonMap['types'] as String).split(',');
      }
      return Results.fromJson(pokemonMap);
    }).toList();
  }

  Future<Results?> getPokemon(int id) async {
    final db = await database;
    final maps = await db.query('pokemons', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Results.fromJson(maps.first);
    }
    return null;
  }

  Future<bool> hasLocalData() async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM pokemons'));
    return count != null && count > 0;
  }

  Future<void> setFirstLaunch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', value);
    print('Set first launch to $value');
  }

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool('first_launch') ?? true;
    print('Is first launch: $isFirst');
    return isFirst;
  }
}