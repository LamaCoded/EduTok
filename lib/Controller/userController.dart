import 'dart:convert';
import 'dart:io';

import 'package:edutok/Controller/StateController/LoginStateController.dart';
import 'package:edutok/Screen/CameraScreen.dart';
import 'package:edutok/Screen/homeScreen.dart';
import 'package:edutok/Screen/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:edutok/Screen/Profile.dart';
import 'package:get/get_connect/sockets/src/sockets_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/Path.dart';

class UserController {
  final LoginStateController loginController = Get.put(LoginStateController());
  final dio = new Dio();

  String? email;
  String? password;
  String? age;
  String? username;

  login(TextEditingController emailTextController,
      TextEditingController passwordTextController) async {
    email = emailTextController.text;
    password = passwordTextController.text;
    print('chiryo');
    try {
      dynamic response = await dio.post('http://${basepath}:4000/login',
          data: {'user_id': email, 'password': password});
      print(response.data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = response.data;
      await prefs.setString('token', data['accessToken']);
      await prefs.setString('userId', data['user_id']);
      await prefs.setInt('isPrivate', data['private']);

      if (prefs.getString('token') != null &&
          prefs.getString('userId') != null) {
        loginController.loginStateUpdate();
        loginController.loginState == true
            ? Get.to(Profile())
            : Get.dialog(AlertDialog(title: Text("try again")));
      }
    } catch (e) {
      if (e is SocketException) {
        Get.off(Login());
      }
      Get.dialog(
        AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  Registration(
      TextEditingController emailTextController,
      TextEditingController passwordTextController,
      TextEditingController ageTextController,
      TextEditingController userController) async {
    email = emailTextController.text;
    password = passwordTextController.text;
    age = ageTextController.text;
    username = userController.text;
    try {
      dynamic response = await dio.post(
        'http://${basepath}:4000/register',
        data: {
          'user_id': email,
          'password': password,
          'age': age,
          'username': username
        },
      );
      print("Response: $response");

      Get.off(homeScreen());
    } catch (e) {
      print('is: $e'); // Print the error for debugging
      if (e is DioException) {
        printError();
        print("eroor: $e");
        Get.dialog(
          AlertDialog(
              title: Text(e.toString()),
              content: Text('The server is not reachable.')),
        );
      } else {
        // Handle other types of exceptions if needed
      }
    }
  }
}
