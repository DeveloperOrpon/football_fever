import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/common/model/match_res.dart';
import 'package:football_fever/common/widget/live_match_tile.dart';
import 'package:football_fever/common/widget/loading_widget.dart';
import 'package:football_fever/common/widget/no_data.dart';
import 'package:football_fever/common/widget/upcoming_match_tile.dart';
import 'package:football_fever/utils/helper/log.dart';
import 'package:get/get.dart';

class RoundsTab extends StatefulWidget {
  final MatchModel matchModel;
  final List<MatchModel> leagueLastMatches;
  final Function() onInit;
  final bool isLoading;
  const RoundsTab(
      {super.key,
      required this.matchModel,
      required this.onInit,
      required this.leagueLastMatches,
      required this.isLoading});

  @override
  State<RoundsTab> createState() => _RoundsTabState();
}

class _RoundsTabState extends State<RoundsTab> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(child: LoadingWidget(size: 40.w))
        : !widget.isLoading && widget.leagueLastMatches.isEmpty
            ? Center(child: NoDataCustomWidget(
                onRefresh: () {
                  widget.onInit();
                },
              ))
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(widget.leagueLastMatches.length,
                          (index) {
                        return (widget.leagueLastMatches[index].scores ?? [])
                                .isEmpty
                            ? UpcomingMatchTile(
                                matchModel: widget.leagueLastMatches[index])
                            : LiveMatchTile(
                                matchModel: widget.leagueLastMatches[index]);
                      })
                    ],
                  )
                ],
              );
  }
}
