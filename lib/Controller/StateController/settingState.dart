import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Data/Path.dart';

class settingState extends GetxController {
  RxBool deleteAccountState = false.obs;
  int? isPrivate;
  RxBool changeToPrivateState = false.obs;

  void updateDeleteAccountState() {
    deleteAccountState.value = !deleteAccountState.value;
  }

  void updateChangeToPrivateState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final dio = new Dio();
    try {
      String token = prefs.getString('token')!;

      changeToPrivateState.value = !changeToPrivateState.value;
      dio.options.headers['Authorization'] = 'Bearer ${token}';
      dynamic response = await dio.post('http://${basepath}:4000/private');
      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
