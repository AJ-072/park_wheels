import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget{
  String label;
  Function? onClick;
  SubmitButton(this.label, {Key? key,this.onClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFFfbab66),
          ),
          BoxShadow(
            color: Color(0xFFf7418c),
          ),
        ],
        gradient: LinearGradient(
            colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
            begin: FractionalOffset(0.2, 0.2),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: const Color(0xFFf7418c),
          onPressed: onClick!(),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: "WorkSansBold"),
            ),
          )),
    );
  }
  
}