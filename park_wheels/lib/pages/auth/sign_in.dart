import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_wheels/pages/auth/sign_up.dart';

import '../../main.dart';
import '../../service/auth.dart';
import '../../widgets/button.dart';
import '../../widgets/loading.dart';
import '../../widgets/text_field.dart';
import '../home/home.dart';


class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        if (_loading) const FullPageLoadingBar(),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularBorderTextField(
                  label: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  controller: usernameController,
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return "username field can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                PasswordTextField(
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return "password field can't be empty";
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onForgotPassword,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SubmitButton(
                    onPressed: () => onSubmit(context),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                //const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: const Text(
                      "New User? Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  onSubmit(context) {
    if (usernameController.text == '' || passwordController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("username or password is invalid")));
      return;
    }
    setState(() => _loading = true);
    getIt<Auth>()
        .signIn(
            email: usernameController.text, password: passwordController.text)
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Can't sign In")));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      }
    }, onError: (error, state) {
      error as FirebaseAuthException;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text((error.code.replaceAll('-', ' ')))));
    }).whenComplete(() => setState(() => _loading = false));
  }

  onForgotPassword() {}
}
