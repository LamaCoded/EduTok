import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SampleItem { setting }

class PopupMenuController extends GetxController {
  Rx<SampleItem?> selectedMenu = Rx<SampleItem?>(null);

  void setSelectedMenu(SampleItem item) {
    selectedMenu.value = item;
  }
}
