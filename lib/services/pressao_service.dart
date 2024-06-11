import 'package:app_ye_gestao_de_saude/models/modelo_pressao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PressaoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  PressaoService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference pressaoCollection =
      FirebaseFirestore.instance.collection('Pressao');

  Future<void> adicionarPressao(ModeloPressao modeloPressao) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = pressaoCollection
          .doc(user.uid)
          .collection('Pressões do Usuário')
          .doc(modeloPressao.id);
      await userDoc.set(modeloPressao.toFirestore());
    }
  }

  Stream<List<ModeloPressao>> getPressao() {
    //importante
    User? user = _auth.currentUser;
    if (user != null) {
      return pressaoCollection
          .doc(user.uid)
          .collection('Pressões do Usuário')
          .orderBy('data', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloPressao.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }

  Future<ModeloPressao?> getLatestPressure() async {
    try {
      // Busque as glicemias mais recentes
      final querySnapshot = await _firestore
          .collection('Pressao')
          .doc(userId)
          .collection('Pressões do Usuário')
          .orderBy('data', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final ultimaPressaoDoc = querySnapshot.docs.first;
        final ultimaPressao = ModeloPressao.fromFirestore(ultimaPressaoDoc);
        return ultimaPressao;
      } else {
        return null;
      }
    } catch (error) {
      print("Erro ao buscar a pressão mais recente: $error");
      return null;
    }
  }
}
