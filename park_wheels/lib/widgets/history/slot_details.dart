import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:park_wheels/models/booking.dart';
import 'package:park_wheels/utils/location/map_utils.dart';
import 'package:park_wheels/utils/style.dart';
import 'package:sizer/sizer.dart';

import '../../models/lot.dart';

class SlotDetails extends StatelessWidget {
  final Lot lot;
  final Booking booking;

  const SlotDetails({Key? key, required this.lot, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        onPressed: () {
                          MapUtils.openMap(
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Text(
                          "Slot ",
                          style: TextStyle(fontSize: 18),
                        )),
                        Expanded(
                            child: Text(
                          ": ${booking.slot}",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Text(
                          "Booked Date ",
                          style: TextStyle(fontSize: 18),
                        )),
                        Expanded(
                            child: Text(
                          ": ${DateFormat("dd/MM/yyyy").format(booking.bookedTime)}",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            child: Text(
                          "Booked Time ",
                          style: TextStyle(fontSize: 18),
                        )),
                        Expanded(
                            child: Text(
                          ": ${DateFormat("hh:mm a").format(booking.bookedTime)}",
                          style: TextStyle(fontSize: 18),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              child: Text(
                            "Cost ",
                            style: TextStyle(fontSize: 18),
                          )),
                          Expanded(
                              child: Text(
                            ": ${booking.cost.toString()}\$",
                            style: TextStyle(fontSize: 18),
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ))
      ],
    );
  }
}
