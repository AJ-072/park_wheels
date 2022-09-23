import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ErrorPage(Function() onPressed) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Something Went Wrong!",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          TextButton(onPressed: onPressed, child: const Text("Try again"))
        ],
      ),
    );
