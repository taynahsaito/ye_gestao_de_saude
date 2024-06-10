import "package:app_ye_gestao_de_saude/models/imc_model.dart";
import "package:app_ye_gestao_de_saude/pages/novo_imc.dart";
import "package:app_ye_gestao_de_saude/services/imc_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class IMC extends StatefulWidget {
  const IMC({super.key});

  @override
  State<IMC> createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  List<DocumentSnapshot> historicoIMC = [];
  final IMCService dbService = IMCService();

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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: Center(
                  child: Text(
                    'Histórico de IMC',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<ModeloIMC>>(
                    stream: dbService.getIMC(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var imcs = snapshot.data!;

                      return ListView.builder(
                          itemCount: imcs.length,
                          itemBuilder: (context, index) {
                            var imc = imcs[index];
                            return ListTile(
                              title: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 20, 25, 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        150, 203, 230, 176),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Text(
                                      '${imc.data}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(), // Este Spacer vai empurrar o próximo widget para a direita
                                    Text(
                                      '${imc.imc} kg/m^2',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 78, 101, 61),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
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
                  MaterialPageRoute(builder: (context) => const NovoIMC()),
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
      ]),
    );
  }
}

