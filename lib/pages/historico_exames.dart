import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class HistoricoExames extends StatefulWidget {
  final String tipo;

  const HistoricoExames({super.key, required this.tipo});

  @override
  State<HistoricoExames> createState() => _HistoricoExamesState();
}

class _HistoricoExamesState extends State<HistoricoExames> {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Histórico de ${widget.tipo}",
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
                      
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(219, 127, 88, 0.53),
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "10/05/2024",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '$exameTipo mg/dl',
                            style: TextStyle(
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
                      fontSize: 12, color: Color.fromRGBO(150, 54, 30, 0.829)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 80,
                  width: 450,
                  child: GestureDetector(
                    onTap: () {
                      
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
    );
  }
}
