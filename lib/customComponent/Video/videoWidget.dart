import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutok/Controller/StateController/LoginStateController.dart';
import 'package:edutok/Controller/VideoController/videoController.dart';
import 'package:video_player/video_player.dart';

import '../../Model/videoModel.dart';

class VideoWidget extends StatelessWidget {
  final VideoModel video;
  final int currentIndex;
  final VideoController videoController = Get.find<VideoController>();
  final LoginStateController likeState = Get.find<LoginStateController>();

  VideoWidget({required this.video, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return video.controller != null
        ? AspectRatio(
            aspectRatio: 9.0 / 17.4,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                video.controller != null
                    ? GestureDetector(
                        onDoubleTap: () => likeState.likedStateUpdate(),
                        child: VideoPlayer(
                          video.controller!,
                        ),
                        onTap: () {
                          video.controller!.value.isPlaying
                              ? video.controller!.pause()
                              : video.controller!.play();
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                VideoProgressIndicator(
                  video.controller!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    backgroundColor: const Color.fromARGB(255, 5, 5, 5),
                    playedColor: const Color.fromARGB(255, 255, 255, 255),
                    bufferedColor: Color.fromARGB(255, 192, 192, 192),
                  ),
                ),
                Positioned(
                    bottom: 380,
                    right: 8,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/Tabloid.png'),
                      radius: 25,
                    )),
                Positioned(
                  bottom: 300.0,
                  right: 10,
                  child: Container(
                    child: Column(
                      children: [
                        Obx(
                          () => IconButton(
                            icon: Icon(
                              likeState.Liked.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: likeState.Liked.value
                                  ? Colors.red
                                  : Colors.white,
                              size: 40,
                            ),
                            onPressed: () => likeState.likedStateUpdate(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 250.0,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: null,
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  left: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        child: Text(
                          video.videoTitle,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        onPressed: null,
                      ),
                      Text(video.videoID)
                    ],
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
