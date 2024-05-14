import 'package:app_ye_gestao_de_saude/pages/novo_imc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(IMCCalculator());
}

class IMCCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCPage(),
    );
  }
}

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  _IMCPageState createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  List<Map<String, dynamic>> imcs = [
    {"date": "20/02/2024", "imc": 18.5},
    {"date": "20/02/2024", "imc": 24.9},
    {"date": "20/02/2024", "imc": 29.5}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF697E50),
          ),
          onPressed: () {
            // Adicione ação do botão de voltar aqui
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount:
            imcs.length + 2, // Adicionando 2 para a mensagem extra e o botão
        itemBuilder: (context, index) {
          if (index < imcs.length) {
            double imcValue = imcs[index]['imc'];
            String date = imcs[index]['date'];

            // Verifica se é o último item da lista
            bool isLastItem = index == imcs.length - 1;

            // Define a cor de fundo da caixa
            Color boxColor = isLastItem ? Color(0xFFD89477) : Color(0xFFA7D877);

            // Define a cor do texto da mensagem
            Color textColor = isLastItem ? Color(0xFFA31B1B) : Colors.black;

            // Define a cor do texto do IMC
            Color imcColor =
                (imcValue == 29.5) ? Color(0xFFA31B1B) : Color(0xFF4E653D);

            return Container(
              color: boxColor,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Data: $date',
                          style: TextStyle(
                              color: Color(0xFF000000))), // Cor da data
                      Text('$imcValue kg/m²',
                          style:
                              TextStyle(color: imcColor)), // Removido 'IMC: '
                    ],
                  ),
                ],
              ),
            );
          } else if (index == imcs.length) {
            // Último item: mensagem extra
            return Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                'Esse resultado está fora dos limites de referência. Consulte seu médico para mais informações.',
                style: TextStyle(color: Color(0xFFA31B1B)),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            // Último item: botão
            return Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 40.0),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Adicione ação do botão aqui
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IMCForm()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: const Color.fromARGB(
                      50, 105, 126, 80), // Cor de fundo do botão
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(600),
                  ),
                ),
                child: Icon(Icons.add, color: Color(0xFFF5F5F5)),
              ),
            );
          }
        },
      ),
    );
  }
}
