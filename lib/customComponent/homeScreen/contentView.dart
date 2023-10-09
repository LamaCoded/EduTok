import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Data/userData.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/VideoController/videoController.dart';
import '../Video/videoWidget.dart';
import '../../Model/videoModel.dart';

class ContentView extends StatelessWidget {
  final VideoController videoController = Get.find<VideoController>();
  void initState() {
    WidgetsBinding.instance?.addObserver(this as WidgetsBindingObserver);
  }

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
    return PageView.builder(
      onPageChanged: (int currentPageIndex) {
        videoController.playVideoAt(currentPageIndex);
      },
      scrollDirection: Axis.vertical,
      itemCount: videoController.videos.length,
      itemBuilder: (context, index) {
        return VideoWidget(
          video: videoController.videos[index],
          currentIndex: index,
        );
      },
    );
  }
}

//VideoWidget(video: videoController.videos[index])