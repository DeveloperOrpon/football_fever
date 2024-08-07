import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/news_res.dart';
import 'package:football_fever/common/widget/news_first_tile.dart';
import 'package:football_fever/common/widget/news_tile.dart';
import 'package:get/get.dart';

import '../controller/news_controller.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Get.theme.primaryColor,
            indicatorWeight: 1,
            labelStyle: Get.theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: Get.width > 600 ? 14.sp : null,
            ),
            unselectedLabelStyle: Get.theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: Get.theme.disabledColor,
              fontSize: Get.width > 600 ? 14.sp : null,
            ),
            tabs: [
              ...List.generate(
                10,
                (index) => Tab(
                  text: '$index Index',
                ),
              )
            ],
          ),
          Expanded(
              child: TabBarView(children: [
            ListView(
              children: [
                NewsFirstTile(
                  newsModel: NewsModel(
                    title:
                        'Alvarez set to join Atletico in 95 million euro deal',
                    image:
                        'https://www.thedailystar.net/sites/default/files/styles/big_202/public/images/2024/08/06/alvarez.jpg',
                    description:
                        'Alvarez set to join Atletico in 95 million euro deal',
                    publishDate: '216926719',
                    categoryType: 'news',
                  ),
                ),
                ...List.generate(
                  10,
                  (index) => NewsTileList(
                    newsModel: NewsModel(
                      title:
                          'Alvarez set to join Atletico in 95 million euro deal',
                      image:
                          'https://www.thedailystar.net/sites/default/files/styles/big_202/public/images/2024/08/06/alvarez.jpg',
                      description:
                          'Alvarez set to join Atletico in 95 million euro deal',
                      publishDate: '216926719',
                      categoryType: 'news',
                    ),
                  ),
                )
              ],
            )
          ]))
        ],
      ),
    );
  }
}
