import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/style.dart';

class TextWithSufixButton extends StatelessWidget {
  final void Function(String?) onSubmit;
  final Icon icon;
  final bool enabled;
  final String hint;
  String? value;

  TextWithSufixButton(
      {Key? key,
      required this.onSubmit,
      required this.icon,
      this.enabled = true,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Style.dimGrey),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  readOnly: enabled,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  decoration:
                      InputDecoration(hintText: hint, border: InputBorder.none),
                ),
              ),
            ),
            IconButton(onPressed: () => onSubmit(value), icon: icon)
          ],
        ),
      ),
    );
  }
}
