
import 'package:flutter/material.dart';
import '../../widgets/home/nav_bar.dart';
import 'dashboard.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>HomeState();
}

class HomeState extends State<Home> {

  Widget body = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body,
        bottomNavigationBar: NavBar(onTab: (body)=>setState((){
          this.body = body;
        }),)
    );
  }

  Widget dashCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: child,
      ),
    );
  }
}
