import 'package:app_ye_gestao_de_saude/pages/data_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_consulta.dart';
import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  const Consultas({super.key});

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "Consultas realizadas",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataConsultas(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Clínico geral",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: DecoratedBox(
                            //     decoration: BoxDecoration(
                            //       color: const Color.fromARGB(255, 255, 255, 255),
                            //       borderRadius:
                            //           const BorderRadius.all(Radius.circular(20)),
                            //       border: Border.all(
                            //         color: const Color.fromRGBO(190, 186, 186, 0.815),
                            //         width: 2,
                            //       ),
                            //     ),
                            //     child: const SizedBox(
                            //         height: 100,
                            //         child: Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Center(
                            //             child: Text(
                            //               "O hemograma pode ajudar a detectar doenças como anemia, alguns tipos de câncer como leucemia, infecções e inflamações, problemas no sistema imunológico, entre outras.",
                            //               style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontSize: 14,
                            //               ),
                            //             ),
                            //           ),
                            //         )),
                            //   ),
                            //   behavior: SnackBarBehavior.floating,
                            //   backgroundColor: Colors.transparent,
                            //   elevation: 0,
                            // ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DataConsultas()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataConsultas()),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Ginecologista",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DataConsultas()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataConsultas()),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Dermatologista",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DataConsultas()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataConsultas()),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Oftalmologista",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DataConsultas()),
                            );
                          },
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
                  MaterialPageRoute(builder: (context) => const NovaConsulta()),
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
