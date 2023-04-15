import 'dart:io';

import 'package:flutter/services.dart';
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

class Module {
  late final int idModule;
  late final String startHour;
  late final String finalHour;

  Module(
      {required this.idModule,
      required this.startHour,
      required this.finalHour});

  Module.fromMap(Map<String, dynamic> map) {
    idModule = map['idModule'];
    startHour = map['startHour'];
    finalHour = map['finalHour'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idModule': idModule,
      'startHour': startHour,
      'finalHour': finalHour,
    };
  }

  @override
  String toString() {
    return 'Module{idModule: $idModule, startHour: $startHour, finalHour: $finalHour}';
  }
}

class Lab {
  late final int idLab;

  Lab({
    required this.idLab,
  });

  Lab.fromMap(Map<String, dynamic> map) {
    idLab = map['idLab'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idLab': idLab,
    };
  }

  @override
  String toString() {
    return 'Lab{idLab: $idLab}';
  }
}

class Computer {
  late final int idComputer;

  Computer({
    required this.idComputer,
  });

  Computer.fromMap(Map<String, dynamic> map) {
    idComputer = map['idComputer'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idComputer': idComputer,
    };
  }

  @override
  String toString() {
    return 'Lab{idComputer: $idComputer}';
  }
}

class Reservation {
  late final int idReservation;
  late final int idUsuario;
  late final int idModulo;
  late final String reservationType;
  late final int idComputer;

  Reservation({
    required this.idReservation,
    required this.idUsuario,
    required this.idModulo,
    required this.reservationType,
    required this.idComputer,
  });

  Reservation.fromMap(Map<String, dynamic> map) {
    idReservation = map['idReservation'];
    idUsuario = map['idUsuario'];
    idModulo = map['idModulo'];
    reservationType = map['reservationType'];
    idComputer = map['idComputer'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idReservation': idReservation,
      'idUsuario': idUsuario,
      'idModulo': idModulo,
      'reservationType': reservationType,
      'idComputer': idComputer,
    };
  }

  @override
  String toString() {
    return 'Reservation{idReservation: $idReservation, idUsuario: $idUsuario, idModulo: $idModulo, reservationType: $reservationType, idComputadora: $idComputer}';
  }
}

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'dbUsers.db';

  static void initializeDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "dbUsers.db");
    await deleteDatabase(dbPath);
    ByteData data = await rootBundle.load("assets/dbUsers.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
  }

  static Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        version: _version);
  }

  //Users Functions

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

  //Modules functions
  static Future<void> insertModule(Module module) async {
    final Database db = await getDB();

    await db.insert(
      'modules',
      module.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Module>> modules() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('modules');

    return List.generate(maps.length, (i) {
      return Module(
        idModule: maps[i]['idModule'],
        startHour: maps[i]['startHour'],
        finalHour: maps[i]['finalHour'],
      );
    });
  }

  static Future<void> updateModule(Module module) async {
    final db = await getDB();

    await db.update(
      'modules',
      module.toMap(),
      where: 'idModule = ?',
      whereArgs: [module.idModule],
    );
  }

  static Future<void> deleteModule(int idModule) async {
    final db = await getDB();
    await db.delete(
      'modules',
      where: 'idModule = ?',
      whereArgs: [idModule],
    );
  }

  static Future<Module> getModule(int idModule) async {
    final db = await getDB();
    final maps = await db.query(
      'modules',
      where: 'idModule = ?',
      whereArgs: [idModule],
    );
    if (maps.isEmpty) {
      return Module(idModule: -1, startHour: 'none', finalHour: 'none');
    }
    return Module.fromMap(maps[0]);
  }

  //Lab functions
  static Future<void> insertLab(Lab lab) async {
    final Database db = await getDB();

    await db.insert(
      'labs',
      lab.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Lab>> labs() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('labs');

    return List.generate(maps.length, (i) {
      return Lab(
        idLab: maps[i]['idLab'],
      );
    });
  }

  static Future<void> updateLab(Lab lab) async {
    final db = await getDB();

    await db.update(
      'labs',
      lab.toMap(),
      where: 'idLab = ?',
      whereArgs: [lab.idLab],
    );
  }

  static Future<void> deleteLab(int idLab) async {
    final db = await getDB();
    await db.delete(
      'labs',
      where: 'idLab = ?',
      whereArgs: [idLab],
    );
  }

  static Future<Lab> getLab(int idLab) async {
    final db = await getDB();
    final maps = await db.query(
      'labs',
      where: 'idLab = ?',
      whereArgs: [idLab],
    );
    if (maps.isEmpty) {
      return Lab(idLab: -1);
    }
    return Lab.fromMap(maps[0]);
  }

  //Computer functions
  static Future<void> insertComputer(Computer computer) async {
    final Database db = await getDB();
    await db.insert(
      'computers',
      computer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Computer>> computers() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('computers');

    return List.generate(maps.length, (i) {
      return Computer(
        idComputer: maps[i]['idComputer'],
      );
    });
  }

  static Future<void> updateComputer(Computer computer) async {
    final db = await getDB();

    await db.update(
      'computers',
      computer.toMap(),
      where: 'idComputer = ?',
      whereArgs: [computer.idComputer],
    );
  }

  static Future<void> deleteComputer(int idComputer) async {
    final db = await getDB();
    await db.delete(
      'computers',
      where: 'idComputer = ?',
      whereArgs: [idComputer],
    );
  }

  static Future<Computer> getComputer(int idComputer) async {
    final db = await getDB();
    final maps = await db.query(
      'computers',
      where: 'idComputer = ?',
      whereArgs: [idComputer],
    );
    if (maps.isEmpty) {
      return Computer(idComputer: -1);
    }
    return Computer.fromMap(maps[0]);
  }

  //Reservation functions
  static Future<void> insertReservation(Reservation reservation) async {
    final Database db = await getDB();

    await db.insert(
      'reservations',
      reservation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Reservation>> reservation() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query('reservations');

    return List.generate(maps.length, (i) {
      return Reservation(
        idReservation: maps[i]['idReservation'],
        idUsuario: maps[i]['idUsuario'],
        idModulo: maps[i]['idModulo'],
        reservationType: maps[i]['reservationType'],
        idComputer: maps[i]['idComputer'],
      );
    });
  }

  static Future<void> updateReservation(Reservation reservation) async {
    final db = await getDB();

    await db.update(
      'reservations',
      reservation.toMap(),
      where: 'id = ?',
      whereArgs: [reservation.idReservation],
    );
  }

  static Future<void> deleteReservation(int idReservation) async {
    final db = await getDB();

    await db.delete(
      'reservations',
      where: 'id = ?',
      whereArgs: [idReservation],
    );
  }

  static Future<Reservation> getReservation(int idReservation) async {
    final db = await getDB();

    final maps = await db.query(
      'reservations',
      where: 'id: ?',
      whereArgs: [idReservation],
    );
    if (maps.isEmpty) {
      return Reservation(
          idReservation: -1,
          idUsuario: -1,
          idModulo: -1,
          reservationType: 'none',
          idComputer: -1);
    }
    return Reservation.fromMap(maps[0]);
  }
}
