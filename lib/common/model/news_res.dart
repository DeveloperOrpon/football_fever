import 'dart:convert';

NewsRes newsResFromJson(String str) => NewsRes.fromJson(json.decode(str));

String newsResToJson(NewsRes data) => json.encode(data.toJson());

class NewsRes {
  bool? status;
  Data? data;

  NewsRes({
    this.status,
    this.data,
  });

  factory NewsRes.fromJson(Map<String, dynamic> json) => NewsRes(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<NewsModel>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  int? nextPage;

  Data({
    this.docs,
    this.totalDocs,
    this.limit,
    this.totalPages,
    this.page,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: json["docs"] == null
            ? []
            : List<NewsModel>.from(
                json["docs"]!.map((x) => NewsModel.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs == null
            ? []
            : List<dynamic>.from(docs!.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class NewsModel {
  String? id;
  String? title;
  String? description;
  String? category;
  String? categoryType;
  String? image;
  String? publishDate;
  bool? status;

  NewsModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.categoryType,
    this.image,
    this.publishDate,
    this.status,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        categoryType: json["categoryType"],
        image: json["image"],
        publishDate: json["publish_date"] ?? json["published"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "category": category,
        "categoryType": categoryType,
        "image": image,
        "publish_date": publishDate,
        "status": status,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
