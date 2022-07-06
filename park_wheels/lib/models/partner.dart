import 'package:firebase_auth/firebase_auth.dart';

class Partner{
  String? _name;
  String? _email;
  String? _phone;
  String? _password;

  String get name=> _name??'';
  String get email=> _email??'';
  String get password=> _password??'';
  String get phone =>_phone??'';

  Partner({required String name,required String email,required String phone, String? password}){
    _email = email;
    _name = name;
    _password = password;
    _phone = phone;
  }
  Partner.map(User user){
    _name = user.displayName;
    _email = user.email;
    _phone = user.phoneNumber;
  }
}