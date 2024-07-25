import 'dart:io';

import 'package:camera/camera.dart';
import 'package:edutok/customComponent/upload/videoPreview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class CameraApiCall extends StatefulWidget {
  @override
  State<CameraApiCall> createState() => _CameraApiCallState();
}

class _CameraApiCallState extends State<CameraApiCall> {
  List<CameraDescription>? cameras;
  CameraController? cameraController;
  int selectedCameraIndex =
      0; // Add this variable to keep track of the selected camera
  bool isRecording = false;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    PermissionStatus status = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();
    if (status.isGranted && storageStatus.isGranted) {
      cameras = await availableCameras();
      _initializeController();
    }
  }

  void _initializeController() {
    if (cameras != null && cameras!.isNotEmpty) {
      cameraController = CameraController(
        cameras![selectedCameraIndex], // Initialize with the selected camera
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg, // Add this line for Android
      );

      cameraController!.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  void _toggleCamera() {
    if (cameras != null && cameras!.isNotEmpty) {
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
      cameraController!.dispose(); // Dispose the current controller
      _initializeController(); // Initialize the controller with the new camera
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController != null && cameraController!.value.isInitialized) {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CameraPreview(cameraController!),
          ),
          Positioned(
            bottom: 20,
            left: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: isRecording
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.white, width: 2.0))
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                padding: EdgeInsets.all(10.0),
              ),
              child: Icon(
                Icons.camera,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();

                final videoPath =
                    '${directory.path}/video_${DateTime.now()}.mp4';

                if (isRecording == false) {
                  await cameraController!.startVideoRecording().then((value) {
                    if (mounted) {
                      setState(() {});
                    }
                    Get.snackbar("Recording", "Recording at ${videoPath}");
                  });

                  setState(() {
                    isRecording = true;
                  });
                } else {
                  try {
                    XFile videofile =
                        await cameraController!.stopVideoRecording();
                    final File newFile = File(videofile.path);
                    await newFile.rename(videoPath);
                    setState(() {
                      isRecording = false;
                    });
                    Get.snackbar("Recorded", "saved at ${videoPath}");
                    Get.to(VideoPlayerForPreview(videoPath, videoPath));
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
          ),
          Positioned(
            right: 15,
            top: 50,
            child: IconButton(
              icon: Icon(
                Icons.cameraswitch_rounded,
                size: 30,
              ),
              onPressed: _toggleCamera,
            ),
          ),
          Positioned(
              left: 20,
              bottom: 40,
              child: IconButton(
                icon: Icon(
                  Icons.file_open,
                  size: 40,
                ),
                onPressed: () => getFile(),
              ))
        ],
      );
    }

    return Center(
      child: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.white)),
    );
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      print("******************");
      print(file.path);
      print(file.name);
      print(file.size);
      print(file.extension);
      print('****************');
      Get.to(VideoPlayerForPreview(file.path!, file.name));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
