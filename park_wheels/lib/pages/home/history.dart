import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:park_wheels/pages/no_data_page.dart';
import 'package:park_wheels/service/booking_service.dart';
import 'package:park_wheels/widgets/dashboard/text_with_sufix_button.dart';
import 'package:park_wheels/widgets/history/item.dart';

import '../../models/booking.dart';

class History extends StatefulWidget {
  static String name = 'Bookings';

  @override
  State<StatefulWidget> createState() => HistoryState();
}

class HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextWithSufixButton(
              onSubmit: (value) {},
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
              hint: "Parking Area name",
            ),
            FirestoreListView<Booking>(
                shrinkWrap: true,
                query: BookingService.get(),
                itemBuilder: (context, doc) {
                  print(doc.data().toMap());
                  return HistoryItemWidget(booking: doc.data());
                },
                physics: BouncingScrollPhysics(),
                loadingBuilder: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                errorBuilder: (_, __, ___) => NoDataPage(() => setState(() {})))
          ],
        ),
      ),
    ));
  }
}
