// import 'package:camera/camera.dart';
// import 'package:get/get.dart';

// import 'package:camera/camera.dart';
// import 'package:get/get.dart';

// class CustomCameraController extends GetxController {
//   late CameraController _controller;

//   CustomCameraController(
//       CameraDescription cameraDescription, ResolutionPreset resolutionPreset) {
//     _controller = CameraController(cameraDescription, resolutionPreset);
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       await _controller.initialize();
//       if (_controller.value.isInitialized) {
//         update(); // Notify listeners about the change
//       }
//     } catch (e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     }
//   }

//   CameraController get controller => _controller;

//   @override
//   void onClose() {
//     _controller.dispose();
//     super.onClose();
//   }
// }
