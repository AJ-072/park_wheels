import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:park_wheels/pages/auth/sign_in.dart';
import 'package:park_wheels/pages/home/home.dart';
import 'package:park_wheels/service/auth.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: userApp,options: DefaultFirebaseOptions.currentPlatform);
  await _init();
  runApp(const MyApp());
}

final getIt = GetIt.instance;

Future _init() async{
  getIt.registerSingleton(Auth());
}

const String userApp = 'user_app';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Park Wheels-partner',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,

        ),
        home: getIt<Auth>().partner == null?SignIn():Home()
    );
  }
}