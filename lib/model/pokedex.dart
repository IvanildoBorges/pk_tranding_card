import 'package:flutter/material.dart';

class ModelPokedex {
  final String nome;
  final dynamic url;

  ModelPokedex({
    required this.nome,
    required this.url,
  });

  factory ModelPokedex.fromJson(Map<String, dynamic> json) {
    return ModelPokedex(
      nome: json['name'],
      url: json['url'],
    );
  }
}