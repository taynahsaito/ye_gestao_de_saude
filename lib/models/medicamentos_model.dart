import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloMedicamentos {
  final String id;
  final String nome;
  final String horario;
  final String intervaloHoras;
  final String periodoTomado;

  ModeloMedicamentos({
    required this.id,
    required this.nome,
    required this.horario,
    required this.intervaloHoras,
    required this.periodoTomado,
  });

    factory ModeloMedicamentos.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ModeloMedicamentos(
      id: doc.id,
      nome: data['nome'] ?? '',
      horario: data['horario'] ?? '',
      intervaloHoras: data['intervalo de horas'] ?? '',
      periodoTomado: data['periodo que o medicamento será tomado'] ?? '',

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nome': nome,
      'horario': horario,
      'intervalo de horas': intervaloHoras,
      'periodo que o medicamento será tomado': periodoTomado,
    };
  }
}
