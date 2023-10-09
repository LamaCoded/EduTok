import 'package:video_player/video_player.dart';

class VideoModel {
  final String assetPath;
  late VideoPlayerController controller;

  VideoModel({required this.assetPath});
}
