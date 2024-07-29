import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';

import '../../../../common/widget/favorite_team_card.dart';

class FollowingTeam extends StatelessWidget {
  const FollowingTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Text(
              "MY FAVORITE'S",
              style: Get.theme.textTheme.titleLarge!.copyWith(
                fontSize: 20.sp,
                color: Get.theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 190.h,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            10.horizontalSpace,
                        itemBuilder: (context, index) {
                          return const FavoriteTeamCard(isFavorite: true);
                        },
                        itemCount: 5,
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Get.theme.scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundColor: Get.theme.shadowColor,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            Text(
              "OTHER TEAM'S",
              style: Get.theme.textTheme.titleLarge!.copyWith(
                fontSize: 20.sp,
                color: Get.theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ])),
          SliverGrid.builder(
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 190.h,
              crossAxisSpacing: 10.w,
            ),
            itemBuilder: (context, index) {
              return const FavoriteTeamCard(isFavorite: false);
            },
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            100.verticalSpace,
          ]))
        ],
      ),
    );
  }
}
