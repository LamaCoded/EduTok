import 'package:edutok/Screen/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Screen/Profile.dart';
import 'package:edutok/customComponent/homeScreen/contentView.dart';
import '../Controller/Tabcontrol.dart';
import '../Controller/VideoController/videoController.dart';
import '../customComponent/global/BottomNav.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class homeScreen extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                  size: 34,
                ),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                )
              ],
              backgroundColor: Colors.transparent,
              title: Text(
                "EduTok",
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
            ),
          ),
          body: ContentView(),
          bottomNavigationBar: Obx(() => ButtomNav(context))),
    );
  }
}
