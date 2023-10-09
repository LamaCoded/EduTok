import 'package:edutok/Data/Path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../Model/videoModel.dart';

class VideoController extends GetxController {
  List<VideoModel> videos = [
    VideoModel(
        assetPath:
            'http://${basepath}:4000/static/video/videoca887ed5ff5ac65b0433ef67054d.mp4')
    // VideoModel(assetPath: 'videos/Download.mp4'),
    // VideoModel(assetPath: 'videos/Downloadone.mp4'),
    // VideoModel(assetPath: 'videos/Downloadtwo.mp4'),
    // VideoModel(assetPath: 'videos/Downloadthree.mp4'),
  ];
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    initializeVideoControllers();
  }

  void initializeVideoControllers() async {
    for (var video in videos) {
      video.controller =
          VideoPlayerController.networkUrl(Uri.parse(video.assetPath))
            ..setLooping(true);
      await video.controller.initialize();
    }
    // Start playing the first video
    videos[currentIndex.value].controller.play();
  }

  void playNextVideo() {
    if (currentIndex.value < videos.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0;
    }
    videos[currentIndex.value].controller.seekTo(Duration.zero);
    videos[currentIndex.value].controller.play();
  }

  void playVideoAt(int index) {
    currentIndex.value = index;
    videos[currentIndex.value].controller.seekTo(Duration.zero);
    videos[currentIndex.value].controller.play();
  }

  void playCurrentVideo() {
    videos[currentIndex.value].controller.seekTo(Duration.zero);
    videos[currentIndex.value].controller.play();
  }

  void pauseCurrentVideo() {
    videos[currentIndex.value].controller.pause();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance?.removeObserver(this as WidgetsBindingObserver);
    for (var video in videos) {
      video.controller.dispose();
    }
  }
}
