import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovaGlicemia extends StatefulWidget {
  const NovaGlicemia({super.key});

  @override
  State<NovaGlicemia> createState() => _NovaGlicemiaState();
}

class _NovaGlicemiaState extends State<NovaGlicemia> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _glicemia = '';
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
                            const SnackBar(
                              content:
                                  Text('Por favor, insira uma data válida'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
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
      ),
    );
  }
}
