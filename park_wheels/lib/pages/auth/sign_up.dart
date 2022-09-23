import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_wheels/pages/auth/sign_in.dart';
import 'package:park_wheels/widgets/common/loading.dart';

import '../../main.dart';
import '../../models/client.dart';
import '../../service/auth.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/text_field.dart';
import '../home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularBorderTextField(
                  controller: nameController,
                  label: "Name",
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person),
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return "name field can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularBorderTextField(
                  controller: emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return "email field can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularBorderTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  label: "Phone",
                  prefixIcon: const Icon(Icons.phone),
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return "phone field can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularBorderTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  label: "Password",
                  prefixIcon: const Icon(Icons.lock_outlined),
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return "password field can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularBorderTextField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  label: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock_outlined),
                  validator: (text) {
                    if (text != passwordController.text) {
                      return "password mismatch";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                SubmitButton(
                    onPressed: () {
                      onSubmit(context);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    )),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => SignIn())),
                    child: const Text(
                      "Already a member? Sign In",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSubmit(context) {
    String? error;
    if (nameController.text == '') error = "name can't be empty";
    if (emailController.text == '') error = "email can't be empty";
    if (passwordController.text == '') error = "password can't be empty";
    if (confirmPasswordController.text == '')
      error = "confirm password can't be empty";
    if (confirmPasswordController.text != passwordController.text)
      error = "password mismatch";
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    showDialog(context: context, builder: (_) => const FullPageLoadingBar());
    getIt<Auth>()
        .signUp(
            client: Client(
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                password: passwordController.text))
        .then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("can't sign Up")));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
      }
    }, onError: (error) {
      error as FirebaseException;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.code.replaceAll('-', ' '))));
    }).whenComplete(() => Navigator.of(context, rootNavigator: true).pop());
  }

// String? nameValidator(String? value){
//   name = value;
//   if(value==null||value=='') {
//     return null;
//   }
//   if(!RegExp(r'^[a-z .A-Z]+$').hasMatch(value)) {
//     return 'Name can only contain alphabets,whitespace and \'.\'';
//   }
//   return null;
// }

// String? confirmPasswordValidator(String? value){
//   if(value==null||value==''||_password==null||_password=='') {
//     return null;
//   }
//   if(_password!=value) {
//     return 'password miss match';
//   }
//   return null;
// }

// String? passwordValidator(String? value){
//   pass = value;
//   if(pass==null||pass=='') {
//     return null;
//   }
//   int len = pass?.length??0;
//   if(len<6)
//     return 'min length : 6';
//   bool alpha = RegExp(r'^[a-zA-Z]+$').hasMatch(pass!);
//   bool number = RegExp(r'^[0-9]+$').hasMatch(pass!);
//   bool symbols = RegExp(r'^[ !@#$%^&*\(\)_\-+=[]{}\|;:",><.?/~`]+$').hasMatch(pass!);
//   //if()
// }
}
