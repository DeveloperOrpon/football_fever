// To parse this JSON data, do
//
//     final seasonFixtureRes = seasonFixtureResFromJson(jsonString);

import 'dart:convert';

import 'package:football_fever/common/model/match_res.dart';

SeasonFixtureRes seasonFixtureResFromJson(String str) =>
    SeasonFixtureRes.fromJson(json.decode(str));

String seasonFixtureResToJson(SeasonFixtureRes data) =>
    json.encode(data.toJson());

class SeasonFixtureRes {
  final Data? data;

  SeasonFixtureRes({
    this.data,
  });

  SeasonFixtureRes copyWith({
    Data? data,
    List<Subscription>? subscription,
    RateLimit? rateLimit,
    String? timezone,
  }) =>
      SeasonFixtureRes(
        data: data ?? this.data,
      );

  factory SeasonFixtureRes.fromJson(Map<String, dynamic> json) =>
      SeasonFixtureRes(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? sportId;
  final int? leagueId;
  final int? tieBreakerRuleId;
  final String? name;
  final bool? finished;
  final bool? pending;
  final bool? isCurrent;
  final DateTime? startingAt;
  final DateTime? endingAt;
  final DateTime? standingsRecalculatedAt;
  final bool? gamesInCurrentWeek;
  final List<MatchModel>? fixtures;

  Data({
    this.id,
    this.sportId,
    this.leagueId,
    this.tieBreakerRuleId,
    this.name,
    this.finished,
    this.pending,
    this.isCurrent,
    this.startingAt,
    this.endingAt,
    this.standingsRecalculatedAt,
    this.gamesInCurrentWeek,
    this.fixtures,
  });

  Data copyWith({
    int? id,
    int? sportId,
    int? leagueId,
    int? tieBreakerRuleId,
    String? name,
    bool? finished,
    bool? pending,
    bool? isCurrent,
    DateTime? startingAt,
    DateTime? endingAt,
    DateTime? standingsRecalculatedAt,
    bool? gamesInCurrentWeek,
    List<MatchModel>? fixtures,
  }) =>
      Data(
        id: id ?? this.id,
        sportId: sportId ?? this.sportId,
        leagueId: leagueId ?? this.leagueId,
        tieBreakerRuleId: tieBreakerRuleId ?? this.tieBreakerRuleId,
        name: name ?? this.name,
        finished: finished ?? this.finished,
        pending: pending ?? this.pending,
        isCurrent: isCurrent ?? this.isCurrent,
        startingAt: startingAt ?? this.startingAt,
        endingAt: endingAt ?? this.endingAt,
        standingsRecalculatedAt:
            standingsRecalculatedAt ?? this.standingsRecalculatedAt,
        gamesInCurrentWeek: gamesInCurrentWeek ?? this.gamesInCurrentWeek,
        fixtures: fixtures ?? this.fixtures,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        tieBreakerRuleId: json["tie_breaker_rule_id"],
        name: json["name"],
        finished: json["finished"],
        pending: json["pending"],
        isCurrent: json["is_current"],
        startingAt: json["starting_at"] == null
            ? null
            : DateTime.parse(json["starting_at"]),
        endingAt: json["ending_at"] == null
            ? null
            : DateTime.parse(json["ending_at"]),
        standingsRecalculatedAt: json["standings_recalculated_at"] == null
            ? null
            : DateTime.parse(json["standings_recalculated_at"]),
        gamesInCurrentWeek: json["games_in_current_week"],
        fixtures: json["fixtures"] == null
            ? []
            : List<MatchModel>.from(
                json["fixtures"]!.map((x) => MatchModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "tie_breaker_rule_id": tieBreakerRuleId,
        "name": name,
        "finished": finished,
        "pending": pending,
        "is_current": isCurrent,
        "starting_at":
            "${startingAt!.year.toString().padLeft(4, '0')}-${startingAt!.month.toString().padLeft(2, '0')}-${startingAt!.day.toString().padLeft(2, '0')}",
        "ending_at":
            "${endingAt!.year.toString().padLeft(4, '0')}-${endingAt!.month.toString().padLeft(2, '0')}-${endingAt!.day.toString().padLeft(2, '0')}",
        "standings_recalculated_at": standingsRecalculatedAt?.toIso8601String(),
        "games_in_current_week": gamesInCurrentWeek,
        "fixtures": fixtures == null
            ? []
            : List<dynamic>.from(fixtures!.map((x) => x.toJson())),
      };
}
