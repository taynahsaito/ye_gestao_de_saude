import 'package:flutter/material.dart';

class NovoIMC extends StatefulWidget {
  const NovoIMC({super.key});

  @override
  State<NovoIMC> createState() => _NovoIMCState();
}

class _NovoIMCState extends State<NovoIMC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 20), // Espaço adicionado acima do formulário
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registrar novo IMC',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Altura (em metros):",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _alturaController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a altura';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(220, 105, 126,
                                80)), // Altere a cor da borda aqui

                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                    //quando clica na label
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(220, 105, 126,
                                80)), // Altere a cor da borda aqui
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Peso (em kg):",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _pesoController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o peso';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(220, 105, 126, 80)),
                        borderRadius: BorderRadius.circular(20)),

                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                    //quando clica na label
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(220, 105, 126,
                                80)), // Altere a cor da borda aqui
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Data da aferição:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _dataController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data da aferição';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(220, 105, 126, 80)),
                        borderRadius: BorderRadius.circular(20)),

                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                    //quando clica na label
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(220, 105, 126,
                                80)), // Altere a cor da borda aqui
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveData(true); // Envie "true" para indicar "Certo"
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets
                          .zero, // Define o padding do botão como zero para não interferir com o padding do widget interno
                      backgroundColor: const Color.fromARGB(50, 105, 126, 80),
                      foregroundColor: const Color.fromARGB(
                          255, 255, 255, 255), // Cor de fundo do botão
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.all(8), // Espaçamento interno para o ícone
                      child: Icon(Icons.close),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveData(false); // Envie "false" para indicar "Errado"
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          50, 105, 126, 80), // Cor de fundo do botão
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.check),
                    ), // Ícone de errado com cor verde #697E50
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData(bool certo) {
    double altura = double.parse(_alturaController.text);
    double peso = double.parse(_pesoController.text);
    String data = _dataController.text;
    // Agora você pode fazer o que quiser com os dados capturados, como salvá-los em algum lugar
    print('Altura: $altura');
    print('Peso: $peso');
    print('Data: $data');
    if (certo) {
      print('Opção escolhida: Certo');
    } else {
      print('Opção escolhida: Errado');
    }
  }
}
