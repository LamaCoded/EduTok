import 'package:edutok/Controller/VideoController/videoController.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoModel {
  // final String assetPath;
  final String videoTitle;
  final String videoID;
  VideoPlayerController? controller;

  VideoModel({required this.videoID, required this.videoTitle});
}
