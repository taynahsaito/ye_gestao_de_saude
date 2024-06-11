import 'package:app_ye_gestao_de_saude/models/glicemia_model.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_glicemia.dart';
import 'package:app_ye_gestao_de_saude/services/glicemia_service.dart';
import 'package:app_ye_gestao_de_saude/widgets/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Glicemia extends StatefulWidget {
  const Glicemia({super.key});

  @override
  State<Glicemia> createState() => GlicemiaState();
}

class GlicemiaState extends State<Glicemia> {
  final GlicemiaService _glicemiaService = GlicemiaService();

  List<DocumentSnapshot> historicoGlicemia = [];

  void initState() {
    super.initState();
    _getHistoricoGlicemia();
  }

  Future<void> _getHistoricoGlicemia() async {}

  final GlicemiaService glicemiaService = GlicemiaService();

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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Center(
                  child: Text(
                    'Histórico de glicemia',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<ModeloGlicemia>>(
                  stream: _glicemiaService.getGlicemia(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    //   return const Center(
                    //       child: Text('Nenhuma glicemia registrada.'));
                    // }

                    final glicemias = snapshot.data!;
                    return ListView.builder(
                      itemCount: glicemias.length,
                      itemBuilder: (context, index) {
                        var glicemia = glicemias[index];
                        var valor = int.parse(glicemia.glicemia);

                        Color corbox;
                        Color corTexto;
                        SizedBox caixaAlteracao;

                        if (valor < 70) {
                          corbox = const Color.fromRGBO(219, 127, 88, 0.53);
                          corTexto = const Color.fromRGBO(150, 54, 30, 0.829);
                          caixaAlteracao = const SizedBox(
                            width: 450,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
                              child: Text(
                                'Esse resultado está abaixo dos limites de referência. Consulte seu médico para mais informações.',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(150, 54, 30, 0.829)),
                              ),
                            ),
                          );
                        } else if (valor >= 100) {
                          corbox = const Color.fromRGBO(219, 127, 88, 0.53);
                          corTexto = const Color.fromRGBO(150, 54, 30, 0.829);
                          caixaAlteracao = const SizedBox(
                            width: 450,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
                              child: Text(
                                'Esse resultado está acima dos limites de referência. Consulte seu médico para mais informações.',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(150, 54, 30, 0.829)),
                              ),
                            ),
                          );
                        } else {
                          corbox = const Color.fromRGBO(167, 216, 119, 0.5);
                          corTexto = const Color.fromARGB(255, 78, 101, 61);
                          caixaAlteracao = const SizedBox(width: 0);
                        }

                        return ListTile(
                            title: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 20, 25, 20),
                              decoration: BoxDecoration(
                                  color: corbox,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Text(
                                    '${glicemia.dataAfericao}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(), // Este Spacer vai empurrar o próximo widget para a direita
                                  Text(
                                    '${glicemia.glicemia} mg/dL',
                                    style: TextStyle(
                                      color: corTexto,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            caixaAlteracao,
                          ],
                        ));
                      },
                    );
                  },
                ),
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
                  MaterialPageRoute(builder: (context) => const NovaGlicemia()),
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
