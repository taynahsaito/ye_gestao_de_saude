import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ModeloIMC {
  final String id;
  final String peso;
  final String altura;
  final String data;
  final String imc;

  ModeloIMC(
      {required this.id,
      required this.peso,
      required this.altura,
      required this.data,
      required this.imc});

  factory ModeloIMC.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
        final DateTime parsedDate =
        DateFormat('yyyy/MM/dd').parse(data['data']);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return ModeloIMC(
        id: doc.id,
        peso: data['peso'] ?? '',
        altura: data['altura'] ?? '',
        data: formattedDate ?? '',
        imc: data['imc'] ?? '',);
  }

  Map<String, dynamic> toFirestore() {
             final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(data);
    final String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
    return {
      'data': formattedDate,
      'peso': peso,
      'altura': altura,
      'imc': imc,
    };
  }

  // Método para calcular o IMC
  static String calcularIMC(String peso, String altura) {
    if (peso.isEmpty || altura.isEmpty) {
      return '';
    }

    double pesoDouble = double.parse(peso);
    double alturaDouble = double.parse(altura) / 100; // Converter altura para metros

    double imc = pesoDouble / pow(alturaDouble, 2);
    return imc.toStringAsFixed(2); // Retornar o IMC com duas casas decimais
  }
  String getFormattedDate() {
    // Converte a data de formato 'yyyy/MM/dd' para 'dd/MM/yyyy' ao ser recuperada na aplicação
    final DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(data);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }
}
