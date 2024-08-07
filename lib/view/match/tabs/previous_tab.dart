import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/team_model_res.dart';

import '../../../common/widget/live_match_tile.dart';
import '../../../common/widget/upcoming_match_tile.dart';

class PreviousTab extends StatefulWidget {
  final TeamModelRes? homeTeamInfo;

  final Function() onInit;

  const PreviousTab({super.key, this.homeTeamInfo, required this.onInit});

  @override
  State<PreviousTab> createState() => _PreviousTabState();
}

class _PreviousTabState extends State<PreviousTab> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      children: [
        ...List.generate((widget.homeTeamInfo?.data?.data ?? []).length,
            (index) {
          return ((widget.homeTeamInfo?.data?.data ?? [])[index].scores ?? [])
                  .isEmpty
              ? UpcomingMatchTile(
                  matchModel: (widget.homeTeamInfo?.data?.data ?? [])[index])
              : LiveMatchTile(
                  matchModel: (widget.homeTeamInfo?.data?.data ?? [])[index]);
        }).sublist(0, 3)
      ],
    );
  }
}
