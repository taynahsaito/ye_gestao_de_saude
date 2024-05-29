import 'package:app_ye_gestao_de_saude/services/peso_altura_service.dart';
import 'package:app_ye_gestao_de_saude/models/peso_altura_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ye_gestao_de_saude/pages/novo_peso_altura.dart';
import 'package:flutter/material.dart';

class PesoAltura extends StatefulWidget {
  const PesoAltura({Key? key});

  // final List<Pressao> historicoPressao = [];
  // final String pressao
  // const Pressao({Key? key}) : super (key: key);

  @override
  State<PesoAltura> createState() => _PesoAlturaState();
}

class _PesoAlturaState extends State<PesoAltura> {
  List<DocumentSnapshot> historicoPressao =
      [];
  @override
  void initState() {
    super.initState();
    _getHistoricoPesoAltura();
  }

  Future<void> _getHistoricoPesoAltura() async {
  
  }

  final PesoAlturaService dbService = PesoAlturaService();

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
                StreamBuilder<List<ModeloPesoAltura>>(
              stream: dbService.getPesoAltura(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var pesos = snapshot.data!;

                return ListView.builder(
                    itemCount: pesos.length,
                    itemBuilder: (context, index) {
                      var pesoalturas = pesos[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${pesoalturas.peso}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            const Icon(Icons.info_outline),
                            Text(
                              '${pesoalturas.altura}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            const Icon(Icons.info_outline),
                            Text(
                              '${pesoalturas.data}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            const Icon(Icons.info_outline),
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
                    MaterialPageRoute(builder: (context) => const NovoPesoAltura()),
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
