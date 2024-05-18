import 'package:app_ye_gestao_de_saude/pages/nova_glicemia.dart';
import 'package:flutter/material.dart';

class Glicemia extends StatefulWidget {
  const Glicemia({super.key});

  @override
  State<Glicemia> createState() => _GlicemiaState();
}

class _GlicemiaState extends State<Glicemia> {
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
                    'Glicemia',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),







                  
                  // ListView.builder(
                  //   itemCount: glicemias.length * 2 +
                  //       1, // Adicionando 2 para as mensagens extra e 1 para o botão de adicionar
                  //   itemBuilder: (context, index) {
                  //     if (index.isOdd) {
                  //       // Índices ímpares para mensagens extra
                  //       final dataIndex = index ~/ 2;
                  //       final glicemia = glicemias[dataIndex];
                  //       final value = glicemia['value'];

                  //       // Verifica se o valor está fora dos limites de referência
                  //       bool isOutOfRange = (value < 70 || value > 100);

                  //       if (isOutOfRange) {
                  //         return Container(
                  //           margin: const EdgeInsets.all(10.0),
                  //           padding: const EdgeInsets.symmetric(
                  //               vertical: 10.0, horizontal: 10.0),
                  //           child: const Text(
                  //             'Esse resultado está fora dos limites de referência. Consulte seu médico para mais informações.',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(color: Color(0xFFA31B1B)),
                  //           ),
                  //         );
                  //       } else {
                  //         return const SizedBox(); // Retorna um widget vazio para os índices ímpares
                  //       }
                  //     } else if (index == glicemias.length * 2) {
                  //       // Último índice: botão de adicionar
                  //       return Container(
                  //         margin: const EdgeInsets.symmetric(vertical: 20.0),
                  //         alignment: Alignment.center,
                  //         child: SizedBox(
                  //           width: 50,
                  //           height: 50,
                  //           child: FloatingActionButton(
                  //             onPressed: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => const NovaGlicemia()),
                  //               );
                  //             },
                  //             backgroundColor: const Color(0xFF697E50),
                  //             shape: const CircleBorder(),
                  //             child: const Icon(Icons.add, color: Color(0xFFF5F5F5)),
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       // Índices pares para os valores de glicemia
                  //       final dataIndex = index ~/ 2;
                  //       final glicemia = glicemias[dataIndex];
                  //       final date = glicemia['date'];
                  //       final value = glicemia['value'];

                  //       // Verifica se o valor está fora dos limites de referência
                  //       bool isOutOfRange = (value < 70 || value > 100);

                  //       // Define a cor de fundo da caixa
                  //       Color boxColor =
                  //           isOutOfRange ? const Color(0xFFD89477) : Color(0xFFA7D877);
                  //       // Define a cor do valor da glicemia
                  //       Color valueColor =
                  //           value == 79 ? const Color(0xFF697E50) : Color(0xFFA31B1B);

                  //       return Container(
                  //         margin: const EdgeInsets.symmetric(vertical: 5.0),
                  //         padding: const EdgeInsets.all(10.0),
                  //         color: boxColor,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               'Data: $date',
                  //               style: const TextStyle(
                  //                   color: Color(0xFF000000)), // Cor preta
                  //             ),
                  //             Text(
                  //               '$value mg/dL',
                  //               style: TextStyle(
                  //                 color: valueColor,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),// Outros widgets aqui...
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
                        builder: (context) => const NovaGlicemia()),
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
