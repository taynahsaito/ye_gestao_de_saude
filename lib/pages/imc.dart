import "package:app_ye_gestao_de_saude/pages/novo_imc.dart";
import "package:flutter/material.dart";

class IMC extends StatefulWidget {
  final String tipo;

  const IMC({super.key, required this.tipo});

  @override
  State<IMC> createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  final TextEditingController _exameController = TextEditingController();
  var exameTipo = '98';

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
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "${widget.tipo}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(220, 105, 126, 80),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 80,
                      width: 450,
                      child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: const Text("Editar exame:"),
                                content: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: _exameController,
                                    decoration: InputDecoration(
                                      fillColor: const Color.fromARGB(
                                          190, 223, 223, 223),
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      labelText:
                                          "Valor do exame de ${widget.tipo}",
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          25, 0, 0, 0),
                                      labelStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 152, 152, 152)),
                                    ),
                                  ),
                                )),
                          );
                          exameTipo = _exameController.text;
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(219, 127, 88, 0.53),
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "10/05/2024",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '$exameTipo mg/dl',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(150, 54, 30, 0.829),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 450,
                    child: Text(
                      'Esse resultado está fora dos limites de referência. Consulte seu médico para mais informações.',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(150, 54, 30, 0.829)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 80,
                      width: 450,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: const Text("Editar exame:"),
                                content: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: _exameController,
                                    decoration: InputDecoration(
                                      fillColor: const Color.fromARGB(
                                          190, 223, 223, 223),
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      labelText:
                                          "Valor do exame de ${widget.tipo}",
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          25, 0, 0, 0),
                                      labelStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 152, 152, 152)),
                                    ),
                                  ),
                                )),
                          );
                        },
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(167, 216, 119, 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "14/05/2024",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '105 mg/dl',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(62, 100, 23, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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


// import 'package:app_ye_gestao_de_saude/pages/novo_imc.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(IMCCalculator());
// }

// class IMCCalculator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'IMC Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: IMCPage(),
//     );
//   }
// }

// class IMCPage extends StatefulWidget {
//   const IMCPage({super.key});

//   @override
//   _IMCPageState createState() => _IMCPageState();
// }

// class _IMCPageState extends State<IMCPage> {
//   List<Map<String, dynamic>> imcs = [
//     {"date": "20/02/2024", "imc": 18.5},
//     {"date": "20/02/2024", "imc": 24.9},
//     {"date": "20/02/2024", "imc": 29.5}
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('IMC'),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Color(0xFF697E50),
//           ),
//           onPressed: () {
//             // Adicione ação do botão de voltar aqui
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount:
//             imcs.length + 2, // Adicionando 2 para a mensagem extra e o botão
//         itemBuilder: (context, index) {
//           if (index < imcs.length) {
//             double imcValue = imcs[index]['imc'];
//             String date = imcs[index]['date'];

//             // Verifica se é o último item da lista
//             bool isLastItem = index == imcs.length - 1;

//             // Define a cor de fundo da caixa
//             Color boxColor = isLastItem ? Color(0xFFD89477) : Color(0xFFA7D877);

//             // Define a cor do texto da mensagem
//             Color textColor = isLastItem ? Color(0xFFA31B1B) : Colors.black;

//             // Define a cor do texto do IMC
//             Color imcColor =
//                 (imcValue == 29.5) ? Color(0xFFA31B1B) : Color(0xFF4E653D);

//             return Container(
//               color: boxColor,
//               margin: EdgeInsets.all(10.0),
//               padding: EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Data: $date',
//                           style: TextStyle(
//                               color: Color(0xFF000000))), // Cor da data
//                       Text('$imcValue kg/m²',
//                           style:
//                               TextStyle(color: imcColor)), // Removido 'IMC: '
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           } else if (index == imcs.length) {
//             // Último item: mensagem extra
//             return Container(
//               margin: EdgeInsets.all(10.0),
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//               child: Text(
//                 'Esse resultado está fora dos limites de referência. Consulte seu médico para mais informações.',
//                 style: TextStyle(color: Color(0xFFA31B1B)),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           } else {
//             // Último item: botão
//             return Container(
//               margin: EdgeInsets.only(top: 20.0, bottom: 40.0),
//               alignment: Alignment.bottomCenter,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Adicione ação do botão aqui
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const IMCForm()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(15),
//                   backgroundColor: const Color.fromARGB(
//                       50, 105, 126, 80), // Cor de fundo do botão
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(600),
//                   ),
//                 ),
//                 child: Icon(Icons.add, color: Color(0xFFF5F5F5)),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
