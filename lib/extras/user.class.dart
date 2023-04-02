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
