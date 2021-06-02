import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

EventoModel eventoModelFromJson(String str) =>
    EventoModel.fromJson(json.decode(str));

String eventoModelToJson(EventoModel data) => json.encode(data.toJson());

class EventoModel {
  EventoModel({
    this.id = "",
    this.titulo = "",
    this.descripcion = "",
    this.coordenadas,
  });

  String id;
  String titulo;
  String descripcion;
  GeoPoint coordenadas;

  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
      id: json["id"],
      titulo: json["titulo"],
      descripcion: json["descripcion"],
      coordenadas: json["coordenadas"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "coordenadas": coordenadas,
      };
}
