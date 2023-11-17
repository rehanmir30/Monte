// To parse this JSON data, do
//
//     final videoModel = videoModelFromMap(jsonString);

import 'dart:convert';

VideoModel videoModelFromMap(String str) => VideoModel.fromMap(json.decode(str));

String videoModelToMap(VideoModel data) => json.encode(data.toMap());

class VideoModel {
  String? the480;
  String? the720;
  String? the1080;
  int? id;
  String? title;
  String? the4K;
  String? description;
  String? thumbnail;

  VideoModel({
    this.the480,
    this.the720,
    this.the1080,
    this.id,
    this.title,
    this.the4K,
    this.description,
    this.thumbnail,
  });

  factory VideoModel.fromMap(Map<String, dynamic> json) => VideoModel(
    the480: json["480"],
    the720: json["720"],
    the1080: json["1080"],
    id: json["id"],
    title: json["title"],
    the4K: json["4k"],
    description: json["description"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toMap() => {
    "480": the480,
    "720": the720,
    "1080": the1080,
    "id": id,
    "title": title,
    "4k": the4K,
    "description": description,
    "thumbnail": thumbnail,
  };
}
