import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:park_wheels/models/lot.dart';
import 'package:park_wheels/service/booking_service.dart';
import 'package:park_wheels/widgets/history/slot_details.dart';
import 'package:park_wheels/widgets/payment/pay.dart';

import '../../models/booking.dart';

class PaymentPage extends StatefulWidget {
  final Lot lot;
  final Booking booking;

  const PaymentPage({
    Key? key,
    required this.lot,
    required this.booking,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  PaymentPageState({TimeOfDay? timeOfDay, DateTime? dateTime}) {
    this.timeOfDay = timeOfDay ?? TimeOfDay.now();
    this.dateTime = dateTime ?? DateTime.now();
  }

  late DateTime dateTime;
  late TimeOfDay timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlotDetails(lot: widget.lot, booking: widget.booking),
        persistentFooterButtons: [
          PayButton(
            onPressed: () {
              widget.booking.status = Status.paid;
              BookingService.set(widget.booking).whenComplete(
                  () => Navigator.popUntil(context, (route) => route.isFirst));
            },
          )
        ]);
  }
}
