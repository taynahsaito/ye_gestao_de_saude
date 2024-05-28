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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            const Center(
              child: Text("Sobre Nós",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(220, 105, 126, 80),
              )),
            ),
            const SizedBox(height: 50,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(170, 105, 126, 80),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: const Text("Nós somos o Minha Saúde em Dia, um aplicativo desenvolvido para melhorar a gestão da sua própria saúde e melhorar sua qualidade de vida.Você pode adicionar lembretes de suas consultas, colocar um resumo delas, definir horários de seus medicamentos com apenas quatro informações, organizar os resultados de seus exames, bem como armazenar o resultado deles, e muito mais.",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            height: 2,
                            
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  "Sua saúde em suas mãos!!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic ),
                ),
              ),
            )
          ]
        )
      )
    );
  }
}