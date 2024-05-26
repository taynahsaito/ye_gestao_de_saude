import 'package:app_ye_gestao_de_saude/models/modelo_pressao.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_pressao.dart';
import 'package:app_ye_gestao_de_saude/services/pressao_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Pressao extends StatefulWidget {
  const Pressao({Key? key});

  @override
  State<Pressao> createState() => _PressaoState();
}

class _PressaoState extends State<Pressao> {
  // final databaseReference = FirebaseDatabase.instance.ref().child('pressoes');
  List<DocumentSnapshot> historicoPressao =
      []; // List to store retrieved pressure data
  @override
  void initState() {
    super.initState();
    _getHistoricoPressao();
  }

  Future<void> _getHistoricoPressao() async {
    //final snapshot = await databaseReference.get();
    //print(snapshot.value);
    //Object? historicoPressao = snapshot.value;

    // await databaseReference.push().set({
    //   'diastólica': "_diastolicaController",
    //   'sistólica': "_sistolicaController",
    //   'data': "_senhaController",
    //   'dataNascimento': "dataNascimento",
    // });
    // Get reference to 'pressao_sanguinea' collection
    //CollectionReference pressureRef = firestore.collection('pressao_sanguinea');

    // Get all documents from the collection
    //QuerySnapshot querySnapshot = await pressureRef.get();

    // Update state with retrieved documents
    // setState(() {
    //   historicoPressao = querySnapshot.docs;
    // });
  }
    final PressaoService dbService = PressaoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(220, 105, 126, 80), // Define a cor do ícone
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<ModeloPressao>>(
              stream: dbService.getPressao(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var pressoes = snapshot.data!;

                return ListView.builder(
                    itemCount: pressoes.length,
                    itemBuilder: (context, index) {
                      var pressao = pressoes[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${pressao.sistolica}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Icon(Icons.info_outline),
                            Text(
                              '${pressao.diastolica}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Icon(Icons.info_outline),
                            Text(
                              '${pressao.data}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Icon(Icons.info_outline),
                          ],

                        ),
                      );
                    });
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NovaPressao()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      50, 105, 126, 80), // Cor de fundo do botão
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
