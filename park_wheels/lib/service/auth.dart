import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import '../models/client.dart';

class Auth {
  late FirebaseAuth auth;
  User? _user;

  Auth() {
    auth = FirebaseAuth.instanceFor(app: app);
    _user = auth.currentUser;
  }

  Client? get client => _user != null ? Client.map(_user!) : null;

  Future<Client?> signUp({required Client client}) {
    return auth
        .createUserWithEmailAndPassword(
            email: client.email, password: client.password)
        .then((value) async {
      _user = value.user;
      await _user?.updateDisplayName(client.name);
      // await _user
      //     ?.updatePhoneNumber(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode))
      //     .then((value) => print('phone added'));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user?.uid)
          .update({'role': 'user'}).then((value) => print("completed"));
      return _user != null ? Client.map(_user!) : null;
    });
  }

  Future<Client?> signIn({required String email, required String password}) {
    return auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _user = value.user;
      return _user != null ? Client.map(_user!) : null;
    });
  }

  Future<void> signOut() => auth.signOut();

  Future<void> updateProfile({String? name, String? email}) async {
    if (name != null) await _user?.updateDisplayName(name);
    if (email != null) await _user?.updateEmail(email);
  }

  Future<void> updatePassword({required String password}) async {
    await _user?.updatePassword(password);
  }

  void userListener({Function(Client client)? listener}) {
    auth.userChanges().listen((event) {
      _user = event;
      if (listener != null) listener(Client.map(_user!));
    });
  }
}
