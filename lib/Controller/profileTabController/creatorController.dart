import 'package:flutter/material.dart';
import 'package:get/get.dart';

class creatorTabs extends GetxController {
  late TabController Controller;
  final List<Tab> MyTabs = <Tab>[
    Tab(
      text: 'Uploaded',
    ),
    Tab(
      text: 'Liked',
    )
  ];
  @override
  void onInit() {
    super.onInit();
    // Add any initialization logic here
  }

  @override
  void onClose() {
    // Add any cleanup or resource release logic here
    super.onClose();
  }
}
