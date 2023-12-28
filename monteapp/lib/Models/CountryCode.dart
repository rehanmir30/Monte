// To parse this JSON data, do
//
//     final countryCode = countryCodeFromMap(jsonString);

import 'dart:convert';

CountryCode countryCodeFromMap(String str) => CountryCode.fromMap(json.decode(str));

String countryCodeToMap(CountryCode data) => json.encode(data.toMap());

class CountryCode {
  var id;
  var name;
  var code;
  var createdAt;
  var updatedAt;

  CountryCode({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryCode.fromMap(Map<String, dynamic> json) => CountryCode(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "code": code,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
