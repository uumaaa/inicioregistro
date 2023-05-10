import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import '../extras/http.database.dart';

class Http {
  final url =
      Platform.isAndroid ? 'http://10.0.2.2:8000/' : 'http:/localhost:8000';
  final computerAPI = 'computers/';
  final labAPI = 'labs/';
  final moduleAPI = 'modules/';
  final reservationAPI = 'reservations/';
  final userAPI = 'users/';
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');
  Http();
  //GET
  Future<List<Computer>> computers(int selectedLab) async {
    Uri uri = Uri.parse('$url$computerAPI?idLab=$selectedLab');
    http.Response response = await http.get(uri);
    return computerFromJson(
      response.body,
    );
  }

  Future<List<Lab>> labs() async {
    Uri uri = Uri.parse('$url$labAPI');
    http.Response response = await http.get(uri);
    return labFromJson(
      response.body,
    );
  }

  Future<List<Module>> modules() async {
    Uri uri = Uri.parse('$url$moduleAPI');
    http.Response response = await http.get(uri);
    return moduleFromJson(
      response.body,
    );
  }

  Future<List<Reservation>> reservations() async {
    Uri uri = Uri.parse('$url$reservationAPI');
    http.Response response = await http.get(uri);
    return reservationFromJson(
      response.body,
    );
  }

  Future<List<User>> users() async {
    Uri uri = Uri.parse('$url$userAPI');
    http.Response response = await http.get(uri);
    return userFromJson(
      response.body,
    );
  }

  //POST
  Future<void> insertComputer(Computer computer) async {
    Uri uri = Uri.parse('$url$computerAPI');
    String body = json.encode(computer.toJson());
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> insertLab(Lab lab) async {
    Uri uri = Uri.parse('$url$labAPI');
    String body = json.encode(lab.toJson());
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> insertModule(Module module) async {
    Uri uri = Uri.parse('$url$moduleAPI');
    String body = json.encode(module.toJson());
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> insertReservation(Reservation reservation) async {
    print('$url$reservationAPI');
    Uri uri = Uri.parse('$url$reservationAPI');
    String body = json.encode(reservation.toJson());
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    print(response.statusCode);
    return;
  }

  Future<void> insertUser(User user) async {
    print("entre");
    Uri uri = Uri.parse('$url$userAPI');
    String body = json.encode(user.toJson());
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  //PUT
  Future<void> updateComputer(Computer computer) async {
    Uri uri = Uri.parse('$url$computerAPI${computer.idComputer}');
    String body = json.encode(computer.toJson());
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> updateLab(Lab lab) async {
    Uri uri = Uri.parse('$url$labAPI${lab.idLab}');
    String body = json.encode(lab.toJson());
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> updateModule(Module module) async {
    Uri uri = Uri.parse('$url$moduleAPI${module.idModule}');
    String body = json.encode(module.toJson());
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> updateReservation(Reservation reservation) async {
    Uri uri = Uri.parse('$url$reservationAPI${reservation.idReservation}');
    String body = json.encode(reservation.toJson());
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  Future<void> updateUser(User user) async {
    Uri uri = Uri.parse('$url$userAPI${user.id}');
    String body = json.encode(user.toJson());
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return;
  }

  //DELETE
  Future<void> deleteComputer(Computer computer) async {
    Uri uri = Uri.parse('$url$computerAPI${computer.idComputer}');
    http.Response response = await http.delete(
      uri,
      headers: headers,
    );
    return;
  }

  Future<void> deleteLab(Lab lab) async {
    Uri uri = Uri.parse('$url$labAPI${lab.idLab}');
    http.Response response = await http.delete(
      uri,
      headers: headers,
    );
    return;
  }

  Future<void> deleteModule(Module module) async {
    Uri uri = Uri.parse('$url$moduleAPI${module.idModule}');
    http.Response response = await http.delete(
      uri,
      headers: headers,
    );
    return;
  }

  Future<void> deleteReservation(Reservation reservation) async {
    Uri uri = Uri.parse('$url$reservationAPI${reservation.idReservation}');
    http.Response response = await http.delete(
      uri,
      headers: headers,
    );
    return;
  }

  Future<void> deleteUser(User user) async {
    Uri uri = Uri.parse('$url$userAPI${user.id}');
    http.Response response = await http.delete(
      uri,
      headers: headers,
    );
    return;
  }

  //EXTRAS

  Future<List<Computer>> getComputersBetweenModules(
      int startModule, int endModule, String date, int lab) async {
    Uri uri = Uri.parse(
        '$url$reservationAPI?startModule=$startModule&endModule=$endModule&reservationDate=$date&lab=$lab');
    http.Response response = await http.get(uri);
    List<Reservation> reservations = reservationFromJson(response.body);
    List<Computer> computersUsed = [];
    List<Computer> allComputers = await computers(lab);
    for (var reservation in reservations) {
      if (reservation.reservationType == 2) {
        return allComputers;
      } else {
        computersUsed.add(Computer(
            idComputer: reservation.idComputer,
            idLaboratorio: reservation.idLab));
      }
    }
    return computersUsed;
  }

  Future<int> numberOfReservations() async {
    Uri uri = Uri.parse('$url$reservationAPI');
    http.Response response = await http.get(uri);
    return reservationFromJson(
      response.body,
    ).length;
  }

  Future<List<Reservation>> reservationsFromDateAndLab(
      String date, int lab) async {
    Uri uri = Uri.parse('$url$reservationAPI?reservationDate=$date&lab=$lab');
    http.Response response = await http.get(uri);
    return reservationFromJson(
      response.body,
    );
  }

  Future<Map<int, int>> obtainDiferentReservations(String date, int lab) async {
    Map<int, int> diferentReservationsMap = {};
    List<Reservation> reservations =
        await reservationsFromDateAndLab(date, lab);
    reservations.sort((a, b) => Reservation.compare(a, b));
    List<int> contador = [];
    List<Reservation> diferentReservations = [];
    for (Reservation reservation in reservations) {
      if (!diferentReservations.contains(reservation)) {
        diferentReservations.add(reservation);
        contador.add(1);
      } else {
        contador[diferentReservations.indexOf(reservation)]++;
      }
    }
    for (var i = 0; i < diferentReservations.length; i++) {
      diferentReservationsMap[i] = contador[i];
    }
    return diferentReservationsMap;
  }

  Future<List<Reservation>> obtainDiferentList(String date, int lab) async {
    Map<Reservation, int> diferentReservationsMap = {
      Reservation(
          idReservation: 1,
          idUsuario: 1,
          idModuloS: 1,
          idModuloE: 1,
          idLab: 1,
          reservationType: 1,
          reservationDate: 'reservationDate',
          idComputer: 1): 2
    };
    List<Reservation> reservations =
        await reservationsFromDateAndLab(date, lab);
    reservations.sort((a, b) => Reservation.compare(a, b));
    List<int> contador = [];
    List<Reservation> diferentReservations = [];
    for (Reservation reservation in reservations) {
      if (!diferentReservations.contains(reservation)) {
        diferentReservations.add(reservation);
        contador.add(1);
      } else {
        contador[diferentReservations.indexOf(reservation)]++;
      }
    }
    return diferentReservations;
  }

  Future<List<User>> getUser(String matricula) async {
    Uri uri = Uri.parse('$url$userAPI$matricula');
    http.Response response = await http.get(uri);
    return userFromJson(
      response.body,
    );
  }
}
