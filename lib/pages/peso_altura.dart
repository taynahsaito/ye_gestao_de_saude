import 'package:app_ye_gestao_de_saude/services/peso_altura_service.dart';
import 'package:app_ye_gestao_de_saude/models/peso_altura_model.dart';
import 'package:app_ye_gestao_de_saude/widgets/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ye_gestao_de_saude/pages/novo_peso_altura.dart';
import 'package:flutter/material.dart';

class PesoAltura extends StatefulWidget {
  const PesoAltura({Key? key});

  @override
  State<PesoAltura> createState() => _PesoAlturaState();
}

class _PesoAlturaState extends State<PesoAltura> {
  List<DocumentSnapshot> historicoPesoAltura = [];
  @override
  void initState() {
    super.initState();
    _getHistoricoPesoAltura();
  }

  Future<void> _getHistoricoPesoAltura() async {}

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavBar(selectedIndex: 0),
                ),
              );
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  child: Center(
                    child: Text(
                      'Histórico de peso e altura',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(220, 105, 126, 80),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<ModeloPesoAltura>>(
                      stream: dbService.getPesoAltura(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final pesos = snapshot.data!;

                        return ListView.builder(
                            itemCount: pesos.length,
                            itemBuilder: (context, index) {
                              var pesoalturas = pesos[index];
                              return ListTile(
                                title: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 20, 25, 20),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          150, 175, 186, 161),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${pesoalturas.data}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text('${pesoalturas.peso} kg',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 78, 101, 61),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              )),
                                          Text('${pesoalturas.altura} m',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 78, 101, 61),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              )),
                                        ],
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
                    MaterialPageRoute(
                        builder: (context) => const NovoPesoAltura()),
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
