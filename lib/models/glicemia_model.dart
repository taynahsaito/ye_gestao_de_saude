import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloGlicemia {
  final String glicemia;
  final DateTime dataAfericao;

  ModeloGlicemia({required this.glicemia, required this.dataAfericao});

  Map<String, dynamic> toFirestore() {
    return {
      'glicemia': glicemia,
      'data_afericao': Timestamp.fromDate(dataAfericao),
    };
  }

  static ModeloGlicemia fromFirestore(Map<String, dynamic> data) {
    return ModeloGlicemia(
      glicemia: data['glicemia'],
      dataAfericao: (data['data_afericao'] as Timestamp).toDate(),
    );
  }
}