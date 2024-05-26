import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_ye_gestao_de_saude/services/peso_altura_servico.dart';

class ModeloPesoAltura{
  final String id;
  final String peso;
  final String altura;
  final String data;

  ModeloPesoAltura({
    required this.id,
    required this.peso,
    required this.altura,
    required this.data
  });

  factory ModeloPesoAltura.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ModeloPesoAltura(
      id: doc.id,
      peso: data['peso'] ?? '',
      altura: data['altura'] ?? '',
      data: data['data'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'data': data,
      'sistolica': peso,
      'diastolica': altura,
    };
  }
}