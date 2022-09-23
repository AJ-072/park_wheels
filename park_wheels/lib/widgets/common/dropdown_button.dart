import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/style.dart';

class DropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      color: Style.primary,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              "Sort ",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(
            isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 17,
          )
        ],
      ),
    );
  }
}
