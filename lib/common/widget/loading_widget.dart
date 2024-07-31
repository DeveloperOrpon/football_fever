import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? indicatorColor;
  const LoadingWidget({super.key, required this.size, this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: indicatorColor ?? Get.theme.primaryColor,
        size: size,
      ),
    );
  }
}
