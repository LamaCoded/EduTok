import 'package:dio/dio.dart';
import 'package:edutok/Data/Path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../Model/videoModel.dart';

class VideoController extends GetxController {
  RxList videos = [].obs;
  RxInt currentIndex = 0.obs;
  // void getVideo() async {
  //   final Dio dio = new Dio();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   dio.options.headers["Authorization"] = "Bearer ${token}";
  //   try {
  //     dynamic response = await dio.post('http://${basepath}:4000/videoget');
  //     print(response.data);
  //     for (int i = 0; i < response.data.length; i++) {
  //       String orginalTitle = response.data[i]['orginal_title'];
  //       String id = response.data[i]['id'];
  //       videos.add(VideoModel(videoID: id, videoTitle: orginalTitle));
  //     }
  //     print("888888888888888888888");
  //     print(response.data);
  //     print("888888888888888888888");
  //   } catch (e) {
  //     Get.dialog(AlertDialog(
  //       title: Text("main"),
  //       content: Text(e.toString()),
  //     ));
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    videos.value.add(VideoModel(videoID: "123", videoTitle: "Star Wars"));
    videos.value.add(VideoModel(videoID: "123", videoTitle: "Star Wars"));

    initializeVideoControllers();

    // getVideo();
  }

  void initializeVideoControllers() async {
    List<VideoModel> tempVideos = List.from(videos);
    for (var video in tempVideos) {
      VideoPlayerController controller =
          VideoPlayerController.asset('videos/Download.mp4')..setLooping(true);
      video.controller = controller;
      try {
        await video.controller!.initialize();
      } catch (e) {
        Get.dialog(AlertDialog(
          content: Text("fetching error"),
        ));
      }
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

  Future<void> addModel() async {
    print("=============================================");
    print("=============================================");

    print("entered add model");
    print("=============================================");

    print("=============================================");

    videos.value.add(
      VideoModel(videoID: "435", videoTitle: "Ttile"),
    );
    videos.value.add(
      VideoModel(videoID: "435", videoTitle: "Ttile"),
    );
    videos.value.add(
      VideoModel(videoID: "435", videoTitle: "Ttile"),
    );
    videos.value.add(
      VideoModel(videoID: "435", videoTitle: "Ttile"),
    );
    videos.refresh();
    await reinitializeVideoControllers();
  }

  Future<void> reinitializeVideoControllers() async {
    List<VideoModel> tempVideos = List.from(videos);
    for (var video in tempVideos) {
      if (video.controller != null) {
        await video.controller!.dispose();
        // Get.dialog(AlertDialog(
        //   content: Text("disposed"),
        // ));
      }
      VideoPlayerController controller =
          VideoPlayerController.asset('videos/Download.mp4')..setLooping(true);
      video.controller = controller;
      try {
        await video.controller!.initialize();
      } catch (e) {
        // Get.dialog(AlertDialog(
        //   content: Text("Error reinitializing video"),
        // ));
        print(e);
      }
    }
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
