import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ye_gestao_de_saude/models/glicemia_model.dart';

class GlicemiaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarGlicemia(ModeloGlicemia glicemia) async {
    await _firestore.collection('glicemias').add(glicemia.toFirestore());
  }

  Stream<List<ModeloGlicemia>> getGlicemias() {
    return _firestore.collection('glicemias').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ModeloGlicemia.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
