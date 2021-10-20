import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BottomMenu extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int> onClicked;
  BottomMenu({this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onClicked,
      backgroundColor: Color(0xFFF0EEF5),
      selectedItemColor: Color(0xFF9378FF),
      unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline_rounded),
          label: 'Entreprises',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Profil',
        ),
      ],
    );
  }
}