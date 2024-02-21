import 'package:dio/dio.dart';
import 'package:edutok/Data/Path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Data/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/VideoController/videoController.dart';
import '../Video/videoWidget.dart';
import '../../Model/videoModel.dart';

class ContentView extends StatelessWidget {
  final VideoController videoController = Get.find<VideoController>();

  final PageController _pageController = PageController();

  void initState() {
    WidgetsBinding.instance?.addObserver(this as WidgetsBindingObserver);
    // _pageController.addListener(_onPageViewScroll);
  }

  // void fetchNewData() async {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("**************************");
    print(state);
    print("**************************");

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      videoController.pauseCurrentVideo();
    } else if (state == AppLifecycleState.resumed) {
      videoController.playCurrentVideo();
    } else {
      print("**************************");
      print(state);
      print("**************************");
    }
  }

  @override
  void dispose() {
    videoController.pauseCurrentVideo();

    // WidgetsBinding.instance?.removeObserver(this as WidgetsBindingObserver);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PageView.builder(
          controller: _pageController,
          itemCount: videoController.videos.length,
          onPageChanged: (int currentPageIndex) async {
            if (currentPageIndex == videoController.videos.length - 1) {
              // Get.dialog(AlertDialog(content: Text("reached")));
              await videoController.addModel();
              // videoController.videos.refresh();

              // videoController.update();
              // print("00000000000000000000");
              // print(videoController.videos.length);
              // print("00000000000000000000");
            }
          },
          scrollDirection: Axis.vertical,
          // itemCount: videoController.videos.length,
          itemBuilder: (context, index) {
            return VideoWidget(
              video: videoController.videos[index],
              currentIndex: index,
            );
          },
        ));
  }
}

//VideoWidget(video: videoController.videos[index])