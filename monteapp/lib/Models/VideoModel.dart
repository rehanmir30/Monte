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
  String? the360;
  String? description;
  String? thumbnail;

  VideoModel({
    this.the480,
    this.the720,
    this.the1080,
    this.id,
    this.title,
    this.the360,
    this.description,
    this.thumbnail,
  });

  factory VideoModel.fromMap(Map<String, dynamic> json) => VideoModel(
    the480: json["Video-480p"],
    the720: json["Video-720p"],
    the1080: json["Video-1080p"],
    id: json["id"],
    title: json["title"],
    the360: json["Video-360p"],
    description: json["description"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toMap() => {
    "Video-480p": the480,
    "Video-720p": the720,
    "Video-1080p": the1080,
    "id": id,
    "title": title,
    "Video-360p": the360,
    "description": description,
    "thumbnail": thumbnail,
  };
}
