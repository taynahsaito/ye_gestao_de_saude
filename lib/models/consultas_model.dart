import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';

class ModeloConsultas {
  final String id;
  final String especialidade;
  final String horario;
  final String data;
  final String resumo;
  final String retorno;
  final String lembrete;

  ModeloConsultas({
    required this.id,
    required this.especialidade,
    required this.horario,
    required this.data,
    required this.resumo,
    required this.retorno,
    required this.lembrete,
  });

  factory ModeloConsultas.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ModeloConsultas(
      id: doc.id,
      especialidade: data['especialidade'] ?? '',
      horario: data['horario'] ?? '',
      data: data['data'] ?? '',
      resumo: data['resumo'] ?? '',
      retorno: data['retorno'] ?? '',
      lembrete: data['lembrete'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'especialidade': especialidade,
      'horario': horario,
      'data': data,
      'resumo': resumo,
      'retorno': retorno,
      'lembrete': lembrete,
    };
  }

  // Map<String, dynamic> toMap() {
  //   final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(data);
  //   final String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
  //   return {
  //     'id': id,
  //     'especialidade': especialidade,
  //     'horario': horario,
  //     'data': formattedDate,
  //     'resumo': resumo,
  //     'retorno': retorno,
  //     'lembrete': lembrete,
  //   };
  // }

  // factory ModeloConsultas.fromMap(Map<String, dynamic> map) {
  //   final DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(map["data"]);
  //   final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
  //   return ModeloConsultas(
  //       id: map['id'],
  //       especialidade: map['especialidade'],
  //       horario: map['horario'],
  //       data: formattedDate,
  //       resumo: map['resumo'],
  //       retorno: map['retorno'],
  //       lembrete: map['lembrete']);
  // }
}
