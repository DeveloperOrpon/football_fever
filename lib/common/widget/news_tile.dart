import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';
import '../../utils/helper/helper_method.dart';
import '../model/news_res.dart';

class NewsTileList extends StatelessWidget {
  final NewsModel newsModel;

  const NewsTileList({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        height: Get.width > 600 ? 130.h : 120.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).secondaryHeaderColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Hero(
              tag: newsModel.image.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: NetImageView(
                  type: 'news',
                  url: newsModel.image.toString(),
                  width: 200.w,
                  height: Get.width > 600 ? 130.h : 120.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "${newsModel.title}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "${(newsModel.description)?.replaceAll(htmlExp, '')}",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ago ${secondToTimeDef(newsModel.publishDate ?? '0')} h',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}
