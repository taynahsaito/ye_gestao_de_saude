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
          .collection('Consultas do Usuário')
          .doc();
      await userDoc.set(modeloGlicemia.toFirestore());
    }
  }

  Stream<List<ModeloGlicemia>> getGlicemia() {
    User? user = _auth.currentUser;
    if (user != null) {
      return glicemiaCollection
          .doc(user.uid)
          .collection('Consultas do Usuário')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloGlicemia.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }
}
