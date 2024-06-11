import 'package:app_ye_gestao_de_saude/models/peso_altura_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PesoAlturaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  PesoAlturaService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference pesoealturaCollection =
      FirebaseFirestore.instance.collection('PesoAltura');

  Future<void> adicionarPesoAltura(ModeloPesoAltura modeloPesoAltura) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = pesoealturaCollection
          .doc(user.uid)
          .collection('Pesos e alturas do paciente')
          .doc();
      await userDoc.set(modeloPesoAltura.toFirestore());
    }
  }

  Stream<List<ModeloPesoAltura>> getPesoAltura() {
    //importante
    User? user = _auth.currentUser;
    if (user != null) {
      return pesoealturaCollection
          .doc(user.uid)
          .collection('Pesos e alturas do paciente')
          .orderBy('data', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloPesoAltura.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }

  Future<ModeloPesoAltura?> getLatestWeightandHeight() async {
    try {
      // Busque as glicemias mais recentes
      final querySnapshot = await _firestore
          .collection('PesoAltura')
          .doc(userId)
          .collection('Pesos e alturas do paciente')
          .orderBy('data', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final ultimoPesoeAlturaDoc = querySnapshot.docs.first;
        final ultimoPesoeAltura =
            ModeloPesoAltura.fromFirestore(ultimoPesoeAlturaDoc);
        return ultimoPesoeAltura;
      } else {
        return null;
      }
    } catch (error) {
      print("Erro ao buscar peso e altura mais recente: $error");
      return null;
    }
  }
}
