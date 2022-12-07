import 'dart:convert';

List<GorestEntity?> gorestEntityFromJson(String str) => List<GorestEntity?>.from(json.decode(str).map((x) => GorestEntity.fromJson(x)));

String gorestEntityToJson(GorestEntity data) => json.encode(data.toJson());

class GorestEntity {
  GorestEntity({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  int? id;
  String? name;
  String? email;
  String? gender;
  String? status;

  factory GorestEntity.fromJson(Map<String, dynamic> json) => GorestEntity(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "status": status,
  };
}