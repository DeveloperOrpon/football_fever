import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/league_title.dart';
import 'package:football_fever/common/widget/live_match_tile.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import '../../../../common/widget/upcoming_match_tile.dart';

class AllLiveTab extends StatelessWidget {
  const AllLiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      children: const [
        LeagueTitle(
          name: 'Champions League',
          icon:
              'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
        ),
        // UpcomingMatchTile(
        //   isLive: true,
        // ),
        LeagueTitle(
          name: 'Champions League',
          icon:
              'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
        ),
        LiveMatchTile(
          isLive: true,
        ),
        // UpcomingMatchTile(
        //   isLive: true,
        // ),
      ],
    );
  }
}
