import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    return ModeloIMC(
        id: doc.id,
        peso: data['peso'] ?? '',
        altura: data['altura'] ?? '',
        data: data['data'] ?? '',
        imc: data['imc'] ?? '',);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'data': data,
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
}
