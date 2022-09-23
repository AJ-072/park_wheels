import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget NoDataPage(Function() onPressed) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "No Data!",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          TextButton(onPressed: onPressed, child: const Text("refresh"))
        ],
      ),
    );
