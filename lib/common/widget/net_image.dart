import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/image_const.dart';
import 'package:football_fever/common/widget/loading_widget.dart';

class NetImageView extends StatelessWidget {
  final String url;
  final String? type;
  final double? height;
  final double? width;
  final double? progressIndicatorRadius;
  final BoxFit fit;
  final Widget? loading;
  final Color? indicatorColor;

  const NetImageView(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.progressIndicatorRadius,
      this.loading,
      this.type,
      this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          loading ?? LoadingWidget(size: height ?? 20.h),
      errorWidget: (context, url, error) => Image.asset(
        appNameLogo,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
