import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloGlicemia {
  final String glicemia;
  final DateTime dataAfericao;

  ModeloGlicemia({required this.glicemia, required this.dataAfericao});

  Map<String, dynamic> toFirestore() {
    return {
      'glicemia': glicemia,
      'data_afericao': dataAfericao,
    };
  }

  static ModeloGlicemia fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return ModeloGlicemia(
      glicemia: data['glicemia'] ?? '',
      dataAfericao: data['data de afericao'] ?? '',
    );
  }
}
