// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  var id;
  var name;
  var phone;
  var email;
  var approved;
  Detail? detail;
  var accessToken;

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
    "accessToken":accessToken
  };

  factory UserModel.fromSharedPrefMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    approved: json["approved"],
    detail: json["detail"] == null ? null : Detail.fromMap(json["detail"]),
    accessToken: json["accessToken"]

  );
}

class Detail {
  var id;
  var userId;
  DateTime? dob;
  var levelId;

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
