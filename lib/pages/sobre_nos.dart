import 'package:flutter/material.dart';

class SobreNos extends StatefulWidget {
  const SobreNos({super.key});

  @override
  State<SobreNos> createState() => _SobreNosState();
}

class _SobreNosState extends State<SobreNos> {
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
        body: const SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("Sobre nós",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 105, 126, 80),
                )),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromARGB(130, 105, 126, 80),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: SizedBox(
                  width: 500,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        "Nós somos o Minha Saúde em Dia, um aplicativo desenvolvido para melhorar a gestão da sua própria saúde e melhorar sua qualidade de vida. Você pode adicionar lembretes de suas consultas, colocar um resumo delas, definir horários de seus medicamentos com apenas quatro informações, organizar os resultados de seus exames, bem como armazenar o resultado deles, e muito mais.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 2,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Sua saúde em suas mãos!!",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(200, 105, 126, 80),
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic),
              ),
            ),
          )
        ])));
  }
}
