import 'package:flutter/material.dart';

import '../../models/lot.dart';
import '../../widgets/home/circular_dropdown.dart';

class Dashboard extends StatelessWidget {
  static String name = 'Park Wheels Partner';

  Dashboard({Key? key}) : super(key: key);
  final List data = [Lot(id: '1', name: name), Lot(id: '2', name: "name")];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        AppBar(
          title: CircularDropDown(
            data: data,
            onChange: onLotChange,
            width: size.width / 2.2,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  onLotChange(Lot lot) {}
}
