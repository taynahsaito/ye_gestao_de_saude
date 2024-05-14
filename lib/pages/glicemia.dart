import 'package:app_ye_gestao_de_saude/pages/nova_glicemia.dart';
import 'package:flutter/material.dart';

class Glicemia extends StatefulWidget {
  const Glicemia({super.key});

  @override
  State<Glicemia> createState() => _GlicemiaState();
}

class _GlicemiaState extends State<Glicemia> {
  final List<Map<String, dynamic>> glicemias = [
    {"date": "20/02/2024", "value": 79},
    {"date": "15/12/2023", "value": 105},
    {"date": "14/11/2023", "value": 79},
    {"date": "29/07/2023", "value": 105},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        title: Text(
          'Glicemia',
          style: TextStyle(color: Color(0xFF697E50)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF697E50)),
          onPressed: () {
            // Adicione ação do botão de voltar aqui
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: glicemias.length * 2 +
            1, // Adicionando 2 para as mensagens extra e 1 para o botão de adicionar
        itemBuilder: (context, index) {
          if (index.isOdd) {
            // Índices ímpares para mensagens extra
            final dataIndex = index ~/ 2;
            final glicemia = glicemias[dataIndex];
            final value = glicemia['value'];

            // Verifica se o valor está fora dos limites de referência
            bool isOutOfRange = (value < 70 || value > 100);

            if (isOutOfRange) {
              return Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  'Esse resultado está fora dos limites de referência. Consulte seu médico para mais informações.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFA31B1B)),
                ),
              );
            } else {
              return SizedBox(); // Retorna um widget vazio para os índices ímpares
            }
          } else if (index == glicemias.length * 2) {
            // Último índice: botão de adicionar
            return Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NovaGlicemia()),
                    );
                  },
                  backgroundColor: Color(0xFF697E50),
                  shape: const CircleBorder(),
                  child: Icon(Icons.add, color: Color(0xFFF5F5F5)),
                ),
              ),
            );
          } else {
            // Índices pares para os valores de glicemia
            final dataIndex = index ~/ 2;
            final glicemia = glicemias[dataIndex];
            final date = glicemia['date'];
            final value = glicemia['value'];

            // Verifica se o valor está fora dos limites de referência
            bool isOutOfRange = (value < 70 || value > 100);

            // Define a cor de fundo da caixa
            Color boxColor =
                isOutOfRange ? Color(0xFFD89477) : Color(0xFFA7D877);
            // Define a cor do valor da glicemia
            Color valueColor =
                value == 79 ? Color(0xFF697E50) : Color(0xFFA31B1B);

            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              padding: EdgeInsets.all(10.0),
              color: boxColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data: $date',
                    style: TextStyle(color: Color(0xFF000000)), // Cor preta
                  ),
                  Text(
                    '$value mg/dL',
                    style: TextStyle(
                      color: valueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
