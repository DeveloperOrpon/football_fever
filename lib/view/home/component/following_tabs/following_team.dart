import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        radius: 26.r,
                        backgroundColor: Get.theme.scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Get.theme.shadowColor,
                            child: Icon(
                              Icons.add,
                              size: 25.r,
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
              crossAxisCount: Get.width > 600 ? 5 : 4,
              mainAxisExtent: 180.h,
              crossAxisSpacing: Get.width > 600 ? 5.w : 0,
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
