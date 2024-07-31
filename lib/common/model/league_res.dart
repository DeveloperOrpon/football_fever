// To parse this JSON data, do
//
//     final leagueRes = leagueResFromJson(jsonString);

import 'dart:convert';

import 'match_res.dart';

LeagueRes leagueResFromJson(String str) => LeagueRes.fromJson(json.decode(str));

String leagueResToJson(LeagueRes data) => json.encode(data.toJson());

class LeagueRes {
  final List<League>? data;
  final Pagination? pagination;
  final String? timezone;

  LeagueRes({
    this.data,
    this.pagination,
    this.timezone,
  });

  LeagueRes copyWith({
    List<League>? data,
    Pagination? pagination,
    String? timezone,
  }) =>
      LeagueRes(
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
        timezone: timezone ?? this.timezone,
      );

  factory LeagueRes.fromJson(Map<String, dynamic> json) => LeagueRes(
        data: json["data"] == null
            ? []
            : List<League>.from(json["data"]!.map((x) => League.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "timezone": timezone,
      };
}

class Pagination {
  final bool? hasMore;

  Pagination({
    this.hasMore,
  });

  Pagination copyWith({
    bool? hasMore,
  }) =>
      Pagination(
        hasMore: hasMore ?? this.hasMore,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "has_more": hasMore,
      };
}
