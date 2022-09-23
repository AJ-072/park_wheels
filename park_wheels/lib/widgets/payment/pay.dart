import 'package:flutter/material.dart';
import 'package:park_wheels/utils/style.dart';

class PayButton extends StatelessWidget {
  Function() onPressed;

  PayButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Style.primary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/google_pay.png',
                  height: 30,
                )),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down))
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: 62,
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Style.green),
                  padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                  minimumSize: MaterialStateProperty.all(Size.infinite),
                ),
                onPressed: onPressed,
                child: const Text(
                  "Pay Now",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        )
      ],
    );
  }
}
