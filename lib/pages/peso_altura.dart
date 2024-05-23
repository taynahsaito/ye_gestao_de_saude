import 'package:app_ye_gestao_de_saude/pages/novo_peso_altura.dart';
import 'package:flutter/material.dart';

class PesoAltura extends StatefulWidget {
  const PesoAltura({super.key});

  // final List<Pressao> historicoPressao = [];
  // final String pressao
  // const Pressao({Key? key}) : super (key: key);

  @override
  State<PesoAltura> createState() => _PesoAlturaState();
}

class _PesoAlturaState extends State<PesoAltura> {
  @override
  void initState() {
    super.initState();
  }

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Histórico do peso e altura',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(220, 105, 126, 80),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Outros widgets aqui...
                    SizedBox(
                      height: 80,
                      width: 450,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(41, 114, 34, 0.529),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "21/05/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text("75kg",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w900)),
                            Text(
                              '175cm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      width: 450,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(41, 114, 34, 0.529),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "20/05/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text("74.8kg",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w900)),
                            Text(
                              '175cm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      width: 450,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(41, 114, 34, 0.529),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "12/05/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text("74.5kg",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w900)),
                            Text(
                              '175cm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      width: 450,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(41, 114, 34, 0.529),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "1/05/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text("74kg",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w900)),
                            Text(
                              '175cm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 80,
                      width: 450,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(41, 114, 34, 0.529),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "20/04/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "72kg",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '174cm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NovoPesoAltura()),
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
