// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AutoModel autoModel(String str) => AutoModel.fromJson(json.decode(str));

String autoModelToJson(AutoModel data) => json.encode(data.toJson());

class AutoModel {
  AutoModel({
    this.id,
    this.marca,
    this.patente,
    this.precio = 0.0,
  });
  String id;
  String marca;
  String patente;
  double precio;

  factory AutoModel.fromJson(Map<String, dynamic> json) => AutoModel(
        id: json["id"],
        marca: json["marca"],
        patente: json["patente"],
        precio: json["precio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "marca": marca,
        "patente": patente,
        "precio": precio,
      };
}
