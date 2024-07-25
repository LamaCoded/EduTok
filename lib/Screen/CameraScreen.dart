import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../customComponent/upload/cameraApiCall.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraApiCall(),
    );
  }
}
