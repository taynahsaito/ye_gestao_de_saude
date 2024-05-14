import 'package:app_ye_gestao_de_saude/pages/pressao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ye_gestao_de_saude/pages/home_page.dart';

class NovaPressao extends StatefulWidget {
  const NovaPressao({Key? key}) : super(key: key);

  @override
  State<NovaPressao> createState() => _NovaPressaoState();
}

class _NovaPressaoState extends State<NovaPressao> {
  final databaseReference = FirebaseDatabase.instance.ref().child('pressoes');
  final _formKey = GlobalKey<FormState>();
  final _dataController = TextEditingController();
  final _sistolicaController = TextEditingController();
  final _diastolicaController = TextEditingController();
  final List<String> _pressaoData = [];

  @override
  void dispose() {
    _dataController.dispose();
    _sistolicaController.dispose();
    _diastolicaController.dispose();
    super.dispose();
  }

  Future<void> _definePressao() async {
    await databaseReference.push().set({
      'diastólica': _diastolicaController.text,
      'sistólica': _sistolicaController.text,
      'data': _dataController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.pushReplacementNamed(
    //   context,
    //   '/pressao',
    //   arguments: {
    //     "data": _dataController.value.text,
    //     "sistólica": _sistolicaController.value.text,
    //     //"diastólica"; _diastolicaController.value.text,
    //   }
    // );

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
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // const SizedBox(height: 20),
              const Text(
                'Registre sua pressão',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(220, 105, 126, 80),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                      controller: _dataController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a data da aferição';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Pressão sistólica",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(220, 105, 126, 80),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _sistolicaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a pressão sistólica';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Pressão diastólica",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(220, 105, 126, 80),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _diastolicaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a pressão diastólica';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28.0),
              //     Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child:

              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          //_pressaoData.add('Data: ${_dataController.text}, Sistólica: ${_sistolicaController.text}, Diastólica: ${_diastolicaController.text}');
                          _definePressao();
                          _dataController.clear();
                          _sistolicaController.clear();
                          _diastolicaController.clear();
                        });
                      }
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
              //child: ElevatedButton(
              //onPressed: () {

              //},
              //style:backgroundColor: const Color.fromARGB(
              //      50, 105, 126, 80),
              //child: const Icon(Icons.add),
              //),
              const SizedBox(height: 40),
              ..._pressaoData.map((item) => Text(item)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
