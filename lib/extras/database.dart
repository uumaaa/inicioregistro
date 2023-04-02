//Version1 BD Users App Lab
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
    // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
    // construida para cada plataforma.
    join(await getDatabasesPath(), 'appLab_database.db'),
    // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar users
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, password TEXT, type INTEGER)",
      );
    },
    // Establece la versión. Esto ejecuta la función onCreate y proporciona una
    // ruta para realizar actualizacones y defradaciones en la base de datos.
    version: 1,
  );

  Future<void> insertUser(User user) async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Inserta el User en la tabla correcta. También puede especificar el
    // `conflictAlgorithm` para usar en caso de que el mismo User se inserte dos veces.
    // En este caso, reemplaza cualquier dato anterior.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

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

  Future<void> updateUser(User user) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Actualiza el Dog dado
    await db.update(
      'users',
      user.toMap(),
      // Aseguúrate de que solo actualizarás el User con el id coincidente
      where: "id = ?",
      // Pasa el id User a través de whereArg para prevenir SQL injection
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Elimina el User de la base de datos
    await db.delete(
      'users',
      // Utiliza la cláusula `where` para eliminar un user específico
      where: "id = ?",
      // Pasa el id User a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }

  var user1 = User(
    id: 2022710024,
    name: 'Alvaro',
    password: 'No Idea Bro',
    type: 1,
  );

  // Inserta un user en la base de datos
  await insertUser(user1);

  // Imprime la lista de users (solamente user1 por ahora)
  print(await users());

  // Actualiza la contraseña de user1 y lo guarda en la base de datos
  user1 = User(
    id: user1.id,
    name: user1.name,
    password: 'New password',
    type: user1.type,
  );
  await updateUser(user1);

  // Imprime la información de user1 actualizada
  print(await users());

  // Elimina a user1 de la base de datos
  await deleteUser(user1.id);

  // Imprime la lista de users (vacía)
  print(await users());
}

class User {
  final int id;
  final String name;
  final String password;
  final int type;

  User(
      {required this.id,
      required this.name,
      required this.password,
      required this.type});

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
