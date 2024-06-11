import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';

class ModeloPressao {
  final String id;
  final String sistolica;
  final String diastolica;
  final String data;

  ModeloPressao(
      {required this.id,
      required this.sistolica,
      required this.diastolica,
      required this.data});

  factory ModeloPressao.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(data['data']);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return ModeloPressao(
      id: doc.id,
      sistolica: data['sistolica'] ?? '',
      diastolica: data['diastolica'] ?? '',
      data: formattedDate ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(data);
    final String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
    return {
      'data': formattedDate,
      'sistolica': sistolica,
      'diastolica': diastolica,
    };
  }

  // Método para obter a data formatada como 'dd/MM/yyyy' na aplicação
  String getFormattedDate() {
    // Converte a data de formato 'yyyy/MM/dd' para 'dd/MM/yyyy' ao ser recuperada na aplicação
    final DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(data);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }
}
