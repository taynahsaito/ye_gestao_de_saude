import 'package:app_ye_gestao_de_saude/models/modelo_pressao.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_pressao.dart';
import 'package:app_ye_gestao_de_saude/services/pressao_service.dart';
import 'package:app_ye_gestao_de_saude/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class Pressao extends StatefulWidget {
  const Pressao({Key? key});

  @override
  State<Pressao> createState() => _PressaoState();
}

class _PressaoState extends State<Pressao> {
  final PressaoService dbService = PressaoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(220, 105, 126, 80),
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
                      'Histórico de pressão',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(220, 105, 126, 80),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<ModeloPressao>>(
                    stream: dbService.getPressao(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      var pressoes = snapshot.data!;

                      return ListView.builder(
                        itemCount: pressoes.length,
                        itemBuilder: (context, index) {
                          var pressao = pressoes[index];
                          var sistolica = int.parse(pressao.sistolica);
                          var diastolica = int.parse(pressao.diastolica);

                          Color corbox;
                          Color corTexto;
                          SizedBox caixaAlteracao;

                          if (sistolica < 90 && diastolica < 60) {
                            corbox = const Color.fromRGBO(219, 127, 88, 0.53);
                            corTexto = const Color.fromRGBO(150, 54, 30, 0.829);
                            caixaAlteracao = const SizedBox(
                              width: 450,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
                                child: Text(
                                  'Sua pressão está baixa. Consulte seu médico para mais informações.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(150, 54, 30, 0.829),
                                  ),
                                ),
                              ),
                            );
                          } else if (sistolica >= 140 && diastolica >= 90) {
                            corbox = const Color.fromRGBO(219, 127, 88, 0.53);
                            corTexto = const Color.fromRGBO(150, 54, 30, 0.829);
                            caixaAlteracao = const SizedBox(
                              width: 450,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
                                child: Text(
                                  'Sua pressão está alta. Consulte seu médico para mais informações.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(150, 54, 30, 0.829),
                                  ),
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
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        pressao.data,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${pressao.sistolica}x${pressao.diastolica} mmHg',
                                        style: TextStyle(
                                          color: corTexto,
                                          // Color.fromARGB(255, 78, 101, 61),

                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                caixaAlteracao,
                              ],
                            ),
                          );
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
                    MaterialPageRoute(
                        builder: (context) => const NovaPressao()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(50, 105, 126, 80),
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
