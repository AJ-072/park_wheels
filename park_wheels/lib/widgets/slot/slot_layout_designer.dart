import 'package:flutter/material.dart';
import 'package:park_wheels/widgets/slot/slot.dart';

import '../../models/slot.dart';

class DesignerBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DesignerBoxState();
}

class DesignerBoxState extends State<DesignerBox> {

  List<SlotData> slots = [];

  @override
  Widget build(BuildContext context) {
    String id = (slots.length+1).toString();
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            child: GestureDetector(
              onTap: (){

                setState(()=>slots.add(SlotData(id:id,dx: 0, dy: 0, type: SlotType.slot)));
              },
              child: Slot(id: id,),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey, width: 3),
                    color: Colors.white),
                child: Stack(
                  children: slots.map((e) => Item(data: e,onDelete: delete,)).toList(),
                )),
          )
        ],
      )),
    );
  }

  void delete(SlotData data){
    slots.remove(data);
  }
}

class Item extends StatefulWidget {
  final SlotData data;
  final Function(SlotData) onDelete;
  const Item({Key? key,required this.data,required this.onDelete}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemState();
}

class ItemState extends State<Item> {
  late double dx, dy;

  @override
  void initState() {
    dx = widget.data.dx;
    dy = widget.data.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: dx,
        top: dy,
        child: GestureDetector(
          onPanUpdate: (details) => {
            setState(() {
              dx += details.delta.dx;
              dy += details.delta.dy;
            })
          },
          onLongPress: (){
            AlertDialog(
              title: Text('slot: ${widget.data.id}'),
            );
          },
          child: Slot(id: widget.data.id??''),
        ));
  }
}
