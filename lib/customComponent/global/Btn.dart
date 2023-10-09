import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:edutok/Screen/Profile.dart';

import '../../Controller/StateController/LoginStateController.dart';

final LoginStateController loginState = Get.find<LoginStateController>();

Widget Btn(String text, Function func) {
  return SizedBox(
    width: 150,
    child: ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(10, 5, 10, 5))),
      onPressed: () =>
          // loginState.loginStateUpdate();
          func()
      // print(loginState.loginState.value);
      ,
      child: Text(text),
    ),
  );
}
