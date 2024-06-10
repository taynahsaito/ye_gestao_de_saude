import 'package:app_ye_gestao_de_saude/models/medicamentos_model.dart';
import 'package:app_ye_gestao_de_saude/pages/editar_medicamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicamentosService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  MedicamentosService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference medicamentosCollection =
      FirebaseFirestore.instance.collection('medicamentos');

  Future<void> adicionarMedicamento(
      ModeloMedicamentos modeloMedicamentos) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = medicamentosCollection
          .doc(user.uid)
          .collection('medicamentos do usuário')
          .doc();
      await userDoc.set(modeloMedicamentos.toFirestore());
    }
  }

  Future<void> editarMedicamento(
      String consultaId, ModeloMedicamentos modeloMedicamentos) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference consultaDoc = medicamentosCollection
          .doc(user.uid)
          .collection('medicamentos do usuário')
          .doc(consultaId);

      await consultaDoc.update(modeloMedicamentos.toFirestore());
    }
  }

  Future<void> deletarMedicamento(String id) async {
    try {
      await _firestore
          .collection('medicamentos')
          .doc(userId)
          .collection('medicamentos do usuário')
          .doc(id)
          .delete();
    } catch (e) {
      print("Erro ao excluir a medicação: $e");
    }
  }

  Stream<List<ModeloMedicamentos>> getMedicamentos() {
    User? user = _auth.currentUser;
    if (user != null) {
      return medicamentosCollection
          .doc(user.uid)
          .collection('medicamentos do usuário')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloMedicamentos.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }
}
