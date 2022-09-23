import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:park_wheels/pages/auth/sign_in.dart';
import 'package:park_wheels/pages/home/home.dart';
import 'package:park_wheels/service/auth.dart';
import 'package:park_wheels/utils/style.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: userApp, options: DefaultFirebaseOptions.currentPlatform);
  await _init();
  runApp(const MyApp());
}

final getIt = GetIt.instance;

const String userApp = 'user_app';

final FirebaseApp app = Firebase.app(userApp);

Future _init() async {
  getIt.registerSingleton(Auth());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'Park Wheels',
          debugShowCheckedModeBanner: false,
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
              primaryColor: Colors.white,
              primaryColorDark: Style.secondary,
              primaryColorLight: Style.primary),
          home: getIt<Auth>().client == null ? SignIn() : Home());
    });
  }
}
