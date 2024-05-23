import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultasService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  ConsultasService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }

  Future<void> adicionarConsulta(ModeloConsultas modeloConsultas) async {
    try {
      await _firestore
          .collection('Consultas') // Nome significativo para a coleção
          .doc(userId)
          .collection(
              'Consultas do Usuário') // Nome significativo para a subcoleção
          .doc(modeloConsultas.id)
          .set(modeloConsultas.toMap());

      print('Consulta adicionada com sucesso!');
    } catch (error) {
      print('Erro ao adicionar consulta: $error');
      throw error; // Lança o erro novamente para que possa ser tratado no local de chamada, se necessário
    }
  }
}
