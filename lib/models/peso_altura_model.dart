import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_ye_gestao_de_saude/services/peso_altura_service.dart';

class ModeloPesoAltura {
  final String id;
  final String peso;
  final String altura;
  final String data;

  ModeloPesoAltura(
      {required this.id,
      required this.peso,
      required this.altura,
      required this.data});

  factory ModeloPesoAltura.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    final DateTime parsedDate =
        DateFormat('yyyy/MM/dd').parse(data['data']);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return ModeloPesoAltura(
      id: doc.id,
      peso: data['peso'] ?? '',
      altura: data['altura'] ?? '',
      data: formattedDate ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
         final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(data);
    final String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
    return {
      'data': formattedDate,
      'peso': peso,
      'altura': altura,
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
