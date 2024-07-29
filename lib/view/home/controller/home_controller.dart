import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt homeBottomIndex = RxInt(0);
  PageController pageController = PageController(initialPage: 0);
}
