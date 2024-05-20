import 'package:app_ye_gestao_de_saude/pages/info_consultas.dart';
import 'package:flutter/material.dart';

class DataConsultas extends StatefulWidget {
  const DataConsultas({super.key});

  @override
  State<DataConsultas> createState() => _DataConsultasState();
}

class _DataConsultasState extends State<DataConsultas> {
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
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Consultas realizadas",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'nome do especialista',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoConsultas()),
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      width: 450,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "17/04/2024",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InfoConsultas()),
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
        ),
      ]),
    );
  }
}
