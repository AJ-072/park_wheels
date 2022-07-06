import 'package:flutter/material.dart';

class FullPageLoadingBar extends StatelessWidget {
  const FullPageLoadingBar({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.black26,
      child: Container(
        height: 48,
        width: 48,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
