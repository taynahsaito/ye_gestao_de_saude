import 'package:app_ye_gestao_de_saude/models/glicemia_model.dart';
import 'package:app_ye_gestao_de_saude/pages/glicemia.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ye_gestao_de_saude/services/glicemia_service.dart';
import 'package:uuid/uuid.dart';

class NovaGlicemia extends StatefulWidget {
  const NovaGlicemia({Key? key}) : super(key: key);

  @override
  State<NovaGlicemia> createState() => _NovaGlicemiaState();
}

class _NovaGlicemiaState extends State<NovaGlicemia> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _glicemiaController = TextEditingController();
  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final List<String> _glicemiaData = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: const Color.fromARGB(220, 105, 126, 80),
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

  final GlicemiaService adicionarGlicemia = GlicemiaService();

  glicemiaAdicionar() {
    String glicemia = _glicemiaController.text;
    String data = _dateFormat.format(_selectedDate!);

    ModeloGlicemia modeloGlicemia = ModeloGlicemia(
        id: const Uuid().v1(), glicemia: glicemia, dataAfericao: data);
    adicionarGlicemia.adicionarGlicemia(modeloGlicemia);
  }
  // Future<void> _saveDataToFirestore() async {
  //   if (_formKey.currentState != null && _formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     if (_selectedDate != null) {
  //       ModeloGlicemia novaGlicemia = ModeloGlicemia(
  //         glicemia: _glicemia,
  //         dataAfericao: _selectedDate!,
  //       );
  //       await _glicemiaService.adicionarGlicemia(novaGlicemia);
  //       _formKey.currentState!.reset();
  //       setState(() {
  //         _selectedDate = null;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Dados de glicemia salvos com sucesso'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Por favor, insira uma data válida'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(220, 105, 126, 80),
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
        padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Registre sua glicemia',
                  style: TextStyle(
                    color: Color(0xFF697E50),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Glicemia (em mg/dL):",
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
                  controller: _glicemiaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(220, 105, 126, 80)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 152, 152, 152),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(220, 105, 126, 80)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua glicemia';
                    }
                    return null;
                  },
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 152, 152, 152),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(220, 105, 126, 80)),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _formKey.currentState!.reset();
                      setState(() {
                        _selectedDate = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: const Color.fromARGB(50, 105, 126, 80),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.close),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          glicemiaAdicionar();
                          _selectedDate = null;
                          _glicemiaController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(50, 105, 126, 80),
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
              ..._glicemiaData.map((item) => Text(item)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
