import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';

class ModeloPressao {
  final String id;
  final String sistolica;
  final String diastolica;
  final String data;

  ModeloPressao({
    required this.id,
    required this.sistolica,
    required this.diastolica,
    required this.data
  });

  factory ModeloPressao.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ModeloPressao(
      id: doc.id,
      sistolica: data['sistolica'] ?? '',
      diastolica: data['diastolica'] ?? '',
      data: data['data'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'data': data,
      'sistolica': sistolica,
      'diastolica': diastolica,
    };
  }
}