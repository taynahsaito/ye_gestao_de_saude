import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloGlicemia {
  final String id;
  final String glicemia;
  final String dataAfericao;

  ModeloGlicemia(
      {required this.id, required this.glicemia, required this.dataAfericao});

  factory ModeloGlicemia.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return ModeloGlicemia(
      id: doc.id,
      glicemia: data['glicemia'] ?? '',
      dataAfericao: data['data de afericao'] ?? '',
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'glicemia': glicemia,
      'data de afericao': dataAfericao,
    };
  }
}
