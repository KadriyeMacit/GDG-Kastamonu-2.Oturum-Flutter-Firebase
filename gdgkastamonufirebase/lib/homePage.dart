import 'dart:io';

import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:gdgkastamonufirebase/firstPage.dart';
import 'package:gdgkastamonufirebase/addPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedPos = 0;
  double bottomNavBarHeight = 60;


  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Anasayfa", Colors.red,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
    TabItem(Icons.add_circle_outline_rounded, "Ekle", Colors.red,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
    TabItem(Icons.person, "Profil", Colors.red,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
  ]);

  CircularBottomNavigationController _navigationController;


  @override
  void initState() {
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            child: bodyContainer(),
          ),

          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );

  }

  // ------------------------------------------------------------------------------------------------------------------------

  Widget bodyContainer() {
    switch (selectedPos) {
      case 0:
        return FirstPage();
        break;
      case 1:
        return YemekSayfasi();
        break;
      case 2:
        return profileScreen();
        break;
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }


  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }







  profileScreen()
  {

  }

}
