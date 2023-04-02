import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  late final int id;
  late final String name;
  late final String password;
  late final int type;

  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.type});
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    password = map['password'];
    type = map['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'type': type,
    };
  }

  // Implementa toString para que sea más fácil ver información sobre cada user
  // usando la declaración de impresión.
  @override
  String toString() {
    return 'User{id: $id, name: $name, password: $password, type: $type}';
  }
}

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'appLab_database.db';

  static Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
              'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, password TEXT, type INTEGER)',
            ),
        version: _version);
  }

  static Future<void> insertUser(User user) async {
    // Obtiene una referencia de la base de datos
    final Database db = await getDB();
    // Inserta el User en la tabla correcta. También puede especificar el
    // `conflictAlgorithm` para usar en caso de que el mismo User se inserte dos veces.
    // En este caso, reemplaza cualquier dato anterior.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> users() async {
    // Obtiene una referencia de la base de datos
    final Database db = await getDB();
    // Consulta la tabla por todos los Users.
    final List<Map<String, dynamic>> maps = await db.query('users');
    // Convierte List<Map<String, dynamic> en List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        password: maps[i]['password'],
        type: maps[i]['type'],
      );
    });
  }

  static Future<void> updateUser(User user) async {
    // Obtiene una referencia de la base de datos
    final db = await getDB();
    // Actualiza el Dog dado
    await db.update(
      'users',
      user.toMap(),
      // Aseguúrate de que solo actualizarás el User con el id coincidente
      where: 'id = ?',
      // Pasa el id User a través de whereArg para prevenir SQL injection
      whereArgs: [user.id],
    );
  }

  static Future<void> deleteUser(int id) async {
    // Obtiene una referencia de la base de datos
    final db = await getDB();
    // Elimina el User de la base de datos
    await db.delete(
      'users',
      // Utiliza la cláusula `where` para eliminar un user específico
      where: 'id = ?',
      // Pasa el id User a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }

  static Future<User> getUser(int id, String password) async {
    // Obtiene una referencia de la base de datos
    final db = await getDB();
    // Obtiene una lista de listas sobre el resultado obtenido
    final maps = await db.query(
      'users',
      where: 'id = ? AND password = ?',
      whereArgs: [id, password],
    );
    if (maps.isEmpty) {
      return User(id: -1, name: 'none', password: 'none', type: -1);
    }
    return User.fromMap(maps[0]);
  }
}
