
import 'package:flutter/material.dart';
import 'package:park_wheels/pages/home/history.dart';

import '../../pages/home/dashboard.dart';
import '../../pages/home/parking_lots.dart';
import '../../pages/home/profile.dart';


class NavBar extends StatefulWidget{
  final Function(Widget) onTab;

  const NavBar({Key? key, required this.onTab}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>NavBarState();

}
class NavBarState extends State<NavBar>{
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/home/dashboard.png',height: 24,width: 24,),
          activeIcon: Image.asset('assets/icons/home/dashboard_selected.png',height: 24,width: 24,),
          label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home/parking_sign.png',height: 24,width: 24,),
            activeIcon: Image.asset('assets/icons/home/parking_sign_selected.png',height: 24,width: 24,),
            label: 'Lots'
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined,color: Colors.black,),
            activeIcon: Icon(Icons.list_alt_outlined,color: Colors.blue,),
            label: 'Bookings'
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined,color: Colors.black,),
            activeIcon: Icon(Icons.account_circle_rounded,color: Colors.blue,),
            label: 'Profile'
        )
      ],
      onTap: (i) {
        setState(()=>currentIndex = i);
        switch(i){
          case 0:
            widget.onTab(Dashboard());
            break;
          case 1:
            widget.onTab(const Lots());
            break;
          case 2:
            widget.onTab(const History());
            break;
          case 3:
            widget.onTab(Profile());
            break;
        }
      },
    );
  }
  
}