import 'package:edutok/Data/userData.dart';
import 'package:edutok/Screen/login.dart';
import 'package:edutok/Screen/updateScreen.dart';
import 'package:edutok/customComponent/setting/customSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/StateController/LoginStateController.dart';

class settingScreen extends StatelessWidget {
  UserData uData = UserData();

  settingScreen({Key? key}) : super(key: key);
  LoginStateController logController = Get.put(LoginStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduTOk'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            size: 35,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          children: [
            Text("Account"),
            customSetting(
              Icons.delete,
              "Delete Account",
              () {},
              Icons.warning,
            ),
            FutureBuilder(
              future: uData.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int isPrivate = snapshot.data?[2];
                  return customSetting(Icons.shield, "Make Account Private",
                      () {
                    // You can replace this with your logic to handle isPrivat
                  }, null, null, isPrivate);
                }
              },
            ),
            const Spacer(),
            Text("General"),
            customSetting(Icons.password, "Change Password", () {
              Get.to(upDateScreen());
            }, Icons.navigate_next),
            customSetting(Icons.person_2_outlined, "Change UserInfo", () {
              Get.to(upDateScreen());
            }, Icons.navigate_next),
            Expanded(child: Container()),
            customSetting(Icons.logout, "Logout", () {
              logController.logout();
            }, Icons.warning),
          ],
        ),
      ),
    );
  }
}
