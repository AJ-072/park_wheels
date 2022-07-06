import 'package:flutter/material.dart';

import '../../models/lot.dart';
class CircularDropDown extends StatefulWidget{
  final List data;
  final Function(Lot) onChange;
  double width;
  CircularDropDown({Key? key,required this.data,required this.onChange,this.width =200}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>CircularDropDownState();

}
class CircularDropDownState extends State<CircularDropDown>{
  late Lot lot;


  @override
  void initState() {
    lot = widget.data[0];
  }

  @override
  Widget build(BuildContext context) {
    DropdownButton<Lot> dropdown = DropdownButton(
        elevation: 0,
        dropdownColor: Colors.grey[200],
        focusColor: Colors.grey,
        underline: Container(),
        isExpanded: true,
        value: lot,
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),
        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
        items: widget.data.map((e) => DropdownMenuItem<Lot>(value: e,child: Text(e.name,overflow: TextOverflow.ellipsis,),)).toList(),
        onChanged: (lot){
          // print(lot?.name);
          widget.onChange(lot??Lot(id: '', name: ''));
          setState((){
            this.lot = lot??Lot(id: '', name: '');
          });
        });
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white)
      ),
      child: dropdown,
    );
  }
  
}