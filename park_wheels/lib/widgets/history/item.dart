import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Item extends StatelessWidget{
  const Item({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
        color: Colors.blueGrey
      ),
      child: ListTile(
        
      ),
    );
  }

}