import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultasService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  ConsultasService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    userId = currentUser?.uid ??
        ''; // Defina userId como uma string vazia se currentUser for nulo
  }

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

  Future<void> editarConsulta(
    String consultaId,
    String especialidade,
    String data,
    String horario,
    String resumo,
    String retorno,
    String lembrete,
  ) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference consultaDoc = consultasCollection
          .doc(user.uid)
          .collection('Consultas do Usuário')
          .doc(consultaId);

      await consultaDoc.update({
        'especialidade': especialidade,
        'data': data,
        'horario': horario,
        'resumo': resumo,
        'retorno': retorno,
        'lembrete': lembrete,
      });
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

  Future<List<ModeloConsultas>> getConsultasPorEspecialidade(
      String especialidade) async {
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