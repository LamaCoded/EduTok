import 'package:edutok/Screen/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:edutok/Controller/popMenuController.dart';
import 'package:edutok/Controller/profileTabController/creatorController.dart';
import 'package:edutok/Screen/login.dart';
import 'package:edutok/customComponent/profile/creator.dart';
import 'package:edutok/customComponent/profile/profileImage.dart';
import 'package:get/get.dart';

import '../customComponent/global/BottomNav.dart';

class Profile extends StatelessWidget {
  bool isCreator = true;
  bool isAuthenticated = false;
  final add = Get.put(creatorTabs());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("Profile"),
            actions: [
              PopupMenuButton<SampleItem>(
                  onSelected: (SampleItem selectedValue) {
                print(selectedValue);
                if (selectedValue == SampleItem.setting) {
                  Get.to(settingScreen());
                }
              }, itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: SampleItem.setting,
                    child: Text("Settings"),
                  ),
                ];
              })
            ]),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileSection(),
                SizedBox(height: 20),
                Expanded(child: yourVideos())
              ],
            )),
        bottomNavigationBar: Obx(() => ButtomNav(context)));
  }
}
