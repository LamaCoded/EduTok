import 'package:edutok/Controller/StateController/settingState.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget customSetting(
  IconData leadingIcon,
  String title,
  Function func, [
  IconData? trailing,
  String? subtitle,
]) {
  // Provide a default value for subtitle
  final settingState settingStateController = Get.put(settingState());
  return ListTile(
      leading: Icon(leadingIcon),
      onTap: () => func(),
      title: Text(title),
      subtitle: subtitle == null
          ? Text("")
          : Text(subtitle), // Use the provided subtitle parameter here
      trailing: trailing != null
          ? Icon(trailing)
          : Obx(
              () => Switch(
                  value: settingStateController.changeToPrivateState.value,
                  onChanged: (value) {
                    settingStateController.updateChangeToPrivateState();
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.red),
            ));
}
