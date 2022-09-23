import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:park_wheels/models/lot.dart';
import 'package:park_wheels/pages/booking/payment.dart';
import 'package:park_wheels/pages/no_data_page.dart';
import 'package:park_wheels/service/slot_service.dart';
import 'package:park_wheels/widgets/dashboard/text_with_sufix_button.dart';
import 'package:park_wheels/widgets/payment/pay_now.dart';
import 'package:park_wheels/widgets/slot/slot_layout_page.dart';

import '../../main.dart';
import '../../models/booking.dart';
import '../../models/slot.dart';
import '../../service/auth.dart';

class BookingPage extends StatefulWidget {
  final Lot lot;
  final DateTime? dateTime;
  final TimeOfDay? timeOfDay;

  const BookingPage(
      {Key? key, required this.lot, this.dateTime, this.timeOfDay})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BookingState();
}

class BookingState extends State<BookingPage> {
  BookingState({TimeOfDay? timeOfDay, DateTime? dateTime}) {
    this.timeOfDay = timeOfDay ?? TimeOfDay.now();
    this.dateTime = dateTime ?? DateTime.now();
  }

  ValueNotifier<String?> slotNotifier = ValueNotifier(null);

  late DateTime dateTime;
  late TimeOfDay timeOfDay;

  Booking booking = Booking();

  @override
  void initState() {
    booking.lotID = widget.lot.id;
    booking.lotName = widget.lot.name;
    booking.lotAddress = widget.lot.address;
    booking.cost = widget.lot.slotPrice;
    booking.createdAt = DateTime.now();
    booking.clientID = getIt<Auth>().client?.id ?? "";
    booking.clientName = getIt<Auth>().client?.name ?? "";
    booking.clientEmail = getIt<Auth>().client?.email ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWithSufixButton(
                          onSubmit: (_) {
                            showDatePicker(
                                    context: context,
                                    initialDate: dateTime,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 30)))
                                .then((value) => setState(() =>
                                    value != null ? dateTime = value : null));
                          },
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          hint:
                              "${dateTime.year}-${dateTime.month}-${dateTime.day}"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWithSufixButton(
                          onSubmit: (_) {
                            showTimePicker(
                                    context: context,
                                    initialTime: timeOfDay,
                                    initialEntryMode: TimePickerEntryMode.input)
                                .then((value) => setState(() => (value != null)
                                    ? timeOfDay = value
                                    : null));
                          },
                          icon: const Icon(
                            Icons.timelapse,
                            color: Colors.grey,
                          ),
                          hint: timeOfDay.format(context)),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: FutureBuilder<QuerySnapshot<ItemData>>(
                      future: SlotService.get(widget.lot.id).get(),
                      builder: (context, snap) {
                        print(snap.data?.size);
                        if (snap.hasData) {
                          return SlotLayout(
                              items: snap.data?.docs
                                      .map((e) => e.data())
                                      .toList() ??
                                  [],
                              onSelect: (value) {
                                slotNotifier.value = value;
                              });
                        }
                        if (snap.hasError) {
                          return NoDataPage(() => setState(() {}));
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }))
            ],
          ),
        ),
        persistentFooterButtons: [
          ValueListenableBuilder<String?>(
              valueListenable: slotNotifier,
              builder: (_, value, __) {
                booking.slot = value ?? '';
                return PayNow(
                  slot: value ?? "",
                  amount: widget.lot.slotPrice,
                  onPress: () {
                    dateTime = DateUtils.dateOnly(dateTime);
                    dateTime = dateTime.add(Duration(
                        hours: timeOfDay.hour, minutes: timeOfDay.minute));
                    booking.bookedTime = dateTime;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PaymentPage(
                                lot: widget.lot, booking: booking)));
                  },
                );
              })
        ]);
  }
}
