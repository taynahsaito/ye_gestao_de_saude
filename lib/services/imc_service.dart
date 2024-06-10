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
      DocumentReference userDoc = IMCCollection
          .doc(user.uid)
          .collection('IMC do paciente')
          .doc();
      await userDoc.set(modeloIMC.toFirestore());
    }
  }

Stream<List<ModeloIMC>> getIMC() {//importante
    User? user = _auth.currentUser;
    if (user != null) {
      return IMCCollection
          .doc(user.uid)
          .collection('IMC do paciente')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloIMC.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }

}