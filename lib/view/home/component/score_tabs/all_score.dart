import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/widget/league_title.dart';
import 'package:football_fever/common/widget/live_match_tile.dart';
import 'package:football_fever/common/widget/time_tile.dart';
import 'package:get/get.dart';

import '../../../../common/clipper/tri_angle_clipper.dart';
import '../../../../common/widget/upcoming_match_tile.dart';

class AllScoreTab extends StatelessWidget {
  const AllScoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      children: const [
        TimeTile(date: 'DATE'),
        LeagueTitle(
          name: 'Champions League',
          icon:
              'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
        ),
        LiveMatchTile(),
        UpcomingMatchTile(),
        TimeTile(date: '20 Jul 2024'),
        LeagueTitle(
          name: 'Champions League',
          icon:
              'https://resources.premierleague.com/premierleague/competitions/competition_1_small.png',
        ),
        LiveMatchTile(),
        UpcomingMatchTile(),
      ],
    );
  }
}
