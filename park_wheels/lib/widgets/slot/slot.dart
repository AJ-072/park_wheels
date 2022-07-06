import 'package:flutter/material.dart';
enum Status{
  booked,
  parked,
  available
}
enum Type{
  electric,
  ordinary
}
class Slot extends StatelessWidget{

  final double _ratio = 0.5;
  final double _width = 130;

  final Widget? child;
  String id;

  Slot({Key? key,this.child,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (_width*_ratio),
      width: _width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey,width: 3),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(id),
          ),
          child??Container(),
        ],
      )
    );
  }
  static Widget _car({required bool isElectric, required bool isParked}){
    return Image.asset('assets/icons/cars/${isParked?'':'booked_'}${isElectric?'electric_':''}car.png',
      frameBuilder: (context,child,frame,_){
      return Padding(
        padding: const EdgeInsets.all(3),
        child: child,);
      },
    );
  }

  static Widget car({required status, required type}){
    return status==Status.available?
    Container():
    _car(isElectric: type==Type.electric, isParked: status==Status.parked);
  }
}
