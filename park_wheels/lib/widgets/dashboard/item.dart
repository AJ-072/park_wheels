import 'package:flutter/material.dart';
import 'package:park_wheels/models/lot.dart';

class LotItemWidget extends StatelessWidget {
  final double imageHeight = 150;
  final Lot lot;

  Function(Lot)? onTab;
  Function(Lot)? onSubmit;

  LotItemWidget({Key? key, required this.lot,this.onTab,this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){if(onTab!=null)onTab!(lot);},
        child: Material(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          child: SizedBox(
            height: 220,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                        height: imageHeight,
                        child: Image.asset('assets/background/parking_lot.jpg',
                            fit: BoxFit.cover))),
                Positioned(
                    left: 5,
                    top: imageHeight - 30,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        '6km',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
                Positioned(
                    right: 5,
                    top: imageHeight - 30,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green),
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        '${lot.slots} slots left',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    top: imageHeight,
                    child: ListTile(
                      title: Text(
                        lot.name,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 18),
                      ),
                      subtitle: Text(
                        lot.address,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 14),
                      ),
                      trailing: GestureDetector(
                        onTap: (){if(onSubmit!=null)onSubmit!(lot);},
                        child: Image.asset(
                          'assets/icons/dashboard/navigation.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
