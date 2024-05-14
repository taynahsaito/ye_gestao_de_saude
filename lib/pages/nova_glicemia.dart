import 'package:flutter/material.dart';

void main() {
  runApp(GlicemiaApp());
}

class GlicemiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: NovaGlicemia(),
    );
  }
}

class NovaGlicemia extends StatefulWidget {
  const NovaGlicemia({super.key});

  @override
  _NovaGlicemiaState createState() => _NovaGlicemiaState();
}

class _NovaGlicemiaState extends State<NovaGlicemia> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _glicemia = '';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Registre sua Glicemia',
                  style: TextStyle(
                    color: Color(0xFF697E50),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              const Text(
                "Glicemia (em mg/dL)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua glicemia';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _glicemia = value;
                  }
                },
              ),
              SizedBox(height: 20.0),
              const Text(
                "Data da aferição",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma data';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  setState(() {
                    _selectedDate = DateTime.tryParse(value);
                  });
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _formKey.currentState!.reset();
                      setState(() {
                        _selectedDate = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      // padding: const EdgeInsets.(15),
                      backgroundColor: const Color.fromARGB(
                          50, 105, 126, 80), // Cor de fundo do botão
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.close),
                  ),
                  SizedBox(width: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //     _formKey.currentState!.reset();
                  //     setState(() {
                  //       _selectedDate = null;
                  //     });
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     // padding: const EdgeInsets.(15),
                  //     backgroundColor: const Color.fromARGB(
                  //         50, 105, 126, 80), // Cor de fundo do botão
                  //     foregroundColor: Colors.white,
                  //     shape: const CircleBorder(),
                  //   ),
                  //   child: const Icon(Icons.close),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_selectedDate != null) {
                          // Aqui você pode salvar os dados em um banco de dados
                          // ou enviá-los para onde desejar
                          print('Glicemia: $_glicemia, Data: $_selectedDate');
                          // Exemplo de como limpar o formulário depois de enviar
                          _formKey.currentState!.reset();
                          setState(() {
                            _selectedDate = null;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Por favor, insira uma data válida'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // padding: const EdgeInsets.(15),
                      backgroundColor: const Color.fromARGB(
                          50, 105, 126, 80), // Cor de fundo do botão
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
