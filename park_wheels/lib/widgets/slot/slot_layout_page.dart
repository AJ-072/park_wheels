import 'package:flutter/material.dart';
import 'package:park_wheels/widgets/slot/slot.dart';

import '../../models/slot.dart';

class SlotLayout extends StatefulWidget {
  final List<ItemData> items;
  final Function(String? value) onSelect;
  const SlotLayout({Key? key, required this.items, required this.onSelect})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SlotLayoutState();
}

class SlotLayoutState extends State<SlotLayout> {
  late List<ItemData> items;
  double x = 0, y = 0;
  int? selected;

  @override
  void initState() {
    items = widget.items;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var element in widget.items) {
      print(
          "id : ${element.id} type: ${element.type} \n x : ${element.dx}\n y : ${element.dy}\n r : ${element.dr}");
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: GestureDetector(
        onScaleUpdate: (details) {
          setState(() {
            x += details.focalPointDelta.dx;
            y += details.focalPointDelta.dy;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Colors.grey, width: 3),
              color: Colors.white),
          child: Stack(children: itemWidgets(items)),
        ),
      ),
    );
  }

  List<Widget> itemWidgets(List<ItemData> data) {
    List<Widget> widgets = [];
    for (int i = 0; i < data.length; i++) {
      widgets.add(_Item(
        data: data[i],
        x: x,
        y: y,
        onSelect: () {
          setState(() {
            if (selected == i) {
              selected = null;
            } else {
              selected = i;
            }
          });
          widget.onSelect(selected != null ? items[selected ?? 0].id : null);
        },
        isSelected: i == selected,
      ));
    }
    return widgets;
  }
}

class _Item extends StatelessWidget {
  final ItemData data;
  final Function() onSelect;
  final bool isSelected;
  final double x, y;

  const _Item(
      {required this.data,
      required this.onSelect,
      this.isSelected = false,
      required this.x,
      required this.y});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: data.dx + x,
      top: data.dy + y,
      child: GestureDetector(
        onTap: onSelect,
        child: RotatedBox(
          quarterTurns: data.dr,
          child: Slot(
            id: data.id ?? '',
            isSelected: isSelected,
          ),
        ),
      ),
    );
  }
}
