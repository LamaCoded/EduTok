import 'package:dio/dio.dart';
import 'package:edutok/Screen/homeScreen.dart';
import 'package:edutok/Screen/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/Path.dart';

class LoginStateController extends GetxController {
  RxBool loginState = false.obs;
  RxBool Liked = false.obs;

  void loginStateUpdate() {
    loginState.value =
        !loginState.value; // Fixed the variable name to 'loginState'
  }

  void likedStateUpdate() async {
    final dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    try {
      dio.options.headers["Authorization"] = 'Bearer $token';
      dynamic response = await dio
          .put('http://${basepath}:4000/like', data: {'video_id': 25397});
      print(response.data);
      Liked.value = !Liked.value;
    } catch (e) {
      print(e);
    }
    // Fixed the variable name to 'loginState'
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    loginState.value = !loginState.value;
    Get.offAll(Login());
  }
}
