import 'package:app_ye_gestao_de_saude/models/peso_altura_modelo.dart';
import 'package:app_ye_gestao_de_saude/services/peso_altura_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NovoPesoAltura extends StatefulWidget {
  const NovoPesoAltura({super.key});

  @override
  State<NovoPesoAltura> createState() => _NovoPesoAlturaState();
}

class _NovoPesoAlturaState extends State<NovoPesoAltura> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _selectedDate = null; // Inicializando _selectedDate com a data atual
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            // Personalize a cor de fundo da seleção aqui
            colorScheme: theme.colorScheme.copyWith(
              primary: const Color.fromARGB(
                  220, 105, 126, 80), // Cor de fundo da seleção
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final PesoAlturaService adicionarPesoAltura = PesoAlturaService();

  pesoAlturaAdicionar() {
    String peso = _pesoController.text;
    String altura = _alturaController.text;
    String data = _dateFormat.format(_selectedDate!);

    ModeloPesoAltura modeloPesoAltura = ModeloPesoAltura(
      id: const Uuid().v1(),
      peso: peso,
      altura: altura,
      data: data,
    );

    adicionarPesoAltura.adicionarPesoAltura(modeloPesoAltura);
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Registre novo peso e altura',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(220, 105, 126, 80),
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      controller: TextEditingController(
                        text: _selectedDate != null
                            ? _dateFormat.format(_selectedDate!)
                            : '',
                      ),
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a data da aferição';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o peso';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Altura (em metros):",
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
                      controller: _alturaController,
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a altura';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
                    if (_formKey.currentState!.validate()) {
                      // Aqui você pode atualizar os dados do paciente
                      pesoAlturaAdicionar();
                      _selectedDate = null;
                      _pesoController.clear();
                      _alturaController.clear();
                    }
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
