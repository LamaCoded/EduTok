import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screen/homeScreen.dart';
import 'Screen/splashScreen.dart';
import 'package:edutok/Screen/NoInternetScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 44, 43, 43),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 63, 62, 63),
        // ···
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
    routes: {},
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _navigateApp();
  }

  Widget build(BuildContext context) {
    return Scaffold(body: Splash());
  }

  void _navigateApp() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});

    Get.off(homeScreen());
  }

  Future<bool> checkConnectivity(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.wifi ||
        connectivityResult != ConnectivityResult.mobile) {
      return false;
    } else {
      return true;
    }
  }
}
