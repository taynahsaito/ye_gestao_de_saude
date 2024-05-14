import 'package:flutter/material.dart';

class NovoPesoAltura extends StatefulWidget {
  const NovoPesoAltura({super.key});

  @override
  State<NovoPesoAltura> createState() => _NovoPesoAlturaState();
}

class _NovoPesoAlturaState extends State<NovoPesoAltura> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 246, 241),
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Registre novo peso e altura',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(220, 105, 126, 80),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Peso",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(220, 105, 126, 80),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _pesoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o peso';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    const Text(
                      "Altura",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(220, 105, 126, 80),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _alturaController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a altura';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 40),
              // const Text(
              // "Altura",
              // style: TextStyle(
              //   fontSize: 18,
              //   fontWeight: FontWeight.w600,
              //   color: Color.fromARGB(220, 105, 126, 80),
              // ),
              //                   ),
              //                   const SizedBox(height: 10),
              //                   TextFormField(
              // controller: _alturaController,
              // decoration: InputDecoration(
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(40.0),
              //   ),
              // ),
              // keyboardType: TextInputType.number,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Por favor, insira a altura';
              //   }
              //   return null;
              // },
              //                   ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // const Icon(
                    //   Icons.send,
                    //   size: 30.0,),
                    style: ElevatedButton.styleFrom(
                      // fixedSize: Size.fromRadius(15),

                      // padding: const EdgeInsets.(15),
                      backgroundColor: const Color.fromARGB(
                          50, 105, 126, 80), // Cor de fundo do botão
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aqui você pode atualizar os dados do paciente
                        _pesoController.clear();
                        _alturaController.clear();
                      }
                      // if (_formKey.currentState!.validate()) {
                      //     setState(() {
                      //       _pressaoData.add('Data: ${_dataController.text}, Sistólica: ${_sistolicaController.text}, Diastólica: ${_diastolicaController.text}');
                      //       _dataController.clear();
                      //       _sistolicaController.clear();
                      //       _diastolicaController.clear();
                      //     });
                      //   }
                    },
                    style: ElevatedButton.styleFrom(
                      // padding: const EdgeInsets.all(15),
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
