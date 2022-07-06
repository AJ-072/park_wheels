import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubmitButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;

  const SubmitButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.5,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child: TextButton(onPressed: onPressed, child: child),
    );
  }
}
