import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(IMCCalculator());
}

class IMCCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        primaryColor: Colors.white, // Cor branca para o texto
      ),
      home: IMCForm(),
    );
  }
}

class IMCForm extends StatefulWidget {
  const IMCForm({super.key});

  @override
  _IMCFormState createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _alturaController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cadastrar novo IMC',
            style: TextStyle(color: Color(0xFF697E50)), // Cor verde #697E50
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20), // Espaço adicionado acima do formulário

              // const Text(
              //   "Altura (em metros)",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600,
              //     color: Color.fromARGB(220, 105, 126, 80),
              //   ),
              // ),
              TextFormField(
                controller: _alturaController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(
                  color: Color(0xFF697E50), // Cor verde #697E50
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a altura';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Altura (metros)',
                  labelStyle:
                      TextStyle(color: Color(0xFF697E50)), // Cor verde #697E50
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _pesoController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(
                  color: Color(0xFF697E50), // Cor verde #697E50
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o peso';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle:
                      TextStyle(color: Color(0xFF697E50)), // Cor verde #697E50
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _dataController,
                keyboardType: TextInputType.datetime,
                style: TextStyle(
                  color: Color(0xFF697E50), // Cor verde #697E50
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data da aferição';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Data da Aferição',
                  labelStyle:
                      TextStyle(color: Color(0xFF697E50)), // Cor verde #697E50
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveData(true); // Envie "true" para indicar "Certo"
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // fixedSize: Size.fromRadius(15),

                      // padding: const EdgeInsets.(15),
                      backgroundColor: const Color.fromARGB(
                          50, 105, 126, 80), // Cor de fundo do botão
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: Icon(
                        Icons.check), // Ícone de certo com cor verde #697E50
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _saveData(false); // Envie "false" para indicar "Errado"
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // fixedSize: Size.fromRadius(15),

                      // padding: const EdgeInsets.(15),
                      backgroundColor: const Color.fromARGB(
                          50, 105, 126, 80), // Cor de fundo do botão
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: Icon(
                        Icons.close), // Ícone de errado com cor verde #697E50
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
