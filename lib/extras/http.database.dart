// To parse this JSON data, do
//
//     final computer = computerFromJson(jsonString);

import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import 'BO/BO.dart';

List<Computer> computerFromJson(String str) =>
    List<Computer>.from(json.decode(str).map((x) => Computer.fromJson(x)));

String computerToJson(List<Computer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Computer {
  late final int idComputer;
  late final int idLaboratorio;

  Computer({
    required this.idComputer,
    required this.idLaboratorio,
  });
  @override
  int get hashCode => Object.hash(idComputer, idLaboratorio);
  @override
  bool operator ==(Object other) =>
      other is Computer && other.idComputer == idComputer;

  factory Computer.fromJson(Map<String, dynamic> json) => Computer(
        idComputer: json["idComputer"],
        idLaboratorio: json["idLaboratorio"],
      );

  Map<String, dynamic> toJson() => {
        "idComputer": idComputer,
        "idLaboratorio": idLaboratorio,
      };
}

List<Lab> labFromJson(String str) =>
    List<Lab>.from(json.decode(str).map((x) => Lab.fromJson(x)));

String labToJson(List<Lab> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lab {
  late final int idLab;
  Lab({
    required this.idLab,
  });

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
        idLab: json["idLab"],
      );

  Map<String, dynamic> toJson() => {
        "idLab": idLab,
      };
}

List<Module> moduleFromJson(String str) =>
    List<Module>.from(json.decode(str).map((x) => Module.fromJson(x)));

String moduleToJson(List<Module> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Module {
  late final int idModule;
  late final String startHour;
  late final String finalHour;

  Module({
    required this.idModule,
    required this.startHour,
    required this.finalHour,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        idModule: json["idModule"],
        startHour: json["startHour"],
        finalHour: json["finalHour"],
      );

  Map<String, dynamic> toJson() => {
        "idModule": idModule,
        "startHour": startHour,
        "finalHour": finalHour,
      };
}

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  late final String id;
  late final String name;
  late final int type;
  late final String hash;
  late final String randomString;

  User({
    required this.id,
    required this.name,
    required this.type,
    required this.randomString,
    required this.hash,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      hash: json["hash"],
      randomString: json["randomString"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "hash": hash,
        "randomString": randomString
      };
  static Encrypter getEncrypter(String id, String name, int type) {
    Encrypter encrypter = Encrypter(Salsa20(Key.fromUtf8('$id$name$type')));
    return encrypter;
  }

  static Encrypted getHash(
      String id, String name, int type, String password, String randomString) {
    Encrypter encrypter = getEncrypter(id, name, type);
    Encrypted hash = encrypter.encrypt(password, iv: IV.fromUtf8(randomString));
    return hash;
  }

  bool verifyPassword(String newpassword) {
    Encrypter encrypter = getEncrypter(id, name, type);
    Encrypted newhash =
        encrypter.encrypt(newpassword, iv: IV.fromUtf8(randomString));
    if (newhash.base64 == hash) {
      return true;
    }
    return false;
  }
}

List<Reservation> reservationFromJson(String str) => List<Reservation>.from(
    json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  late int idReservation;
  late final int idUsuario;
  late final int idModuloS;
  late final int idModuloE;
  late final int idLab;
  late final int reservationType;
  late final String reservationDate;
  late final int idComputer;

  Reservation({
    required this.idReservation,
    required this.idUsuario,
    required this.idModuloS,
    required this.idModuloE,
    required this.idLab,
    required this.reservationType,
    required this.reservationDate,
    required this.idComputer,
  });
  static int compare(Reservation a, Reservation b) {
    if (a.idModuloS == b.idModuloS) return 0;
    if (a.idModuloS < b.idModuloS) return -1;
    if (a.idModuloS > b.idModuloS) return 1;
    return -1;
  }

  @override
  bool operator ==(Object other) =>
      other is Reservation &&
      other.idUsuario == idUsuario &&
      other.idLab == idLab &&
      other.idModuloE == idModuloE &&
      other.idModuloS == idModuloS &&
      other.reservationDate == reservationDate &&
      other.reservationType == reservationType;
  @override
  int get hashCode => Object.hash(
      idUsuario, idLab, idModuloE, idModuloS, reservationDate, reservationType);

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        idReservation: json["idReservation"],
        idUsuario: json["idUsuario"],
        idModuloS: json["idModuloS"],
        idModuloE: json["idModuloE"],
        idLab: json["idLab"],
        reservationType: json["reservationType"],
        reservationDate: json["reservationDate"],
        idComputer: json["idComputer"],
      );

  Map<String, dynamic> toJson() => {
        "idReservation": idReservation,
        "idUsuario": idUsuario,
        "idModuloS": idModuloS,
        "idModuloE": idModuloE,
        "idLab": idLab,
        "reservationType": reservationType,
        "reservationDate": reservationDate,
        "idComputer": idComputer,
      };
}
