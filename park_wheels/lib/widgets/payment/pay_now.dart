import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/style.dart';

class PayNow extends StatelessWidget {
  final String slot;
  final double amount;
  final Function() onPress;

  const PayNow(
      {Key? key,
      required this.slot,
      required this.amount,
      required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Slot Selected : $slot",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, thickness: 2),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Style.primary),
                  child: Text(
                    "$amount\$",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 62,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Style.green),
                        padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                        minimumSize: MaterialStateProperty.all(Size.infinite),
                      ),
                      onPressed: onPress,
                      child: const Text(
                        "Pay Now",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
