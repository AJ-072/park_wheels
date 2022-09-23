import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:park_wheels/pages/booking/booking.dart';
import 'package:park_wheels/pages/location/location.dart';
import 'package:park_wheels/pages/parking_lot/lot_info.dart';
import 'package:park_wheels/service/location.dart';
import 'package:park_wheels/service/parking_lot_service.dart';
import 'package:park_wheels/utils/style.dart';
import 'package:park_wheels/widgets/common/dropdown_button.dart';
import 'package:park_wheels/widgets/common/loading.dart';
import 'package:park_wheels/widgets/dashboard/item.dart';
import 'package:park_wheels/widgets/dashboard/location.dart';
import 'package:park_wheels/widgets/dashboard/text_with_sufix_button.dart';

import '../../models/lot.dart';
import '../error_page.dart';

class Dashboard extends StatefulWidget {
  static String name = 'Park Wheels';

  Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashBroadState();
}

class DashBroadState extends State<Dashboard> {
  GeoPoint? position;

  @override
  void initState() {
    determinePosition().then((value) {
      if (mounted)
        setState(() => position =
            GeoPoint(latitude: value.latitude, longitude: value.longitude));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("${position?.latitude} ${position?.longitude}");
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: LocationSelector(
                  onTap: () {
                    Navigator.push<GeoPoint?>(context,
                            MaterialPageRoute(builder: (_) => SetLocation()))
                        .then((value) => value != null
                            ? setState(() => position = value)
                            : null);
                  },
                  point: position),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextWithSufixButton(
                onSubmit: (value) {},
                icon: const Icon(Icons.search_outlined, color: Colors.grey),
                hint: "Parking Area Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Style.primary),
                      // child: Text(
                      //   'sort ⌄',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, color: Colors.white),
                      // ),
                      child: DropDown(),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Style.primary),
                      child: Text(
                        'Near me',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: FirestoreListView<Lot>(
              physics: const BouncingScrollPhysics(),
              pageSize: 10,
              query: LotService.get(),
              itemBuilder: (context, lot) => LotItemWidget(
                lot: lot.data(),
                onTab: (lot) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LotInfo(lot: lot))),
                onSubmit: (lot) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => BookingPage(lot: lot))),
              ),
              errorBuilder: (_, __, ___) => ErrorPage(() => setState(() {})),
              loadingBuilder: (_) => FullPageLoadingBar(),
            ))
          ],
        ),
      ),
    );
  }
}
