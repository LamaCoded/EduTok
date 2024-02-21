import 'package:get/get.dart';
import 'package:flutter/material.dart';

class pageControllerx extends GetxController {
  final PageController pageControl = new PageController(initialPage: 0);
  RxInt index = 0.obs;
}
