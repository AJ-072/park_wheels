import 'package:flutter/material.dart';

enum Status { booked, parked, available }

enum Type { electric, ordinary }

class Slot extends StatelessWidget {
  final double _ratio = 0.5;
  final double _width = 130;
  final double scale;
  final bool isSelected;

  final Widget? child;
  final String id;

  Slot(
      {Key? key,
      this.child,
      required this.id,
      this.scale = 1,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: (_width * _ratio) * scale,
        width: _width * scale,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade200 : Colors.grey.shade200,
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                id,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            child ?? Container(),
          ],
        ));
  }

  static Widget _car({required bool isElectric, required bool isParked}) {
    return Image.asset(
      'assets/icons/cars/${isParked ? '' : 'booked_'}${isElectric ? 'electric_' : ''}car.png',
      frameBuilder: (context, child, frame, _) {
        return Padding(
          padding: const EdgeInsets.all(3),
          child: child,
        );
      },
    );
  }

  static Widget car({required status, required type}) {
    return status == Status.available
        ? Container()
        : _car(
            isElectric: type == Type.electric,
            isParked: status == Status.parked);
  }
}
