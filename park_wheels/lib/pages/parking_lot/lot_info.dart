import 'package:flutter/material.dart';
import 'package:park_wheels/pages/booking/booking.dart';
import 'package:park_wheels/utils/location/map_utils.dart';
import 'package:park_wheels/utils/style.dart';
import 'package:sizer/sizer.dart';

import '../../models/lot.dart';

class LotInfo extends StatelessWidget {
  final Lot lot;

  const LotInfo({Key? key, required this.lot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 35.h,
                color: Colors.grey,
                child: Image.asset(
                  "assets/background/parking_lot.jpg",
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
              top: 25,
              left: 0,
              child: BackButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              )),
          Positioned(
              top: 25.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 25, top: 15),
                      child: ListTile(
                        title: Text(
                          lot.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          lot.address,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.map,
                            color: Style.primary,
                          ),
                          onPressed: () async {
                            await MapUtils.openMap(
                                lot.location.latitude, lot.location.longitude);
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                        endIndent: 15,
                        indent: 15,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur feugiat volutpat sapien, et porta orci molestie ut. Sed risus purus, porta blandit dolor euismod, consectetur eleifend ex. In leo lorem, gravida malesuada gravida quis, scelerisque a est. Sed ac tristique orci. Nunc ac felis eu sapien imperdiet feugiat. In rhoncus nisl eget diam auctor laoreet. Donec sed sagittis urna. Ut aliquet non enim vestibulum semper.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
      persistentFooterButtons: [
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Style.green),
              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
              minimumSize: MaterialStateProperty.all(Size.infinite),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BookingPage(lot: lot)));
            },
            child: const Text(
              "Book Slot",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
