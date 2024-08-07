import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/net_image.dart';
import 'package:get/get.dart';

import '../../view/following/controller/following_controller.dart';
import '../model/match_res.dart';

class FavoriteTeamCard extends StatelessWidget {
  final bool isFavorite;
  final Participant team;
  const FavoriteTeamCard(
      {super.key, required this.isFavorite, required this.team});

  @override
  Widget build(BuildContext context) {
    final FollowingController followingController = Get.find();
    return InkWell(
      onTap: () {
        followingController.saveFavoriteTeam(team);
      },
      child: Card(
        elevation: 3,
        shadowColor: Get.theme.shadowColor.withOpacity(.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200.r),
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            width: Get.width > 600 ? 60.w : 80.w,
            height: 150.h,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: OvalTopClipper(),
                        child: Container(
                          width: 130.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: !isFavorite
                                ? Get.theme.shadowColor.withOpacity(.5)
                                : Get.theme.primaryColor.withOpacity(.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    8.verticalSpace,
                    Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: NetImageView(
                          fit: BoxFit.contain,
                          url: team.imagePath ?? '',
                        ),
                      ),
                    ),
                    3.verticalSpace,
                    Text(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      '${team.name}',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.star_rate_rounded,
                      color: isFavorite
                          ? Get.theme.primaryColor
                          : Get.theme.primaryColor.withOpacity(.2),
                      size: 35.r,
                    ),
                    4.verticalSpace,
                  ],
                )
              ],
            ),
          ),
        ),
      ).animate().shimmer(duration: 1000.ms, delay: 500.ms, angle: 60),
    );
  }
}

class OvalTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0000667, size.height * 0.2415000);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * -0.0000667, size.height * 0.2415000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
