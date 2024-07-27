import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

refreshLoading(BuildContext context, {Color? color}) => WaterDropHeader(
      waterDropColor: Theme.of(context).primaryColor,
      complete: Text(
        "Refresh Completed",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      refresh: CupertinoActivityIndicator(
        color: color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white),
        radius: 10.w,
      ),
    );

var customFooter = CustomFooter(
  builder: (context, mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = Text(
        "Pull up load",
        style: Theme.of(context).textTheme.titleMedium,
      );
    } else if (mode == LoadStatus.loading) {
      body = const CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = Text(
        "Load Failed!Click retry!",
        style: Theme.of(context).textTheme.labelMedium,
      );
    } else if (mode == LoadStatus.canLoading) {
      body = Text(
        "release to load more",
        style: Theme.of(context).textTheme.labelMedium,
      );
    } else {
      body = Text(
        "No more Data",
        style: Theme.of(context).textTheme.labelMedium,
      );
    }
    return SizedBox(
      height: 55.h,
      child: Center(child: body),
    );
  },
);
