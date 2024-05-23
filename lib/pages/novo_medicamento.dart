import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovoMedicamento extends StatefulWidget {
  const NovoMedicamento({super.key});

  @override
  State<NovoMedicamento> createState() => _NovoMedicamentoState();
}

class _NovoMedicamentoState extends State<NovoMedicamento> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _horarioController = TextEditingController();
  final _intervaloController = TextEditingController();
  // final _periodoController = TextEditingController();
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
  void dispose() {
    _nomeController.dispose();
    _horarioController.dispose();
    _intervaloController.dispose();
    // _periodoController.dispose();
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
            const Padding(
              padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: const Text(
                'Cadastre um novo medicamento',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(220, 105, 126, 80),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Nome do medicamento:",
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
                        controller: _nomeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(220, 105, 126, 80)),
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 152, 152, 152)),
                          //quando clica na label
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(220, 105, 126, 80)),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do medicamento';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Horário:",
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
                        controller: _horarioController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(220, 105, 126, 80)),
                              borderRadius: BorderRadius.circular(20)),

                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                            return 'Por favor, insira o horário';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Intervalo de horas",
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
                        controller: _intervaloController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(220, 105, 126, 80)),
                              borderRadius: BorderRadius.circular(20)),

                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                            return 'Por favor, insira o intervalo de horas';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      "Período de dias em que o medicamento será tomado:",
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
                        // readOnly: true,
                        // onTap: () => _selectDate(context),
                        // controller: TextEditingController(
                        //   text: _selectedDate != null
                        //       ? _dateFormat.format(_selectedDate!)
                        //       : '',
                        // ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(220, 105, 126, 80)),
                              borderRadius: BorderRadius.circular(20)),

                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                            return 'Por favor, digite o período de dias que o medicamento será tomado';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
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
                      _nomeController.clear();
                      _horarioController.clear();
                      _intervaloController.clear();
                      // _periodoController.clear();
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
