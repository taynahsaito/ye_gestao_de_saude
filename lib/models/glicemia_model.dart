import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ModeloGlicemia {
  final String id;
  final String glicemia;
  final String dataAfericao;

  ModeloGlicemia({
    required this.id,
    required this.glicemia,
    required this.dataAfericao,
  });

  factory ModeloGlicemia.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final DateTime parsedDate =
        DateFormat('yyyy/MM/dd').parse(data['data de afericao']);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return ModeloGlicemia(
      id: doc.id,
      glicemia: data['glicemia'] ?? '',
      // dataAfericao: data['data de afericao'] ?? '',
      dataAfericao: formattedDate ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    // Converte a data de formato 'dd/MM/yyyy' para 'yyyy/MM/dd' antes de salvar no Firestore
    final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(dataAfericao);
    final String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);

    return {
      'glicemia': glicemia,
      'data de afericao': formattedDate, // Salva a data formatada no Firestore
    };
  }

  // Método para obter a data formatada como 'dd/MM/yyyy' na aplicação
  String getFormattedDate() {
    // Converte a data de formato 'yyyy/MM/dd' para 'dd/MM/yyyy' ao ser recuperada na aplicação
    final DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(dataAfericao);
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }
}
