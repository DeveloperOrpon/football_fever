import 'package:flutter/material.dart';

import '../../../common/model/match_res.dart';

class StatsTab extends StatelessWidget {
  final Function() onInit;
  final Map<String, List<Statistic>> totalStatistics;
  final bool isLoadingStats;
  const StatsTab(
      {super.key,
      required this.onInit,
      required this.totalStatistics,
      required this.isLoadingStats});

  @override
  Widget build(BuildContext context) {
    onInit();
    return Center(
      child: Text('Stats Tab'),
    );
  }
}
