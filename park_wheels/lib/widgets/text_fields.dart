import 'package:flutter/material.dart';

class SignInTextField extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TextField(
      showCursor: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Color(0xFF666666),
         // size: defaultIconSize,
        ),
        suffixIcon: Icon(
          Icons.remove_red_eye,
          color: Color(0xFF666666),
          //size: defaultIconSize,
        ),
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(
          color: Color(0xFF666666),
          //fontFamily: defaultFontFamily,
          //fontSize: defaultFontSize,
        ),
        hintText: "Password",
      ),
    );
  }

}