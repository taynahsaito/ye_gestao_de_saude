import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ye_gestao_de_saude/models/glicemia_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlicemiaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  GlicemiaService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference glicemiaCollection =
      FirebaseFirestore.instance.collection('glicemia');

  Future<void> adicionarGlicemia(ModeloGlicemia modeloGlicemia) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = glicemiaCollection
          .doc(user.uid)
          .collection('Glicemias do Usuário')
          .doc(modeloGlicemia.id);
      await userDoc.set(modeloGlicemia.toFirestore());
    }
  }

  Stream<List<ModeloGlicemia>> getGlicemia() {
    User? user = _auth.currentUser;
    if (user != null) {
      return glicemiaCollection
          .doc(user.uid)
          .collection('Glicemias do Usuário')
          .orderBy('data de afericao', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloGlicemia.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }

  Future<ModeloGlicemia?> getLatestGlucose() async {
    try {
      // Busque as glicemias mais recentes
      final querySnapshot = await _firestore
          .collection('glicemia')
          .doc(userId)
          .collection('Glicemias do Usuário')
          .orderBy('data de afericao', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final ultimaGlicemiaDoc = querySnapshot.docs.first;
        final latestGlucose = ModeloGlicemia.fromFirestore(ultimaGlicemiaDoc);
        return latestGlucose;
      } else {
        return null;
      }
    } catch (error) {
      print("Erro ao buscar a glicemia mais recente: $error");
      return null;
    }
  }
}
