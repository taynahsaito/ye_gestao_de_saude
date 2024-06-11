import 'package:app_ye_gestao_de_saude/models/imc_model.dart';
import 'package:app_ye_gestao_de_saude/models/peso_altura_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IMCService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  IMCService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference IMCCollection =
      FirebaseFirestore.instance.collection('IMC');

  Future<void> adicionarIMC(ModeloIMC modeloIMC) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = IMCCollection.doc(user.uid)
          .collection('IMC do paciente')
          .doc(modeloIMC.id);
      await userDoc.set(modeloIMC.toFirestore());
    }
  }

  Stream<List<ModeloIMC>> getIMC() {
    //importante
    User? user = _auth.currentUser;
    if (user != null) {
      return IMCCollection.doc(user.uid)
          .collection('IMC do paciente')
          .orderBy('data', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloIMC.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }
   Future<ModeloIMC?> getLatestIMC() async {
    try {
      // Busque as glicemias mais recentes
      final querySnapshot = await _firestore
          .collection('IMC')
          .doc(userId)
          .collection('IMC do paciente')
          .orderBy('data', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final ultimoIMCDoc = querySnapshot.docs.first;
        final ultimoIMC= ModeloIMC.fromFirestore(ultimoIMCDoc);
        return ultimoIMC;
      } else {
        return null;
      }
    } catch (error) {
      print("Erro ao buscar o IMC mais recente: $error");
      return null;
    }
  }
}
