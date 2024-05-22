import 'package:app_ye_gestao_de_saude/pages/editar_medicamento.dart';
import 'package:app_ye_gestao_de_saude/pages/novo_medicamento.dart';
import 'package:flutter/material.dart';

class Medicamentos extends StatefulWidget {
  const Medicamentos({super.key});

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
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
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Medicamentos",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const HistoricoExames(tipo: 'Hemoglobina')),
                    // );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pantoprazol: 8h",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EditarMedicamento()),
                    );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const HistoricoExames(tipo: "Colesterol Total")),
                    // );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Paracetamol: 9h",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                             Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EditarMedicamento()),
                    );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
             Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const NovoMedicamento()),
                    );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor:
                const Color.fromARGB(50, 105, 126, 80), // Cor de fundo do botão
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(600),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}