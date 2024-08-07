import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/no_data.dart';

class FollowingMatches extends StatelessWidget {
  const FollowingMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      children: const [
        NoDataCustomWidget(),
        // LeagueTitle(
        //   name: 'Champions League',
        //   icon:
        //       'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
        // ),
        // // UpcomingMatchTile(
        // //   isLive: true,
        // // ),
        // LeagueTitle(
        //   name: 'Champions League',
        //   icon:
        //       'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
        // ),
        // LiveMatchTile(
        //   isLive: true,
        // ),
        // UpcomingMatchTile(
        //   isLive: true,
        // ),
      ],
    );
  }
}
