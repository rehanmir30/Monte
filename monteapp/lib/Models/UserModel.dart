// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? approved;
  Detail? detail;
  String? accessToken;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.approved,
    this.detail,
    this.accessToken
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    approved: json["approved"],
    detail: json["detail"] == null ? null : Detail.fromMap(json["detail"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "approved": approved,
    "detail": detail?.toMap(),
  };
}

class Detail {
  int? id;
  int? userId;
  DateTime? dob;
  int? levelId;

  Detail({
    this.id,
    this.userId,
    this.dob,
    this.levelId,
  });

  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
    id: json["id"],
    userId: json["user_id"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    levelId: json["level_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "level_id": levelId,
  };
}
