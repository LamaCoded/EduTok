import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/StateController/LoginStateController.dart';
import '../../Controller/Tabcontrol.dart';
import '../../Screen/Profile.dart';
import '../../Screen/homeScreen.dart';
import '../../Screen/login.dart';
import '../../Screen/CameraScreen.dart';

Widget ButtomNav(BuildContext context) {
  // Obtain shared preferences.

  final Tabcontrol tabController = Get.put(Tabcontrol());
  final LoginStateController isLogged = Get.put(LoginStateController());
  return BottomNavigationBar(
    backgroundColor: Theme.of(context).primaryColor,
    onTap: (i) async {
      tabController.increment(i);
      if (i == 0) {
        Get.to(homeScreen());
      } else if (i == 1) {
        Get.to(CameraScreen());
      }
      if (i == 2) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString('token') != null &&
            prefs.getString('token') != "") {
          Get.to(Profile());
        } else {
          Get.to(Login());
        }
      }
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.add), label: "upload"),
      BottomNavigationBarItem(
        icon: Icon(Icons.man_2_rounded),
        label: "profile",
      )
    ],
    currentIndex: tabController.index.toInt(),
  );
}
