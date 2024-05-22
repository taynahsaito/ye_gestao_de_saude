import 'package:app_ye_gestao_de_saude/pages/nova_pressao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Pressao extends StatefulWidget {
  const Pressao({Key? key});

  @override
  State<Pressao> createState() => _PressaoState();
}

class _PressaoState extends State<Pressao> {
  final databaseReference = FirebaseDatabase.instance.ref().child('pressoes');
  List<DocumentSnapshot> historicoPressao =
      []; // List to store retrieved pressure data
  @override
  void initState() {
    super.initState();
    _getHistoricoPressao();
  }
  Future<void> _getHistoricoPressao() async {
    
    final snapshot = await databaseReference.get();
    print(snapshot.value);
    Object? historicoPressao = snapshot.value;

    await databaseReference.push().set({
      'diastólica': "_diastolicaController",
      'sistólica': "_sistolicaController",
      'data': "_senhaController",
      'dataNascimento': "dataNascimento",
    });
    // Get reference to 'pressao_sanguinea' collection
    //CollectionReference pressureRef = firestore.collection('pressao_sanguinea');

    // Get all documents from the collection
    //QuerySnapshot querySnapshot = await pressureRef.get();

    // Update state with retrieved documents
    // setState(() {
    //   historicoPressao = querySnapshot.docs;
    // });
  }

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
          const SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Histórico da pressão',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Outros widgets aqui...
                  SizedBox(
                    height: 80,
                    width: 450,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(219, 127, 88, 0.53),
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "21/05/2024",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("Alta"),
                          Text(
                            '150x95 mmHg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(150, 54, 30, 0.829),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    width: 450,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(167, 216, 119, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "20/05/2024",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("Normal"),
                          Text(
                            '120x80 mmHg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(62, 100, 23, 1)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    width: 450,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(219, 127, 88, 0.53),
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "12/05/2024",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("Baixa"),
                          Text(
                            '100x50 mmHg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(150, 54, 30, 0.829)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    width: 450,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(219, 127, 88, 0.53),
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "1/05/2079",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("Baixa"),
                          Text(
                            '100x50 mmHg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(150, 54, 30, 0.829)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    width: 450,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(167, 216, 119, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "20/04/2024",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("Normal"),
                          Text(
                            '130x90 mmHg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(62, 100, 23, 1)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
