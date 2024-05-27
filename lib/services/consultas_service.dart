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

  // final CollectionReference consultasCollection =
  //     FirebaseFirestore.instance.collection('Consultas');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference consultasCollection =
      FirebaseFirestore.instance.collection('consultas');

  Future<void> adicionarConsulta(ModeloConsultas modeloConsultas) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDoc = consultasCollection
          .doc(user.uid)
          .collection('Consultas do Usuário')
          .doc();
      await userDoc.set(modeloConsultas.toFirestore());
    }
  }
  // Future<void> adicionarConsulta(ModeloConsultas modeloConsultas) async {
  //   try {
  //     await _firestore
  //         .collection('Consultas') // Nome significativo para a coleção
  //         .doc(userId)
  //         .collection(
  //             'Consultas do Usuário') // Nome significativo para a subcoleção
  //         .doc(modeloConsultas.id)
  //         .set(modeloConsultas.toMap());

  //     print('Consulta adicionada com sucesso!');
  //   } catch (error) {
  //     print('Erro ao adicionar consulta: $error');
  //     throw error; // Lança o erro novamente para que possa ser tratado no local de chamada, se necessário
  //   }
  // }

  Future<void> editarConsulta(
      String consultaId, ModeloConsultas modeloConsultas) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference consultaDoc = consultasCollection
          .doc(user.uid)
          .collection('Consultas do Usuário')
          .doc(consultaId);

      await consultaDoc.update(modeloConsultas.toFirestore());
    }
  }

  Future<void> deletarConsulta(String id) async {
    try {
      await _firestore
          .collection('consultas')
          .doc(userId)
          .collection('Consultas do Usuário')
          .doc(id)
          .delete();
    } catch (e) {
      print("Erro ao excluir a medicação: $e");
    }
  }

  Stream<List<ModeloConsultas>> getConsultas() {
    User? user = _auth.currentUser;
    if (user != null) {
      return consultasCollection
          .doc(user.uid)
          .collection('Consultas do Usuário')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ModeloConsultas.fromFirestore(doc))
              .toList());
    } else {
      return Stream.empty();
    }
  }
  

Future<List<ModeloConsultas>> getConsultasPorEspecialidade(String especialidade) async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await consultasCollection
          .doc(user.uid)
          .collection('Consultas do Usuário')
          .where('especialidade', isEqualTo: especialidade)
          .get();
      return querySnapshot.docs
          .map((doc) => ModeloConsultas.fromFirestore(doc))
          .toList();
    } else {
      return [];
    }
  }

}
