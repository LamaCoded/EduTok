import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Controller/profileTabController/creatorController.dart';
import 'package:edutok/customComponent/profile/videoGrid.dart';

import '../../Data/Path.dart';

class yourVideos extends StatefulWidget {
  const yourVideos({Key? key});

  @override
  State<yourVideos> createState() => _yourVideosState();
}

class _yourVideosState extends State<yourVideos>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final customTab = Get.put(creatorTabs());
  int tabData = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      tabData = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              // Add Expanded widget here
              child: Column(
                children: [
                  TabBar(
                    tabs: customTab.MyTabs,
                    controller: _tabController,
                    onTap: onTabTapped,
                  ),
                  Expanded(
                    // Add Expanded widget here
                    child: TabBarView(
                      children: [
                        videoGrid(context, tabData),
                        videoGrid(context, tabData)
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
