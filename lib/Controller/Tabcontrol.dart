import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabcontrol extends GetxController {
  RxInt index = 0.obs;
  void increment(i) {
    index.value = i;
  }
}
