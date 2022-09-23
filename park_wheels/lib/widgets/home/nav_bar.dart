import 'package:flutter/material.dart';
import 'package:park_wheels/pages/home/history.dart';
import 'package:park_wheels/utils/style.dart';

import '../../pages/home/dashboard.dart';
import '../../pages/home/profile.dart';

class NavBar extends StatefulWidget {
  final Function(Widget) onTab;

  const NavBar({Key? key, required this.onTab}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int currentIndex = 0;

  final pages = [
    Dashboard(),
    History(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Style.primary,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home/parking_sign.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/icons/home/parking_sign_selected.png',
              height: 24,
              width: 24,
            ),
            label: 'Near Me'),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.list_alt_outlined,
              color: Style.primary,
            ),
            label: 'History'),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.account_circle_rounded,
              color: Style.primary,
            ),
            label: 'Profile')
      ],
      onTap: (i) {
        setState(() => currentIndex = i);
        widget.onTab(pages[i]);
      },
    );
  }
}
