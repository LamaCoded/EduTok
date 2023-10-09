import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../Data/Path.dart';
import '../global/FormText.dart';

class VideoPlayerForPreview extends StatefulWidget {
  final String videoPath;
  final String filename;

  VideoPlayerForPreview(this.videoPath, this.filename);

  @override
  _VideoPlayerForPreviewState createState() => _VideoPlayerForPreviewState();
}

class _VideoPlayerForPreviewState extends State<VideoPlayerForPreview> {
  TextEditingController tagController = TextEditingController();
  TextEditingController overviewController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  late VideoPlayerController _controller;
  bool _isVideoLoaded = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        // Ensure the first frame is shown.
        setState(() {
          _isVideoLoaded = true;
        });
      });

    _controller.addListener(() {
      if (_controller.value.hasError) {
        print("VideoPlayer error: ${_controller.value.errorDescription}");
        // Handle the error here, e.g., show an error message.
      }
      if (_controller.value.isPlaying) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: _isVideoLoaded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon:
                              Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () {
                            if (_isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.replay),
                          onPressed: () {
                            _controller.seekTo(Duration.zero);
                            _controller.play();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () => OpenModel(),
                        )
                      ],
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> cleanupOldVideos() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync();

      // Sort files by modification timestamp (oldest to newest)
      files.sort(
          (a, b) => a.statSync().modified.compareTo(b.statSync().modified));

      // Specify the maximum number of videos to keep
      final maxVideosToKeep = 10;

      // Delete excess videos beyond the limit
      if (files.length > maxVideosToKeep) {
        for (var i = 0; i < files.length - maxVideosToKeep; i++) {
          if (files[i].statSync().type == FileSystemEntityType.file) {
            await files[i].delete();
          }
        }
      }

      print('Cleanup complete.');
    } catch (e) {
      print('Cleanup failed: $e');
    }
  }

  void OpenModel() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                child: Column(
                  children: [
                    FormText(false, "original_title", "original title", context,
                        titleController, Icons.child_care_sharp),
                    FormText(false, "overview", "overview", context,
                        overviewController, Icons.child_care_sharp),
                    FormText(false, "tagline", "tag line", context,
                        tagController, Icons.child_care_sharp),
                    TextButton(
                      onPressed: () => uploadFile(titleController.text,
                          overviewController.text, tagController.text),
                      child: Text("send"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> uploadFile(String title, String overview, String tagline) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('token')!;

    print("AccessToken:${accessToken}");

    print("VideoPath:${widget.videoPath}");

    try {
      String apiUrl = 'http://${basepath}:4000/newvideo';
      String original_title = title;
      String Overview = overview;
      String Tagline = tagline;

      dio.Dio dioInstance = dio.Dio();
      dioInstance.options.headers['Authorization'] = 'Bearer $accessToken';
      dio.FormData formData = dio.FormData.fromMap({
        'video': await dio.MultipartFile.fromFile(widget.videoPath,
            filename: widget.videoPath.split('/').last),
        'original_title': title,
        'overview': overview,
        'tagline': tagline,
      });

      dio.Response response = await dioInstance.post(apiUrl, data: formData);

      print('Response: ${response.data}');
    } catch (e) {
      Get.dialog(
        AlertDialog(
            title: Text(e.toString()),
            content: Text('The server is not reachable.')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    cleanupOldVideos();
  }
}
