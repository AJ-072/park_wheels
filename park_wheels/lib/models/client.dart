import 'package:firebase_auth/firebase_auth.dart';

class Client {
  String? _name;
  String? _email;
  String? _phone;
  String? _password;
  String? _id;

  String get name => _name ?? '';
  String get email => _email ?? '';
  String get password => _password ?? '';
  String get phone => _phone ?? '';
  String get id => _id ?? "";

  Client(
      {required String name,
      required String email,
      required String phone,
      String? password,
      String? id}) {
    _email = email;
    _name = name;
    _password = password;
    _phone = phone;
    _id = id;
  }
  Client.map(User user) {
    _name = user.displayName;
    _email = user.email;
    _phone = user.phoneNumber;
    _id = user.uid;
  }
}
